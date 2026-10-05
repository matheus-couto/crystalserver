'use strict';

/**
 * Erros do servidor de jogo, agrupados.
 *
 * O log do servidor cresce sem parar e o mesmo erro se repete centenas de
 * vezes, entao procurar nele e ruim. A cada minuto o painel le so o trecho novo
 * do log (agente: logs_periodo), separa os erros e guarda cada um UMA vez em
 * panel_errors, com contador, primeira e ultima vez e o bloco completo da
 * ultima ocorrencia.
 *
 * Mesmo erro = mesma assinatura: para erro de Lua, o arquivo + a funcao + a
 * descricao; para as demais linhas de [error]/[warning], a mensagem com os
 * numeros trocados por # (assim "Wrong item id 3634" e "Wrong item id 2472"
 * contam juntos).
 */

const crypto = require('crypto');
const agent = require('./agent');

const RAIZ_SERVIDOR = '/srv/crystalserver/';
const INTERVALO_MS = 60 * 1000;
// Primeira leitura: quanto do log que ja existe importar.
const HISTORICO_INICIAL_S = 3 * 86400;

async function criarTabelas(db) {
  await db.query(`CREATE TABLE IF NOT EXISTS \`panel_errors\` (
    \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    \`assinatura\` CHAR(40) NOT NULL,
    \`tipo\` VARCHAR(8) NOT NULL,
    \`script\` VARCHAR(255) NOT NULL DEFAULT '',
    \`mensagem\` TEXT NOT NULL,
    \`exemplo\` TEXT NOT NULL,
    \`contagem\` INT UNSIGNED NOT NULL DEFAULT 0,
    \`primeira\` BIGINT NOT NULL,
    \`ultima\` BIGINT NOT NULL,
    \`resolvido_em\` BIGINT NOT NULL DEFAULT 0,
    \`resolvido_por\` VARCHAR(32) NOT NULL DEFAULT '',
    PRIMARY KEY (\`id\`),
    UNIQUE KEY \`panel_errors_assinatura\` (\`assinatura\`),
    KEY \`panel_errors_ultima\` (\`ultima\`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4`);
  await db.query(`CREATE TABLE IF NOT EXISTS \`panel_errors_estado\` (
    \`chave\` VARCHAR(32) NOT NULL,
    \`valor\` BIGINT NOT NULL,
    PRIMARY KEY (\`chave\`)
  ) ENGINE=InnoDB`);
}

/** "/srv/crystalserver/data-crandoria/x.lua:callback" -> "data-crandoria/x.lua". */
function arquivoDoScript(scriptId) {
  let s = String(scriptId || '').trim();
  if (s.startsWith(RAIZ_SERVIDOR)) s = s.slice(RAIZ_SERVIDOR.length);
  const i = s.lastIndexOf('.lua:');
  return i >= 0 ? s.slice(0, i + 4) : s;
}

function hash(texto) {
  return crypto.createHash('sha1').update(texto).digest('hex');
}

/**
 * Le o texto do `docker compose logs --timestamps` e devolve as ocorrencias:
 * [{ assinatura, tipo, script, mensagem, exemplo, quando(ms) }].
 */
function extrair(texto) {
  const ocorrencias = [];
  let bloco = null;

  const fecharBloco = () => {
    if (!bloco) return;
    const campos = {};
    for (const l of bloco.linhas) {
      const m = /^(Script ID|Function|Error Description):\s*(.*)$/.exec(l);
      if (m && !(m[1] in campos)) campos[m[1]] = m[2].trim();
    }
    const script = arquivoDoScript(campos['Script ID']);
    const funcao = campos.Function || '';
    const descricao = (campos['Error Description'] || bloco.linhas.find((l) => l.trim() && !/^-+$/.test(l)) || '').trim();
    // Endereco de memoria muda a cada execucao e separaria o mesmo erro.
    const chave = `${script}|${funcao}|${descricao.replace(/0x[0-9a-f]+/gi, '0x')}`;
    ocorrencias.push({
      assinatura: hash('lua|' + chave),
      tipo: 'lua',
      script,
      mensagem: (funcao ? funcao + ': ' : '') + descricao,
      exemplo: bloco.linhas.join('\n').slice(0, 6000),
      quando: bloco.quando,
    });
    bloco = null;
  };

  for (const bruta of String(texto).split('\n')) {
    // "server-1  | 2026-10-05T19:14:44.161Z [2026-05-10 16:14:44.159] [error] ..."
    const i = bruta.indexOf('| ');
    if (i < 0) continue;
    const resto = bruta.slice(i + 2);
    const sp = resto.indexOf(' ');
    const quando = Date.parse(sp > 0 ? resto.slice(0, sp) : '');
    if (Number.isNaN(quando)) continue;
    const linha = resto.slice(sp + 1).replace(/\s+$/, '');

    // Uma entrada nova do log ("[data hora] [nivel] ...") encerra qualquer bloco aberto.
    const entrada = /^\[\d{4}-\d{2}-\d{2} [\d:.]+\] \[(\w+)\] (.*)$/.exec(linha);
    if (entrada) {
      fecharBloco();
      const [, nivel, msg] = entrada;
      if (nivel === 'error' && /^Lua Script Error Detected/.test(msg)) {
        bloco = { quando, linhas: [], tracos: 0 };
        continue;
      }
      if (nivel === 'error' || nivel === 'warning') {
        const normal = msg.replace(/\d+/g, '#');
        ocorrencias.push({
          assinatura: hash(nivel + '|' + normal),
          tipo: nivel === 'error' ? 'erro' : 'aviso',
          script: '',
          mensagem: msg,
          exemplo: msg,
          quando,
        });
      }
      continue;
    }

    if (bloco) {
      if (/^-{10,}$/.test(linha)) {
        // O bloco abre e fecha com uma linha de tracos.
        if (++bloco.tracos >= 2) fecharBloco();
        continue;
      }
      bloco.linhas.push(linha);
      if (bloco.linhas.length > 80) fecharBloco();
    }
  }
  fecharBloco();
  return ocorrencias;
}

/** Junta as ocorrencias do lote por assinatura e grava num upsert por erro. */
async function gravar(db, ocorrencias) {
  const porAssinatura = new Map();
  for (const o of ocorrencias) {
    const g = porAssinatura.get(o.assinatura);
    if (!g) {
      porAssinatura.set(o.assinatura, { ...o, n: 1, primeira: o.quando, ultima: o.quando });
    } else {
      g.n += 1;
      g.primeira = Math.min(g.primeira, o.quando);
      if (o.quando >= g.ultima) {
        g.ultima = o.quando;
        g.exemplo = o.exemplo;
      }
    }
  }
  for (const g of porAssinatura.values()) {
    // Um erro marcado como resolvido que volta a acontecer reabre sozinho.
    await db.query(
      `INSERT INTO \`panel_errors\` (\`assinatura\`,\`tipo\`,\`script\`,\`mensagem\`,\`exemplo\`,\`contagem\`,\`primeira\`,\`ultima\`)
       VALUES (?,?,?,?,?,?,?,?)
       ON DUPLICATE KEY UPDATE
         \`contagem\` = \`contagem\` + VALUES(\`contagem\`),
         \`exemplo\` = IF(VALUES(\`ultima\`) >= \`ultima\`, VALUES(\`exemplo\`), \`exemplo\`),
         \`resolvido_em\` = IF(\`resolvido_em\` > 0 AND VALUES(\`ultima\`) > \`resolvido_em\`, 0, \`resolvido_em\`),
         \`resolvido_por\` = IF(\`resolvido_em\` = 0, '', \`resolvido_por\`),
         \`ultima\` = GREATEST(\`ultima\`, VALUES(\`ultima\`))`,
      [g.assinatura, g.tipo, g.script.slice(0, 255), g.mensagem.slice(0, 4000), g.exemplo, g.n, g.primeira, g.ultima]);
  }
  return porAssinatura.size;
}

let coletando = false;

/**
 * Le o log desde a ultima leitura ate agora e grava os erros. A marca de onde
 * parou fica no banco, entao reiniciar o painel nao perde nem repete trecho.
 */
async function coletar(db) {
  if (coletando) return { ok: false, erro: 'ja esta lendo o log' };
  coletando = true;
  try {
    const agora = Math.floor(Date.now() / 1000) - 2;
    const [[marca]] = await db.query('SELECT `valor` FROM `panel_errors_estado` WHERE `chave` = ?', ['log_ate']);
    const desde = marca ? Number(marca.valor) : agora - HISTORICO_INICIAL_S;
    if (desde >= agora) return { ok: true, ocorrencias: 0, erros: 0 };

    const r = await agent.logsPeriodo('server', desde, agora);
    if (!r.ok) return { ok: false, erro: r.erro || 'o agente nao leu o log' };

    const ocorrencias = extrair(r.texto || '');
    const erros = ocorrencias.length ? await gravar(db, ocorrencias) : 0;
    await db.query(
      'INSERT INTO `panel_errors_estado` (`chave`,`valor`) VALUES (?,?) ON DUPLICATE KEY UPDATE `valor` = VALUES(`valor`)',
      ['log_ate', agora]);
    return { ok: true, ocorrencias: ocorrencias.length, erros };
  } finally {
    coletando = false;
  }
}

function iniciar(db) {
  const rodar = () => coletar(db).then((r) => {
    if (!r.ok) console.error('erros do servidor:', r.erro);
  }).catch((e) => console.error('erros do servidor:', e.message));
  criarTabelas(db).then(() => {
    setTimeout(rodar, 10 * 1000);
    setInterval(rodar, INTERVALO_MS);
  }).catch((e) => console.error('erros do servidor: nao criei as tabelas:', e.message));
}

module.exports = { iniciar, coletar, extrair, arquivoDoScript };
