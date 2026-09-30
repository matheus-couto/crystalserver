'use strict';

/**
 * Painel de administracao do CrandoriaOT.
 *
 * Nao expoe o Docker: tudo que mexe em container vai pelo agente do host,
 * que so aceita uma lista fechada de verbos. Nao fala com o servidor de
 * jogo por protocolo nenhum: acoes em jogador entram numa fila no banco que
 * um globalevent em Lua consome - o mesmo desenho do sistema de doacoes.
 */

require('dotenv').config();

const express = require('express');
const mysql = require('mysql2/promise');
const fs = require('fs');
const fsp = require('fs/promises');
const path = require('path');
const crypto = require('crypto');

const auth = require('./auth');
const agent = require('./agent');
const scripts = require('./scripts');
const diff = require('./diff');
const q = require('./queries');
const nomesItens = require('./itemnames');
const v = require('./view');

const PORTA = Number(process.env.PORT || 3100);
const SEGREDO = process.env.PANEL_SECRET || '';
const BACKUP_DB_DIR = process.env.BACKUP_DB_DIR || '/opt/crandoria/backups/db';
const LOG_AUTH = process.env.AUTH_LOG || '/var/log/painel/auth.log';

if (!SEGREDO || SEGREDO.length < 32) {
  console.error('PANEL_SECRET ausente ou curto demais (minimo 32 caracteres). Abortando.');
  process.exit(1);
}

const db = mysql.createPool({
  host: process.env.DB_HOST || 'database',
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  connectionLimit: 6,
  charset: 'utf8mb4',
  // O painel faz agregacao pesada de itens; melhor esperar do que quebrar.
  connectTimeout: 20000,
});

const app = express();

// Atras do Caddy. Confiar em um unico salto e essencial: com `true` qualquer
// um poderia forjar X-Forwarded-For e escapar do bloqueio por IP.
app.set('trust proxy', 1);
app.set('x-powered-by', false);
app.use(express.urlencoded({ extended: false, limit: '8mb' }));

app.use('/estatico', express.static(path.join(__dirname, 'public'), {
  maxAge: '7d',
  index: false,
  dotfiles: 'deny',
  setHeaders: (res) => res.setHeader('Cache-Control', 'public, max-age=604800'),
}));

app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('Referrer-Policy', 'no-referrer');
  res.setHeader('Cache-Control', 'no-store');
  res.setHeader('Content-Security-Policy',
    "default-src 'none'; script-src 'self'; style-src 'self' 'unsafe-inline'; " +
    "form-action 'self'; base-uri 'none'; frame-ancestors 'none'; img-src 'self' data:");
  next();
});

// ------------------------------------------------------------- utilidades

function lerCookie(req, nome) {
  const cru = req.headers.cookie || '';
  for (const parte of cru.split(';')) {
    const [k, ...resto] = parte.trim().split('=');
    if (k === nome) return decodeURIComponent(resto.join('='));
  }
  return null;
}

function ip(req) {
  return (req.ip || '').replace(/^::ffff:/, '');
}

/**
 * Escreve falhas de login num arquivo que o fail2ban observa.
 *
 * Bloquear dentro da aplicacao adia a tentativa; o fail2ban tira o IP no
 * firewall, antes de chegar ao Node.
 */
function logAuth(linha) {
  try {
    fs.mkdirSync(path.dirname(LOG_AUTH), { recursive: true });
    fs.appendFileSync(LOG_AUTH, new Date().toISOString() + ' ' + linha + '\n');
  } catch (_) { /* log nao pode derrubar o login */ }
}

async function auditar(req, action, target, detail) {
  try {
    await db.query(
      'INSERT INTO `panel_audit` (`at`,`username`,`ip`,`action`,`target`,`detail`) VALUES (?,?,?,?,?,?)',
      [Date.now(), req.usuario ? req.usuario.username : '', ip(req),
       String(action).slice(0, 48), String(target || '').slice(0, 255),
       detail ? String(detail).slice(0, 4000) : null]
    );
  } catch (e) {
    console.error('falha ao auditar:', e.message);
  }
}

async function exigirLogin(req, res, next) {
  const sid = lerCookie(req, auth.SESSION_COOKIE);
  const usuario = await auth.sessaoAtual(db, sid, req.headers['user-agent']);
  if (!usuario) {
    res.clearCookie(auth.SESSION_COOKIE);
    return res.redirect('/entrar');
  }
  req.sid = sid;
  req.usuario = usuario;
  req.csrf = auth.csrfToken(sid, SEGREDO);
  next();
}

/** Todo POST precisa do token. Sem ele, outro site poderia agir pela pessoa. */
function exigirCsrf(req, res, next) {
  if (!auth.csrfConfere(req.sid, SEGREDO, req.body._csrf)) {
    return res.status(403).send('Token invalido. Recarregue a pagina e tente de novo.');
  }
  next();
}

function render(req, res, titulo, ativo, corpo, aviso, extras) {
  res.send(v.pagina({ titulo, ativo, usuario: req.usuario.username, corpo, aviso, extras }));
}

/** Guarda um recado para a proxima pagina, via querystring. */
function comAviso(destino, tipo, texto) {
  return destino + (destino.includes('?') ? '&' : '?') +
    'm=' + encodeURIComponent(tipo + '|' + texto);
}

function avisoDaQuery(req) {
  const m = req.query.m;
  if (!m) return null;
  const i = String(m).indexOf('|');
  if (i < 0) return null;
  return { tipo: String(m).slice(0, i), texto: String(m).slice(i + 1).slice(0, 500) };
}

// ------------------------------------------------------------------ login

app.get('/entrar', async (req, res) => {
  const sid = lerCookie(req, auth.SESSION_COOKIE);
  if (sid && await auth.sessaoAtual(db, sid, req.headers['user-agent'])) return res.redirect('/');
  res.send(v.paginaLogin({ erro: req.query.e, aviso: req.query.a }));
});

app.post('/entrar', async (req, res) => {
  const endereco = ip(req);
  const r = await auth.entrar(db, {
    username: req.body.username,
    senha: req.body.senha,
    ip: endereco,
    userAgent: req.headers['user-agent'],
  });

  if (!r.ok) {
    if (r.motivo === 'bloqueado') {
      logAuth(`bloqueado ip=${endereco} user=${String(req.body.username || '').slice(0, 32)}`);
      return res.redirect('/entrar?e=' + encodeURIComponent(
        `Muitas tentativas. Tente de novo em ${Math.ceil(r.esperaSegundos / 60)} min.`));
    }
    logAuth(`falha ip=${endereco} user=${String(req.body.username || '').slice(0, 32)}`);
    return res.redirect('/entrar?e=' + encodeURIComponent('Usuario ou senha invalidos.'));
  }

  logAuth(`ok ip=${endereco} user=${r.user.username}`);
  res.cookie(auth.SESSION_COOKIE, r.sid, {
    httpOnly: true,
    secure: true,
    sameSite: 'strict',
    maxAge: auth.SESSION_TTL_MS,
    path: '/',
  });
  res.redirect('/');
});

app.post('/sair', exigirLogin, async (req, res) => {
  await auth.sair(db, req.sid);
  res.clearCookie(auth.SESSION_COOKIE);
  res.redirect('/entrar?a=' + encodeURIComponent('Voce saiu.'));
});

app.use(exigirLogin);

// --------------------------------------------------------------- visao geral

app.get('/', async (req, res, next) => {
  try {
    const [status, host, stats, resumo, donates, online] = await Promise.all([
      agent.status(), agent.host(), agent.stats(),
      q.resumoServidor(db), q.resumoDonates(db).catch(() => null), q.jogadoresOnline(db),
    ]);

    const servidor = (status.containers || []).find((c) => c.servico === 'server');
    const noAr = servidor && servidor.estado === 'running';

    const h = host.host || {};
    const cartoes = [
      v.cartao('Servidor de jogo',
        noAr ? '<span class="pill ok">no ar</span>' : '<span class="pill erro">fora</span>',
        servidor ? servidor.status : 'container nao encontrado'),
      v.cartao('Jogadores online', v.numero(resumo.online),
        `${v.numero(resumo.personagens)} personagens, ${v.numero(resumo.contas)} contas`),
      v.cartao('Memoria', (h.mem_pct || 0) + '%',
        `${v.numero(h.mem_usada_mb)} de ${v.numero(h.mem_total_mb)} MB`,
        v.barra(h.mem_pct)),
      v.cartao('Disco', (h.disco_pct || 0) + '%',
        `${h.disco_usado_gb} de ${h.disco_total_gb} GB`, v.barra(h.disco_pct, 80)),
      v.cartao('Uso de CPU',
        h.carga ? v.cargaPct(h.carga[0], h.cpus) + '%  ' + v.rotuloCarga(v.cargaPct(h.carga[0], h.cpus)) : '—',
        h.carga
          ? `5 min: ${v.cargaPct(h.carga[1], h.cpus)}%   15 min: ${v.cargaPct(h.carga[2], h.cpus)}%   (${h.cpus} vCPU)`
          : '',
        h.carga ? v.barra(v.cargaPct(h.carga[0], h.cpus), 90) : ''),
      v.cartao('Uptime da maquina', v.duracao(h.uptime_s), ''),
    ].join('');

    const linhasStats = (stats.containers || []).map((c) => `<tr>
      <td class="mono">${v.e(c.nome)}</td>
      <td class="num">${v.e(c.cpu)}</td>
      <td class="num">${v.e(c.mem)}</td>
      <td class="num">${v.e(c.mem_pct)}</td>
      <td class="num mono">${v.e(c.rede)}</td></tr>`).join('');

    const linhasContainers = (status.containers || []).map((c) => {
      const ok = c.estado === 'running';
      const acoes = [
        v.formBotao('/acao/restart', { _csrf: req.csrf, servico: c.servico }, 'Reiniciar',
          { classe: 'btn mini cinza',
            confirmar: `Reiniciar o ${c.servico}?` +
              (c.servico === 'server' && resumo.online
                ? ` Ha ${resumo.online} jogador(es) online, que serao desconectados.` : '') }),
        ok
          ? v.formBotao('/acao/stop', { _csrf: req.csrf, servico: c.servico }, 'Parar',
              { classe: 'btn mini perigo', confirmar: `Parar o ${c.servico}? Ele fica fora do ar ate voce iniciar de novo.` })
          : v.formBotao('/acao/start', { _csrf: req.csrf, servico: c.servico }, 'Iniciar',
              { classe: 'btn mini' }),
      ].join(' ');
      return `<tr><td class="mono">${v.e(c.nome)}</td>
        <td>${ok ? '<span class="pill ok">no ar</span>' : `<span class="pill erro">${v.e(c.estado)}</span>`}</td>
        <td>${v.e(c.status)}</td><td>${acoes}</td></tr>`;
    }).join('');

    const linhasOnline = online.length
      ? online.map((p) => `<tr>
          <td><a href="/jogadores?q=${encodeURIComponent(p.name)}">${v.e(p.name)}</a></td>
          <td class="num">${v.numero(p.level)}</td>
          <td class="num">${v.e(p.account_id)}</td>
          <td>${v.dataHora(p.lastlogin)}</td></tr>`).join('')
      : '<tr><td colspan="4" style="color:var(--fraco)">Ninguem online agora.</td></tr>';

    const blocoDonates = donates ? `
      <h2>Doacoes</h2>
      <div class="grade">
        ${v.cartao('Hoje', v.moeda(donates.hoje.centavos), `${donates.hoje.n} doacao(oes)`)}
        ${v.cartao('30 dias', v.moeda(donates.mes.centavos), `${donates.mes.n} doacao(oes)`)}
        ${v.cartao('Total recebido', v.moeda(donates.total.centavos),
          `${v.numero(donates.total.coins)} coins entregues`)}
        ${v.cartao('Pago, nao creditado',
          donates.aCreditar.n
            ? `<span class="pill alerta">${donates.aCreditar.n}</span>`
            : '<span class="pill ok">0</span>',
          donates.aCreditar.n ? v.moeda(donates.aCreditar.centavos) + ' aguardando' : 'nada pendente')}
      </div>` : '';

    render(req, res, 'Visao geral', '/', `
      <h1>Visao geral</h1>
      <p class="sub">Atualizado em ${v.dataHora(Date.now())}</p>
      <div class="grade">${cartoes}</div>
      ${blocoDonates}
      <h2>Containers</h2>
      <table><thead><tr><th>Container</th><th>Estado</th><th>Ha quanto tempo</th><th>Acoes</th></tr></thead>
        <tbody>${linhasContainers}</tbody></table>
      <h2>Consumo por container</h2>
      <table><thead><tr><th>Container</th><th class="num">CPU</th><th class="num">Memoria</th>
        <th class="num">% mem</th><th class="num">Rede</th></tr></thead>
        <tbody>${linhasStats}</tbody></table>
      <h2>Online agora</h2>
      <table><thead><tr><th>Personagem</th><th class="num">Level</th>
        <th class="num">Conta</th><th>Ultimo login</th></tr></thead>
        <tbody>${linhasOnline}</tbody></table>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

// ------------------------------------------------------------------ acoes

for (const verbo of ['restart', 'stop', 'start']) {
  app.post('/acao/' + verbo, exigirCsrf, async (req, res, next) => {
    try {
      const servico = String(req.body.servico || '');
      const online = verbo === 'restart' && servico === 'server'
        ? (await q.resumoServidor(db)).online : 0;

      const r = await agent[verbo](servico);
      await auditar(req, 'container.' + verbo, servico,
        (r.ok ? 'ok' : 'falhou: ' + (r.erro || r.saida)) +
        (online ? ` (${online} jogador(es) online no momento)` : ''));

      res.redirect(comAviso('/', r.ok ? 'ok' : 'erro',
        r.ok ? `${verbo} do ${servico} concluido.`
             : `Falhou: ${r.erro || r.saida || 'sem detalhe'}`));
    } catch (err) { next(err); }
  });
}

// ------------------------------------------------------------------- logs

app.get('/logs', async (req, res, next) => {
  try {
    const servico = ['server', 'myacc', 'database', 'caddy', 'donate']
      .includes(req.query.s) ? req.query.s : 'server';
    const linhas = Math.min(Math.max(parseInt(req.query.n, 10) || 300, 20), 2000);
    const filtro = String(req.query.f || '');

    const r = await agent.logs(servico, linhas);
    let texto = r.texto || r.erro || '(sem saida)';
    if (filtro) {
      const alvo = filtro.toLowerCase();
      texto = texto.split('\n').filter((l) => l.toLowerCase().includes(alvo)).join('\n')
        || '(nenhuma linha com "' + filtro + '")';
    }

    const opcoes = ['server', 'myacc', 'database', 'caddy', 'donate']
      .map((s) => `<option value="${s}"${s === servico ? ' selected' : ''}>${s}</option>`).join('');

    render(req, res, 'Logs', '/logs', `
      <h1>Logs</h1>
      <p class="sub">Saida dos containers. Erros em vermelho, avisos em amarelo.</p>
      <form class="linha" method="get">
        <select name="s">${opcoes}</select>
        <input name="n" value="${v.e(linhas)}" size="5" title="quantas linhas">
        <input name="f" value="${v.e(filtro)}" placeholder="filtrar (ex: error)" size="24">
        <button class="btn" type="submit">Ver</button>
        <a class="btn cinza" href="/logs?s=${servico}&n=${linhas}&f=error">So erros</a>
        <a class="btn cinza" href="/logs?s=${servico}&n=${linhas}">Limpar filtro</a>
        <a class="btn cinza" href="/logs/baixar?s=${servico}&n=${linhas}${filtro ? '&f=' + encodeURIComponent(filtro) : ''}">Baixar .txt</a>
      </form>
      <pre class="log">${v.colorirLog(texto)}</pre>
      <div class="linha" style="margin-top:10px">
        <a class="btn cinza mini" href="#" id="ir-topo">Ir para o inicio</a>
        <a class="btn cinza mini" href="#" id="ir-fim">Ir para o fim</a>
        <span style="color:var(--fraco);font-size:12px">
          Mostrando as ultimas ${v.numero(linhas)} linhas; a pagina abre no fim.</span>
      </div>
    `, avisoDaQuery(req), v.LOG_HEAD);
  } catch (err) { next(err); }
});

app.get('/logs/baixar', async (req, res, next) => {
  try {
    const servico = ['server', 'myacc', 'database', 'caddy', 'donate']
      .includes(req.query.s) ? req.query.s : 'server';
    const linhas = Math.min(Math.max(parseInt(req.query.n, 10) || 1000, 20), 2000);
    const filtro = String(req.query.f || '');

    const r = await agent.logs(servico, linhas);
    let texto = r.texto || r.erro || '';
    if (filtro) {
      const alvo = filtro.toLowerCase();
      texto = texto.split(/\r?\n/).filter((l) => l.toLowerCase().includes(alvo)).join('\n');
    }

    const carimbo = new Date().toLocaleString('sv-SE', { timeZone: 'America/Sao_Paulo' })
      .replace(/[: ]/g, '-');   // 'sv-SE' da o formato AAAA-MM-DD HH:MM:SS
    const nome = `${servico}-${carimbo}.txt`;
    await auditar(req, 'log.baixado', servico, `${linhas} linhas${filtro ? `, filtro "${filtro}"` : ''}`);
    res.setHeader('Content-Type', 'text/plain; charset=utf-8');
    res.setHeader('Content-Disposition', `attachment; filename="${nome}"`);
    res.send(texto);
  } catch (err) { next(err); }
});

// ---------------------------------------------------------------- scripts

app.get('/scripts', async (req, res, next) => {
  try {
    const area = req.query.a || 'crandoria';
    const rel = String(req.query.p || '');
    const arquivo = req.query.f;

    if (arquivo) {
      const caminho = rel ? rel + '/' + arquivo : arquivo;
      const { texto, mtime } = await scripts.ler(area, caminho);
      const hist = await scripts.historico(area, caminho);

      const linkDiff = (nome) => `/scripts/diff?a=${encodeURIComponent(area)}&p=${encodeURIComponent(rel)}`
        + `&f=${encodeURIComponent(arquivo)}&v=${encodeURIComponent(nome)}`;
      const linhasHist = hist.length
        ? hist.map((h) => `<tr><td>${v.dataHora(h.mtime)}</td>
            <td class="num">${v.tamanho(h.tamanho)}</td>
            <td><a href="${linkDiff(h.nome)}">comparar com a atual</a></td></tr>`).join('')
        : '<tr><td colspan="3" style="color:var(--fraco)">Nenhuma versao anterior guardada.</td></tr>';

      return render(req, res, arquivo, '/scripts', `
        <div class="crumbs"><a href="/scripts?a=${v.e(area)}&p=${encodeURIComponent(rel)}">&larr; ${v.e(rel || 'raiz')}</a></div>
        <h1>${v.e(arquivo)}</h1>
        <p class="sub">Alterado em ${v.dataHora(mtime)}.
          ${caminho.endsWith('.lua') ? 'Ao salvar, a sintaxe e conferida no luajit antes de gravar.' : ''}
          ${hist.length ? `<a href="${linkDiff(hist[0].nome)}">Ver o que mudou desde a ultima versao guardada</a>` : ''}</p>
        ${area === 'config' ? `<div class="aviso">Este arquivo tem a senha do banco e o IP do servidor, que sao
          diferentes da copia do seu computador - edite aqui, nao cole o config.lua local por cima.
          Mudancas so valem depois de reiniciar o servidor.</div>` : ''}
        <form id="form-editor" method="post" action="/scripts/salvar">
          <input type="hidden" name="_csrf" value="${v.e(req.csrf)}">
          <input type="hidden" name="a" value="${v.e(area)}">
          <input type="hidden" name="p" value="${v.e(rel)}">
          <input type="hidden" name="f" value="${v.e(arquivo)}">
          <textarea id="editor" name="conteudo" spellcheck="false"
            data-nome="${v.e(arquivo)}">${v.e(texto)}</textarea>
          <div class="barra-editor">
            <button class="btn" id="btn-salvar" type="submit">Salvar</button>
            <a class="btn cinza" href="/scripts?a=${v.e(area)}&p=${encodeURIComponent(rel)}">Voltar</a>
            <span id="estado-editor"></span>
            <span id="pos-editor"></span>
            <span class="dica">Ctrl+S salva · Ctrl+F busca · Tab indenta</span>
          </div>
        </form>
        <h2>Versoes anteriores</h2>
        <table><thead><tr><th>Guardada em</th><th class="num">Tamanho</th><th></th></tr></thead>
          <tbody>${linhasHist}</tbody></table>
        <p class="sub" style="margin-top:8px">Guardadas em
          <span class="mono">${v.e(scripts.BACKUP_DIR)}</span> no servidor.</p>
      `, avisoDaQuery(req), v.EDITOR_HEAD);
    }

    const { itens, rel: atual } = await scripts.listar(area, rel);
    const pai = atual ? atual.split('/').slice(0, -1).join('/') : null;

    const abas = scripts.AREAS.map((a) =>
      `<a class="btn ${a.chave === area ? '' : 'cinza'} mini" href="/scripts?a=${a.chave}">${v.e(a.rotulo)}</a>`
    ).join(' ') + ' <a class="btn cinza mini" href="/scripts/recentes">&#128337; Alterados recentemente</a>';

    const linhas = [
      atual ? `<tr><td colspan="4"><a href="/scripts?a=${v.e(area)}&p=${encodeURIComponent(pai)}">&larr; voltar</a></td></tr>` : '',
      ...itens.map((i) => {
        const href = i.pasta
          ? `/scripts?a=${v.e(area)}&p=${encodeURIComponent(atual ? atual + '/' + i.nome : i.nome)}`
          : (i.editavel
              ? `/scripts?a=${v.e(area)}&p=${encodeURIComponent(atual)}&f=${encodeURIComponent(i.nome)}`
              : null);
        const nome = href ? `<a href="${href}">${v.e(i.nome)}</a>` : v.e(i.nome);
        return `<tr><td>${i.pasta ? '📁 ' : ''}${nome}</td>
          <td class="num">${i.pasta ? '' : v.tamanho(i.tamanho)}</td>
          <td>${i.pasta ? '' : v.dataHora(i.mtime)}</td>
          <td>${i.pasta || i.editavel ? '' : '<span class="pill frio">nao editavel</span>'}</td></tr>`;
      }),
    ].join('');

    render(req, res, 'Scripts', '/scripts', `
      <h1>Scripts</h1>
      <p class="sub">Navegue, edite e substitua arquivos. Lua passa pelo validador antes de gravar.</p>
      <div class="linha">${abas}</div>
      <div class="crumbs">${v.e('/' + (atual || ''))}</div>
      <table><thead><tr><th>Nome</th><th class="num">Tamanho</th><th>Alterado</th><th></th></tr></thead>
        <tbody>${linhas}</tbody></table>

      <h2>Enviar arquivo</h2>
      <form method="post" action="/scripts/enviar" enctype="multipart/form-data" class="linha">
        <input type="hidden" name="_csrf" value="${v.e(req.csrf)}">
        <input type="hidden" name="a" value="${v.e(area)}">
        <input type="hidden" name="p" value="${v.e(atual)}">
        <input type="file" name="arquivo" required>
        <button class="btn" type="submit">Enviar para esta pasta</button>
      </form>
      <p class="sub">Substitui o arquivo de mesmo nome, guardando a versao anterior.
        Aceita ${[...scripts.EXT_EDITAVEIS].join(', ')}.</p>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

/** Link do editor para um arquivo `a/b/c.lua` de uma area. */
function linkEditor(area, rel) {
  const i = rel.lastIndexOf('/');
  const pasta = i >= 0 ? rel.slice(0, i) : '';
  const nome = i >= 0 ? rel.slice(i + 1) : rel;
  return `/scripts?a=${encodeURIComponent(area)}&p=${encodeURIComponent(pasta)}&f=${encodeURIComponent(nome)}`;
}

app.get('/scripts/recentes', async (req, res, next) => {
  try {
    const periodos = [[1, '24 horas'], [3, '3 dias'], [7, '7 dias'], [30, '30 dias'], [90, '90 dias']];
    const dias = periodos.some(([d]) => d === Number(req.query.dias)) ? Number(req.query.dias) : 7;
    const area = scripts.AREAS.some((a) => a.chave === req.query.area) ? req.query.area : '';
    const busca = String(req.query.q || '').slice(0, 100);

    const { itens, total } = await scripts.recentes({ dias, busca, area });

    // Quem alterou pelo painel: a ultima gravacao de cada arquivo na
    // auditoria. Alteracao feita fora do painel (deploy, scp) nao tem dono.
    const quem = new Map();
    if (itens.length) {
      const [linhas] = await db.query(
        'SELECT `target`,`username`,`at` FROM `panel_audit` WHERE `action` IN (?,?) AND `at` >= ? ORDER BY `id` DESC',
        ['script.editado', 'script.enviado', Date.now() - dias * 86400000 - 120000]
      );
      for (const l of linhas) if (!quem.has(l.target)) quem.set(l.target, l);
    }

    const rotuloArea = (c) => (scripts.AREAS.find((a) => a.chave === c) || {}).rotulo || c;
    const corpo = itens.length ? itens.map((i) => {
      const autor = quem.get(`${i.area}:${i.rel}`);
      // A gravacao e registrada no mesmo instante; se o arquivo mudou depois,
      // quem mexeu por ultimo nao foi o painel.
      const doPainel = autor && Math.abs(Number(autor.at) - i.mtime) < 120000;
      return `<tr>
        <td>${v.dataHora(i.mtime)}</td>
        <td><a href="${linkEditor(i.area, i.rel)}">${v.e(i.rel)}</a></td>
        <td><span class="pill frio">${v.e(rotuloArea(i.area))}</span></td>
        <td>${doPainel ? v.e(autor.username) : '<span style="color:var(--fraco)">fora do painel</span>'}</td>
        <td class="num">${v.tamanho(i.tamanho)}</td></tr>`;
    }).join('') : '<tr><td colspan="5" style="color:var(--fraco)">Nenhum arquivo alterado neste periodo.</td></tr>';

    const opcoesPeriodo = periodos.map(([d, r]) =>
      `<option value="${d}" ${d === dias ? 'selected' : ''}>${r}</option>`).join('');
    const opcoesArea = ['<option value="">todas as areas</option>', ...scripts.AREAS.map((a) =>
      `<option value="${a.chave}" ${a.chave === area ? 'selected' : ''}>${v.e(a.rotulo)}</option>`)].join('');

    render(req, res, 'Alterados recentemente', '/scripts', `
      <div class="crumbs"><a href="/scripts">&larr; Scripts</a></div>
      <h1>Alterados recentemente</h1>
      <p class="sub">Arquivos editaveis que mudaram no periodo, do mais novo para o mais velho.
        Clique para abrir no editor; la, "comparar com a atual" mostra o que mudou em cada versao guardada.</p>
      <form method="get" action="/scripts/recentes" class="linha">
        <select name="dias">${opcoesPeriodo}</select>
        <select name="area">${opcoesArea}</select>
        <input type="search" name="q" value="${v.e(busca)}" placeholder="filtrar por nome ou pasta">
        <button class="btn mini" type="submit">Filtrar</button>
      </form>
      <table><thead><tr><th>Alterado</th><th>Arquivo</th><th>Area</th><th>Por</th>
        <th class="num">Tamanho</th></tr></thead><tbody>${corpo}</tbody></table>
      ${total > itens.length ? `<p class="sub" style="margin-top:8px">Mostrando ${itens.length} de ${total}.
        Diminua o periodo ou filtre pelo nome.</p>` : ''}
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

app.get('/scripts/diff', async (req, res, next) => {
  try {
    const area = String(req.query.a || 'crandoria');
    const rel = String(req.query.p || '');
    const arquivo = String(req.query.f || '');
    const versao = String(req.query.v || '');
    const caminho = rel ? rel + '/' + arquivo : arquivo;

    const atual = await scripts.ler(area, caminho);
    const antiga = await scripts.lerBackup(area, caminho, versao);
    const r = diff.trechos(antiga.texto, atual.texto, 3);
    const voltar = `/scripts?a=${encodeURIComponent(area)}&p=${encodeURIComponent(rel)}&f=${encodeURIComponent(arquivo)}`;

    let corpo;
    if (!r) {
      corpo = `<div class="aviso">As duas versoes sao diferentes demais para listar linha a linha
        (mais de ${diff.MAX_EDICOES} linhas mudaram).</div>`;
    } else if (!r.trechos.length) {
      corpo = '<div class="aviso ok">As duas versoes sao iguais.</div>';
    } else {
      const classe = (t) => (t === '+' ? 'da' : t === '-' ? 'dr' : 'di');
      corpo = r.trechos.map((t) => `<table class="diff"><tbody>${t.map((o) => `<tr class="${classe(o.t)}">`
        + `<td class="n">${o.a || ''}</td><td class="n">${o.b || ''}</td>`
        + `<td class="s">${o.t === ' ' ? '' : o.t}</td><td class="t">${v.e(o.texto)}</td></tr>`).join('')}</tbody></table>`).join('');
    }

    render(req, res, 'Comparar ' + arquivo, '/scripts', `
      <style>
        table.diff{font-family:Consolas,"Courier New",monospace;font-size:12px;margin-bottom:14px;
          border:1px solid var(--linha);border-collapse:collapse;width:100%;table-layout:fixed}
        table.diff td{padding:1px 6px;border:0;vertical-align:top}
        table.diff td.n{width:52px;text-align:right;color:var(--fraco);user-select:none}
        table.diff td.s{width:14px;user-select:none}
        table.diff td.t{white-space:pre-wrap;word-break:break-all}
        table.diff tr.da{background:rgba(74,169,108,.14)} table.diff tr.da td.s{color:var(--ok)}
        table.diff tr.dr{background:rgba(207,90,90,.14)} table.diff tr.dr td.s{color:var(--erro)}
      </style>
      <div class="crumbs"><a href="${voltar}">&larr; ${v.e(arquivo)}</a></div>
      <h1>O que mudou em ${v.e(arquivo)}</h1>
      <p class="sub">De <b>${v.dataHora(antiga.mtime)}</b> (versao guardada) para
        <b>${v.dataHora(atual.mtime)}</b> (atual).
        ${r ? `<span style="color:var(--ok)">+${r.adicionadas}</span> /
          <span style="color:var(--erro)">-${r.removidas}</span> linhas.` : ''}</p>
      ${corpo}
      <p><a class="btn cinza mini" href="${voltar}">Abrir no editor</a></p>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

app.post('/scripts/salvar', exigirCsrf, async (req, res, next) => {
  try {
    const { a, p, f, conteudo } = req.body;
    const caminho = p ? p + '/' + f : f;
    const r = await scripts.gravar(a, caminho, String(conteudo == null ? '' : conteudo));

    const destino = `/scripts?a=${encodeURIComponent(a)}&p=${encodeURIComponent(p || '')}&f=${encodeURIComponent(f)}`;
    if (!r.ok) {
      await auditar(req, 'script.recusado', `${a}:${caminho}`, r.erro);
      return res.redirect(comAviso(destino, 'erro',
        'Nao gravei: o arquivo tem erro de sintaxe. ' + r.erro));
    }

    scripts.esquecerRecentes();
    await auditar(req, 'script.editado', `${a}:${caminho}`,
      `${r.bytes} bytes; anterior em ${r.backup || '(arquivo novo)'}`);
    res.redirect(comAviso(destino, 'ok',
      'Salvo. Reinicie o servidor para o script entrar em vigor.'));
  } catch (err) { next(err); }
});

// Upload multipart sem dependencia: o corpo e pequeno e o formato e simples.
app.post('/scripts/enviar', express.raw({ type: 'multipart/form-data', limit: '8mb' }),
  async (req, res, next) => {
    try {
      const ct = req.headers['content-type'] || '';
      const m = /boundary=(?:"([^"]+)"|([^;]+))/i.exec(ct);
      if (!m) return res.status(400).send('requisicao malformada');
      const boundary = '--' + (m[1] || m[2]).trim();

      const partes = {};
      let arquivo = null;
      const buf = req.body;
      let pos = buf.indexOf(boundary);
      while (pos >= 0) {
        const inicio = pos + boundary.length;
        if (buf.slice(inicio, inicio + 2).toString() === '--') break;
        const fimCab = buf.indexOf('\r\n\r\n', inicio);
        if (fimCab < 0) break;
        const cab = buf.slice(inicio, fimCab).toString('utf8');
        const prox = buf.indexOf(boundary, fimCab);
        if (prox < 0) break;
        const corpo = buf.slice(fimCab + 4, prox - 2);

        const nomeCampo = /name="([^"]*)"/i.exec(cab);
        const nomeArq = /filename="([^"]*)"/i.exec(cab);
        if (nomeArq && nomeArq[1]) {
          arquivo = { nome: path.basename(nomeArq[1]), dados: corpo };
        } else if (nomeCampo) {
          partes[nomeCampo[1]] = corpo.toString('utf8');
        }
        pos = prox;
      }

      req.sid = req.sid || lerCookie(req, auth.SESSION_COOKIE);
      if (!auth.csrfConfere(req.sid, SEGREDO, partes._csrf)) {
        return res.status(403).send('Token invalido. Recarregue a pagina.');
      }
      if (!arquivo) return res.status(400).send('nenhum arquivo enviado');

      const area = partes.a || 'crandoria';
      const pasta = partes.p || '';
      const destinoPagina = `/scripts?a=${encodeURIComponent(area)}&p=${encodeURIComponent(pasta)}`;
      const caminho = pasta ? pasta + '/' + arquivo.nome : arquivo.nome;

      const r = await scripts.gravar(area, caminho, arquivo.dados.toString('utf8'));
      if (!r.ok) {
        await auditar(req, 'script.recusado', `${area}:${caminho}`, r.erro);
        return res.redirect(comAviso(destinoPagina, 'erro',
          `Recusei ${arquivo.nome}: ${r.erro}`));
      }
      scripts.esquecerRecentes();
      await auditar(req, 'script.enviado', `${area}:${caminho}`,
        `${r.bytes} bytes; anterior em ${r.backup || '(arquivo novo)'}`);
      res.redirect(comAviso(destinoPagina, 'ok',
        `${arquivo.nome} enviado. Reinicie o servidor para valer.`));
    } catch (err) { next(err); }
  });

// ------------------------------------------------------------------ itens

app.get('/itens', async (req, res, next) => {
  try {
    const jogador = parseInt(req.query.jogador, 10);
    const { online } = await q.frescorDosItens(db);

    // O campo aceita id ou nome. Numero vai direto; texto vira busca no
    // items.xml, e se der um resultado so, abre ele em vez de listar.
    const busca = String(req.query.item || '').trim();
    let item = /^\d+$/.test(busca) ? parseInt(busca, 10) : NaN;
    let candidatos = [];
    if (busca && !Number.isInteger(item)) {
      candidatos = await nomesItens.buscar(busca, 60);
      if (candidatos.length === 1) item = candidatos[0].id;
    }

    const avisoFrescor = online
      ? `<div class="aviso">Estes numeros vem do banco, que so recebe o inventario de
         quem esta <b>offline</b>. Ha ${online} jogador(es) online agora, cujos itens ainda
         estao na memoria do servidor. Para um retrato exato, confira com o servidor vazio.</div>`
      : `<div class="aviso ok">Ninguem online: os numeros abaixo refletem o estado real.</div>`;

    if (Number.isInteger(jogador)) {
      const itens = await q.itensDoJogador(db, jogador);
      const [[p]] = await db.query('SELECT `name`,`level`,`account_id` FROM `players` WHERE `id`=?', [jogador]);
      const nomes = await nomesItens.nomes(itens.map((i) => i.itemtype));
      const linhas = itens.length ? itens.map((i) => `<tr>
        <td class="num mono"><a href="/itens?item=${i.itemtype}">${i.itemtype}</a></td>
        <td>${nomes.get(i.itemtype) ? v.e(nomes.get(i.itemtype)) : '<span style="color:var(--fraco)">—</span>'}</td>
        <td class="num">${v.numero(i.total)}</td>
        <td class="num">${v.numero(i.inventario)}</td>
        <td class="num">${v.numero(i.depot)}</td>
        <td class="num">${v.numero(i.inbox)}</td>
        <td class="num">${v.numero(i.pilhas)}</td></tr>`).join('')
        : '<tr><td colspan="7" style="color:var(--fraco)">Nenhum item salvo.</td></tr>';

      return render(req, res, 'Itens do jogador', '/itens', `
        <div class="crumbs"><a href="/itens">&larr; Itens</a></div>
        <h1>${v.e(p ? p.name : 'Jogador ' + jogador)}</h1>
        <p class="sub">${p ? `Level ${v.numero(p.level)} · conta ${v.e(p.account_id)}` : ''} ·
          ${itens.length} tipo(s) de item</p>
        ${avisoFrescor}
        <table><thead><tr><th class="num">Id</th><th>Item</th><th class="num">Total</th>
          <th class="num">Inventario</th><th class="num">Depot</th><th class="num">Inbox</th>
          <th class="num">Pilhas</th></tr></thead><tbody>${linhas}</tbody></table>
      `, avisoDaQuery(req));
    }

    if (Number.isInteger(item)) {
      const donos = await q.donosDoItem(db, item);
      const total = donos.reduce((s, d) => s + Number(d.total), 0);
      const linhas = donos.length ? donos.map((d) => {
        const pct = total ? Math.round(Number(d.total) * 100 / total) : 0;
        return `<tr>
          <td>${d.name ? `<a href="/itens?jogador=${d.player_id}">${v.e(d.name)}</a>`
                       : `<span style="color:var(--fraco)">(id ${v.e(d.player_id)}, sem personagem)</span>`}</td>
          <td class="num">${v.numero(d.level)}</td>
          <td class="num">${v.e(d.account_id)}</td>
          <td class="num">${v.numero(d.total)}</td>
          <td class="num">${pct}%</td>
          <td class="num">${v.numero(d.inventario)}</td>
          <td class="num">${v.numero(d.depot)}</td>
          <td class="num">${v.numero(d.inbox)}</td></tr>`;
      }).join('') : '<tr><td colspan="8" style="color:var(--fraco)">Ninguem tem este item salvo.</td></tr>';

      const nomeItem = await nomesItens.nome(item);
      return render(req, res, nomeItem || ('Item ' + item), '/itens', `
        <div class="crumbs"><a href="/itens">&larr; Itens</a></div>
        <h1>${nomeItem ? v.e(nomeItem) : 'Item ' + v.e(item)}</h1>
        <p class="sub">id ${v.e(item)} · ${v.numero(total)} unidades no total,
          com ${donos.length} jogador(es)</p>
        ${avisoFrescor}
        <table><thead><tr><th>Jogador</th><th class="num">Level</th><th class="num">Conta</th>
          <th class="num">Total</th><th class="num">% do estoque</th>
          <th class="num">Inv.</th><th class="num">Depot</th><th class="num">Inbox</th>
        </tr></thead><tbody>${linhas}</tbody></table>
      `, avisoDaQuery(req));
    }

    if (candidatos.length > 1) {
      const linhas = candidatos.map((c) => `<tr>
        <td class="num mono"><a href="/itens?item=${c.id}">${c.id}</a></td>
        <td><a href="/itens?item=${c.id}">${v.e(c.nome)}</a></td></tr>`).join('');
      return render(req, res, 'Busca', '/itens', `
        <div class="crumbs"><a href="/itens">&larr; Itens</a></div>
        <h1>${candidatos.length} itens com "${v.e(busca)}"</h1>
        <p class="sub">Clique para ver quem tem.</p>
        <table><thead><tr><th class="num">Id</th><th>Nome</th></tr></thead>
          <tbody>${linhas}</tbody></table>
      `, avisoDaQuery(req));
    }

    if (busca && !candidatos.length && !Number.isInteger(item)) {
      return render(req, res, 'Busca', '/itens', `
        <div class="crumbs"><a href="/itens">&larr; Itens</a></div>
        <h1>Nada com "${v.e(busca)}"</h1>
        <p class="sub">Nenhum item do items.xml tem esse nome. Tente um pedaco
          menor, ou informe o id.</p>
      `, avisoDaQuery(req));
    }

    const [ranking, espalhados] = await Promise.all([
      q.rankingItens(db, 100, 2),
      q.itensEspalhadosPorConta(db, 30),
    ]);

    const nomesRank = await nomesItens.nomes(ranking.map((r) => r.itemtype));
    const linhasRank = ranking.map((r) => {
      // Um item concentrado num jogador so e suspeito quando ha mais de um
      // dono possivel. Item que so uma pessoa tem da 100% por definicao.
      const suspeito = r.concentracao >= 90 && r.donos > 1 && r.total >= 100;
      const nome = nomesRank.get(r.itemtype);
      return `<tr>
        <td class="num mono"><a href="/itens?item=${r.itemtype}">${r.itemtype}</a></td>
        <td>${nome ? `<a href="/itens?item=${r.itemtype}">${v.e(nome)}</a>`
                   : '<span style="color:var(--fraco)">—</span>'}</td>
        <td class="num">${v.numero(r.total)}</td>
        <td class="num">${v.numero(r.donos)}</td>
        <td class="num">${v.numero(r.maior)}</td>
        <td class="num">${r.concentracao}%
          ${suspeito ? ' <span class="pill alerta">concentrado</span>' : ''}</td></tr>`;
    }).join('');

    const nomesEsp = await nomesItens.nomes(espalhados.map((l) => l.itemtype));
    const linhasEsp = espalhados.length ? espalhados.map((l) => `<tr>
      <td class="num">${v.e(l.account_id)}</td>
      <td class="num mono"><a href="/itens?item=${v.e(l.itemtype)}">${v.e(l.itemtype)}</a></td>
      <td>${nomesEsp.get(Number(l.itemtype))
              ? v.e(nomesEsp.get(Number(l.itemtype)))
              : '<span style="color:var(--fraco)">—</span>'}</td>
      <td class="num">${v.numero(l.chars)}</td>
      <td class="num">${v.numero(l.total)}</td></tr>`).join('')
      : '<tr><td colspan="5" style="color:var(--fraco)">Nada espalhado entre chars da mesma conta.</td></tr>';

    render(req, res, 'Itens', '/itens', `
      <h1>Itens</h1>
      <p class="sub">Estoque agregado de inventario, depot e inbox — para achar duplicacao.</p>
      ${avisoFrescor}
      <form class="linha" method="get">
        <input name="item" placeholder="nome ou id do item (ex: crystal coin, 3043)" size="34">
        <button class="btn" type="submit">Procurar</button>
        <a class="btn cinza" href="/jogadores">Buscar por jogador</a>
        <span style="color:var(--fraco);font-size:12px">
          ${v.numero(await nomesItens.total())} nomes carregados do items.xml</span>
      </form>

      <h2>Maiores estoques</h2>
      <p class="sub">A coluna <b>concentracao</b> e a fatia do estoque que esta com um unico
        jogador. Item legitimo se espalha; quando um so responde por quase tudo, vale olhar.</p>
      <table><thead><tr><th class="num">Id</th><th>Item</th><th class="num">Total</th>
        <th class="num">Donos</th><th class="num">Maior detentor</th>
        <th class="num">Concentracao</th></tr></thead><tbody>${linhasRank}</tbody></table>

      <h2>Mesmo item em varios chars da mesma conta</h2>
      <p class="sub">Padrao comum de quem duplica e distribui para nao aparecer no ranking.</p>
      <table><thead><tr><th class="num">Conta</th><th class="num">Id</th><th>Item</th>
        <th class="num">Personagens</th><th class="num">Total</th></tr></thead>
        <tbody>${linhasEsp}</tbody></table>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

// ---------------------------------------------------------------- doacoes

app.get('/donates', async (req, res, next) => {
  try {
    const status = String(req.query.s || '');
    const [resumo, lista, top] = await Promise.all([
      q.resumoDonates(db), q.listarDonates(db, { status, limite: 150 }), q.topDoadores(db, 20),
    ]);

    const classe = (s) => (s === 'CREDITED' ? 'ok'
      : s === 'PAID' ? 'alerta'
      : ['FAILED', 'EXPIRED', 'REFUNDED'].includes(s) ? 'erro' : 'frio');

    const cartoes = [
      v.cartao('Hoje', v.moeda(resumo.hoje.centavos), `${resumo.hoje.n} doacao(oes)`),
      v.cartao('30 dias', v.moeda(resumo.mes.centavos), `${resumo.mes.n} doacao(oes)`),
      v.cartao('Total', v.moeda(resumo.total.centavos), `${v.numero(resumo.total.coins)} coins`),
      v.cartao('Pago sem creditar',
        resumo.aCreditar.n ? `<span class="pill alerta">${resumo.aCreditar.n}</span>` : '0',
        resumo.aCreditar.n ? 'o dinheiro entrou e o jogador nao recebeu' : 'nada pendente'),
    ].join('');

    const porStatus = resumo.porStatus.map((s) => `<tr>
      <td><span class="pill ${classe(s.status)}">${v.e(s.status)}</span></td>
      <td class="num">${v.numero(s.n)}</td>
      <td class="num">${v.moeda(s.centavos)}</td>
      <td class="num">${v.numero(s.coins)}</td></tr>`).join('')
      || '<tr><td colspan="4" style="color:var(--fraco)">Nenhuma transacao ainda.</td></tr>';

    const linhas = lista.length ? lista.map((d) => `<tr>
      <td class="num mono">${v.e(d.id)}</td>
      <td>${v.e(d.player_name)}</td>
      <td class="num">${v.e(d.account_id)}</td>
      <td class="num">${v.moeda(d.amount_cents)}</td>
      <td class="num">${v.numero(d.coins)}</td>
      <td><span class="pill ${classe(d.status)}">${v.e(d.status)}</span></td>
      <td>${v.dataHora(d.created_at)}</td>
      <td>${v.dataHora(d.paid_at)}</td>
      <td style="color:var(--fraco);font-size:12px">${v.e(d.fail_reason)}</td></tr>`).join('')
      : '<tr><td colspan="9" style="color:var(--fraco)">Nenhuma transacao no filtro.</td></tr>';

    const linhasTop = top.length ? top.map((t) => `<tr>
      <td class="num">${v.e(t.account_id)}</td>
      <td>${v.e(t.ultimo_char)}</td>
      <td class="num">${v.numero(t.doacoes)}</td>
      <td class="num">${v.moeda(t.centavos)}</td>
      <td class="num">${v.numero(t.coins)}</td>
      <td>${v.dataHora(t.ultima)}</td></tr>`).join('')
      : '<tr><td colspan="6" style="color:var(--fraco)">Nenhum pagamento confirmado ainda.</td></tr>';

    const filtros = ['', 'PENDING', 'AWAITING_PAYMENT', 'PAID', 'CREDITED', 'EXPIRED', 'FAILED']
      .map((s) => `<a class="btn mini ${s === status ? '' : 'cinza'}" href="/donates${s ? '?s=' + s : ''}">${s || 'todas'}</a>`)
      .join(' ');

    render(req, res, 'Doacoes', '/donates', `
      <h1>Doacoes</h1>
      <p class="sub">Transacoes do Asaas e o que foi entregue em coins.</p>
      <div class="grade">${cartoes}</div>
      <h2>Por situacao</h2>
      <table><thead><tr><th>Situacao</th><th class="num">Qtd</th>
        <th class="num">Valor</th><th class="num">Coins</th></tr></thead>
        <tbody>${porStatus}</tbody></table>
      <h2>Quem mais doou</h2>
      <table><thead><tr><th class="num">Conta</th><th>Personagem</th><th class="num">Doacoes</th>
        <th class="num">Total</th><th class="num">Coins</th><th>Ultima</th></tr></thead>
        <tbody>${linhasTop}</tbody></table>
      <h2>Transacoes</h2>
      <div class="linha">${filtros}</div>
      <table><thead><tr><th class="num">#</th><th>Personagem</th><th class="num">Conta</th>
        <th class="num">Valor</th><th class="num">Coins</th><th>Situacao</th>
        <th>Criada</th><th>Paga</th><th>Motivo</th></tr></thead><tbody>${linhas}</tbody></table>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

// -------------------------------------------------------------- jogadores

app.get('/jogadores', async (req, res, next) => {
  try {
    const termo = String(req.query.q || '');
    const lista = termo ? await q.buscarJogadores(db, termo) : await q.jogadoresOnline(db);

    const linhas = lista.length ? lista.map((p) => `<tr>
      <td>${v.e(p.name)}${p.online ? ' <span class="pill ok">online</span>' : ''}
        ${p.deletion ? ' <span class="pill frio">removido</span>' : ''}</td>
      <td class="num">${v.numero(p.level)}</td>
      <td class="num">${v.e(p.account_id)}</td>
      <td>${v.dataHora(p.lastlogin)}</td>
      <td><a class="btn mini cinza" href="/itens?jogador=${v.e(p.id)}">Itens</a>
        ${v.formBotao('/jogadores/comando',
          { _csrf: req.csrf, kind: 'kick', player: p.name }, 'Kickar',
          { classe: 'btn mini cinza', confirmar: `Desconectar ${p.name}?` })}
        ${v.formBotao('/jogadores/comando',
          { _csrf: req.csrf, kind: 'save', player: p.name }, 'Salvar',
          { classe: 'btn mini cinza' })}
      </td></tr>`).join('')
      : '<tr><td colspan="5" style="color:var(--fraco)">Nada encontrado.</td></tr>';

    const [fila] = await db.query(
      'SELECT `id`,`kind`,`payload`,`status`,`result`,`created_by`,`created_at`,`executed_at` FROM `panel_commands` ORDER BY `id` DESC LIMIT 15'
    );
    const linhasFila = fila.length ? fila.map((c) => `<tr>
      <td class="num mono">${v.e(c.id)}</td>
      <td>${v.e(c.kind)}</td>
      <td class="mono" style="font-size:12px">${v.e(c.payload)}</td>
      <td><span class="pill ${c.status === 'DONE' ? 'ok' : c.status === 'FAILED' ? 'erro' : 'alerta'}">${v.e(c.status)}</span></td>
      <td style="color:var(--fraco);font-size:12px">${v.e(c.result)}</td>
      <td>${v.e(c.created_by)}</td>
      <td>${v.dataHora(c.created_at)}</td></tr>`).join('')
      : '<tr><td colspan="7" style="color:var(--fraco)">Nenhum comando enviado.</td></tr>';

    render(req, res, 'Jogadores', '/jogadores', `
      <h1>Jogadores</h1>
      <p class="sub">Sem busca, mostra quem esta online.</p>
      <form class="linha" method="get">
        <input name="q" value="${v.e(termo)}" placeholder="nome do personagem" size="26">
        <button class="btn" type="submit">Buscar</button>
        <a class="btn cinza" href="/jogadores">So online</a>
      </form>
      <table><thead><tr><th>Personagem</th><th class="num">Level</th><th class="num">Conta</th>
        <th>Ultimo login</th><th>Acoes</th></tr></thead><tbody>${linhas}</tbody></table>

      <h2>Anuncio para todos</h2>
      <form method="post" action="/jogadores/comando" class="linha">
        <input type="hidden" name="_csrf" value="${v.e(req.csrf)}">
        <input type="hidden" name="kind" value="broadcast">
        <input name="texto" placeholder="mensagem que todos verao" size="46" required>
        <button class="btn" type="submit">Anunciar</button>
      </form>

      <h2>Fila de comandos</h2>
      <p class="sub">O painel nao fala direto com o servidor: ele enfileira aqui e um script
        em Lua executa dentro do jogo, em ate 5 segundos.</p>
      <table><thead><tr><th class="num">#</th><th>Tipo</th><th>Conteudo</th><th>Situacao</th>
        <th>Resultado</th><th>Por</th><th>Quando</th></tr></thead><tbody>${linhasFila}</tbody></table>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

app.post('/jogadores/comando', exigirCsrf, async (req, res, next) => {
  try {
    const kind = String(req.body.kind || '');
    if (!['kick', 'save', 'broadcast'].includes(kind)) {
      return res.redirect(comAviso('/jogadores', 'erro', 'Comando desconhecido.'));
    }
    const payload = JSON.stringify(kind === 'broadcast'
      ? { texto: String(req.body.texto || '').slice(0, 200) }
      : { player: String(req.body.player || '').slice(0, 64) });

    await db.query(
      'INSERT INTO `panel_commands` (`kind`,`payload`,`created_by`,`created_at`) VALUES (?,?,?,?)',
      [kind, payload, req.usuario.username, Date.now()]
    );
    await auditar(req, 'comando.' + kind, payload);
    res.redirect(comAviso('/jogadores', 'ok', 'Comando enfileirado; executa em ate 5 segundos.'));
  } catch (err) { next(err); }
});

// ----------------------------------------------------------------- backup

app.get('/backup', async (req, res, next) => {
  try {
    let arquivos = [];
    try {
      const nomes = await fsp.readdir(BACKUP_DB_DIR);
      for (const n of nomes) {
        if (!n.endsWith('.sql.gz')) continue;
        const s = await fsp.stat(path.join(BACKUP_DB_DIR, n));
        arquivos.push({ nome: n, tamanho: s.size, mtime: s.mtimeMs });
      }
      arquivos.sort((a, b) => b.mtime - a.mtime);
    } catch (_) { /* pasta ainda nao existe */ }

    const linhas = arquivos.length ? arquivos.map((a) => `<tr>
      <td class="mono">${v.e(a.nome)}</td>
      <td class="num">${v.tamanho(a.tamanho)}</td>
      <td>${v.dataHora(a.mtime)}</td>
      <td><a class="btn mini cinza" href="/backup/baixar?f=${encodeURIComponent(a.nome)}">Baixar</a></td>
      </tr>`).join('')
      : '<tr><td colspan="4" style="color:var(--fraco)">Nenhum backup gerado ainda.</td></tr>';

    render(req, res, 'Backup', '/backup', `
      <h1>Backup do banco</h1>
      <p class="sub">Dump completo, comprimido. Gerar com o servidor no ar e seguro:
        o dump roda em transacao unica e nao trava o jogo.</p>
      <form method="post" action="/backup/gerar" class="linha">
        <input type="hidden" name="_csrf" value="${v.e(req.csrf)}">
        <button class="btn" type="submit">Gerar backup agora</button>
        <span style="color:var(--fraco);font-size:12px">Pode levar alguns minutos.</span>
      </form>
      <table><thead><tr><th>Arquivo</th><th class="num">Tamanho</th><th>Gerado</th><th></th></tr></thead>
        <tbody>${linhas}</tbody></table>
      <p class="sub" style="margin-top:10px">Guardados em
        <span class="mono">${v.e(BACKUP_DB_DIR)}</span>. O disco da maquina e pequeno —
        baixe e apague os antigos de vez em quando.</p>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

app.post('/backup/gerar', exigirCsrf, async (req, res, next) => {
  try {
    const nome = 'crandoria-' + new Date().toISOString().replace(/[:.]/g, '-') + '.sql.gz';
    const destino = path.join(BACKUP_DB_DIR, nome);
    const r = await agent.dump(destino);
    await auditar(req, 'backup.gerado', nome, r.ok ? `${r.bytes} bytes` : r.erro);
    res.redirect(comAviso('/backup', r.ok ? 'ok' : 'erro',
      r.ok ? `Backup gerado: ${nome} (${v.tamanho(r.bytes)})` : `Falhou: ${r.erro}`));
  } catch (err) { next(err); }
});

app.get('/backup/baixar', async (req, res, next) => {
  try {
    const nome = path.basename(String(req.query.f || ''));
    if (!/^[A-Za-z0-9._-]+\.sql\.gz$/.test(nome)) return res.status(400).send('nome invalido');
    const completo = path.join(BACKUP_DB_DIR, nome);
    if (!fs.existsSync(completo)) return res.status(404).send('nao encontrado');
    await auditar(req, 'backup.baixado', nome);
    res.download(completo, nome);
  } catch (err) { next(err); }
});

// -------------------------------------------------------------- auditoria

app.get('/auditoria', async (req, res, next) => {
  try {
    const [linhas] = await db.query(
      'SELECT `at`,`username`,`ip`,`action`,`target`,`detail` FROM `panel_audit` ORDER BY `id` DESC LIMIT 300'
    );
    const [tentativas] = await db.query(
      'SELECT `ip`,`username`,`ok`,`at` FROM `panel_login_attempts` ORDER BY `id` DESC LIMIT 60'
    );

    const corpo = linhas.length ? linhas.map((l) => `<tr>
      <td>${v.dataHora(l.at)}</td><td>${v.e(l.username)}</td>
      <td class="mono">${v.e(l.ip)}</td><td>${v.e(l.action)}</td>
      <td class="mono" style="font-size:12px">${v.e(l.target)}</td>
      <td style="color:var(--fraco);font-size:12px">${v.e(l.detail)}</td></tr>`).join('')
      : '<tr><td colspan="6" style="color:var(--fraco)">Nada registrado ainda.</td></tr>';

    const corpoT = tentativas.map((t) => `<tr>
      <td>${v.dataHora(t.at)}</td><td class="mono">${v.e(t.ip)}</td>
      <td>${v.e(t.username)}</td>
      <td>${t.ok ? '<span class="pill ok">ok</span>' : '<span class="pill erro">falhou</span>'}</td>
      </tr>`).join('') || '<tr><td colspan="4" style="color:var(--fraco)">Sem tentativas.</td></tr>';

    render(req, res, 'Auditoria', '/auditoria', `
      <h1>Auditoria</h1>
      <p class="sub">Tudo que muda estado fica registrado aqui, com quem fez e de onde.</p>
      <table><thead><tr><th>Quando</th><th>Quem</th><th>IP</th><th>Acao</th>
        <th>Alvo</th><th>Detalhe</th></tr></thead><tbody>${corpo}</tbody></table>
      <h2>Tentativas de login</h2>
      <table><thead><tr><th>Quando</th><th>IP</th><th>Usuario</th><th>Resultado</th></tr></thead>
        <tbody>${corpoT}</tbody></table>
    `, avisoDaQuery(req));
  } catch (err) { next(err); }
});

// ------------------------------------------------------------------ erros

app.use((req, res) => res.status(404).send(v.pagina({
  titulo: 'Nao encontrado', ativo: '', usuario: req.usuario ? req.usuario.username : '',
  corpo: '<h1>Pagina nao encontrada</h1><p class="sub"><a href="/">Voltar</a></p>',
})));

app.use((err, req, res, _next) => {
  console.error('erro na rota', req.method, req.path, '-', err.message);
  const corpo = `<h1>Algo falhou</h1>
    <div class="aviso erro">${v.e(err.message)}</div>
    <p class="sub"><a href="/">Voltar para a visao geral</a></p>`;
  res.status(500).send(v.pagina({
    titulo: 'Erro', ativo: '',
    usuario: req.usuario ? req.usuario.username : '', corpo,
  }));
});

// ------------------------------------------------------------------ start

// Faxina periodica: sessao vencida, tentativa velha e backup de script antigo.
setInterval(() => {
  auth.limpar(db).catch((e) => console.error('faxina de sessao:', e.message));
  scripts.podarBackups().catch((e) => console.error('poda de backups:', e.message));
}, 60 * 60 * 1000).unref();

app.listen(PORTA, '0.0.0.0', () => {
  console.log(`painel ouvindo na porta ${PORTA}; agente em ${agent.SOCKET}`);
});
