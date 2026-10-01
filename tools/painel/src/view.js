'use strict';

/**
 * Montagem do HTML.
 *
 * Sem engine de template: as paginas sao poucas e o custo de uma dependencia
 * a mais nao se paga. O que importa aqui e o `e()` - tudo que vem do banco
 * passa por ele antes de virar HTML. Nome de personagem e escolhido pelo
 * jogador, entao e entrada hostil por definicao.
 */

const ESCAPES = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };

/** Escapa para corpo de HTML e para valor de atributo com aspas. */
function e(v) {
  if (v === null || v === undefined) return '';
  return String(v).replace(/[&<>"']/g, (c) => ESCAPES[c]);
}

function moeda(centavos) {
  return 'R$ ' + (Number(centavos || 0) / 100).toFixed(2).replace('.', ',');
}

function numero(n) {
  return Number(n || 0).toLocaleString('pt-BR');
}

function dataHora(segundosOuMs) {
  const n = Number(segundosOuMs || 0);
  if (!n) return '—';
  const ms = n > 1e12 ? n : n * 1000;
  return new Date(ms).toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' });
}

function duracao(segundos) {
  const s = Number(segundos || 0);
  const d = Math.floor(s / 86400);
  const h = Math.floor((s % 86400) / 3600);
  const m = Math.floor((s % 3600) / 60);
  if (d) return `${d}d ${h}h`;
  if (h) return `${h}h ${m}min`;
  return `${m}min`;
}

function tamanho(bytes) {
  const b = Number(bytes || 0);
  if (b < 1024) return b + ' B';
  if (b < 1024 * 1024) return (b / 1024).toFixed(1) + ' KB';
  if (b < 1024 ** 3) return (b / 1024 / 1024).toFixed(1) + ' MB';
  return (b / 1024 ** 3).toFixed(2) + ' GB';
}

const CSS = `
:root{--bg:#141821;--card:#1b212c;--linha:#28303d;--fg:#e8e6e3;--fraco:#8b93a7;
--ouro:#c8a24a;--ok:#4aa96c;--alerta:#d99a3b;--erro:#cf5a5a;--azul:#5a8fcf}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);
font:14px/1.5 "Segoe UI",system-ui,sans-serif}
a{color:var(--ouro);text-decoration:none}
a:hover{text-decoration:underline}
header{background:var(--card);border-bottom:1px solid var(--linha);padding:0 20px;
display:flex;align-items:center;gap:22px;flex-wrap:wrap;position:sticky;top:0;z-index:10}
header .marca{font-weight:700;color:var(--ouro);font-size:16px;padding:14px 0}
header nav{display:flex;gap:4px;flex-wrap:wrap}
header nav a{padding:14px 12px;color:var(--fraco);border-bottom:2px solid transparent;
font-size:13px}
header nav a:hover{color:var(--fg);text-decoration:none}
header nav a.on{color:var(--ouro);border-bottom-color:var(--ouro)}
header .dir{margin-left:auto;color:var(--fraco);font-size:12px;display:flex;
align-items:center;gap:12px}
main{max-width:1180px;margin:0 auto;padding:22px 20px 60px}
h1{font-size:20px;margin:0 0 4px}
h2{font-size:15px;margin:26px 0 10px;color:var(--fg)}
.sub{color:var(--fraco);font-size:13px;margin:0 0 18px}
.grade{display:grid;gap:12px;grid-template-columns:repeat(auto-fit,minmax(190px,1fr))}
.card{background:var(--card);border:1px solid var(--linha);border-radius:8px;padding:14px 16px}
.card .rot{color:var(--fraco);font-size:11px;text-transform:uppercase;letter-spacing:.06em}
.card .val{font-size:22px;font-weight:600;margin-top:4px}
.card .obs{color:var(--fraco);font-size:12px;margin-top:2px}
table{width:100%;border-collapse:collapse;background:var(--card);
border:1px solid var(--linha);border-radius:8px;overflow:hidden}
th{text-align:left;font-size:11px;text-transform:uppercase;letter-spacing:.05em;
color:var(--fraco);padding:9px 12px;border-bottom:1px solid var(--linha);font-weight:600}
td{padding:9px 12px;border-bottom:1px solid var(--linha)}
tr:last-child td{border-bottom:0}
tbody tr:hover{background:#1f2633}
.num{text-align:right;font-variant-numeric:tabular-nums}
.pill{display:inline-block;padding:2px 8px;border-radius:99px;font-size:11px;font-weight:600}
.pill.ok{background:rgba(74,169,108,.18);color:var(--ok)}
.pill.erro{background:rgba(207,90,90,.18);color:var(--erro)}
.pill.alerta{background:rgba(217,154,59,.18);color:var(--alerta)}
.pill.frio{background:rgba(139,147,167,.18);color:var(--fraco)}
.btn{display:inline-block;background:var(--ouro);color:#16181d;border:0;border-radius:6px;
padding:8px 16px;font:inherit;font-weight:600;cursor:pointer}
.btn:hover{background:#dcb75c;text-decoration:none}
.btn.cinza{background:var(--linha);color:var(--fg)}
.btn.cinza:hover{background:#333c4d}
.btn.perigo{background:var(--erro);color:#fff}
.btn:disabled{opacity:.5;cursor:not-allowed}
.btn.mini{padding:4px 10px;font-size:12px}
input,select,textarea{background:#131822;color:var(--fg);border:1px solid var(--linha);
border-radius:6px;padding:8px 10px;font:inherit}
input:focus,select:focus,textarea:focus{outline:0;border-color:var(--ouro)}
textarea{width:100%;font-family:Consolas,"Courier New",monospace;font-size:13px;
line-height:1.45;min-height:430px;white-space:pre;overflow-wrap:normal}
.linha{display:flex;gap:8px;align-items:center;flex-wrap:wrap;margin-bottom:14px}
.aviso{border-left:3px solid var(--alerta);background:rgba(217,154,59,.08);
padding:10px 14px;border-radius:0 6px 6px 0;margin:14px 0;font-size:13px}
.aviso.erro{border-color:var(--erro);background:rgba(207,90,90,.08)}
.aviso.ok{border-color:var(--ok);background:rgba(74,169,108,.08)}
pre.log{background:#0f131b;border:1px solid var(--linha);border-radius:8px;padding:14px;
overflow:auto;max-height:640px;font:12px/1.5 Consolas,"Courier New",monospace;
white-space:pre-wrap;word-break:break-word;margin:0}
pre.log .e{color:var(--erro)} pre.log .w{color:var(--alerta)} pre.log .i{color:var(--fraco)}
.barra{height:6px;background:#131822;border-radius:99px;overflow:hidden;margin-top:6px}
.barra i{display:block;height:100%;background:var(--ouro)}
.barra i.quente{background:var(--erro)}
.mono{font-family:Consolas,"Courier New",monospace;font-size:12px}
.login{max-width:340px;margin:12vh auto;background:var(--card);border:1px solid var(--linha);
border-radius:10px;padding:28px}
.login h1{color:var(--ouro);text-align:center;margin-bottom:22px}
.login input{width:100%;margin-bottom:10px}
.login .btn{width:100%}
.crumbs{color:var(--fraco);font-size:13px;margin-bottom:12px}
`;

/**
 * Tags que a pagina do editor injeta no <head>.
 *
 * Tudo servido de /estatico, nada de CDN: a politica de seguranca da pagina
 * so aceita script do proprio painel, e assim o editor tambem funciona se a
 * maquina ficar sem internet de saida.
 */
const EDITOR_HEAD = `
<link rel="stylesheet" href="/estatico/cm/codemirror.css">
<link rel="stylesheet" href="/estatico/cm/dialog.css">
<link rel="stylesheet" href="/estatico/editor.css">
<script src="/estatico/cm/codemirror.js" defer></script>
<script src="/estatico/cm/mode-lua.js" defer></script>
<script src="/estatico/cm/mode-xml.js" defer></script>
<script src="/estatico/cm/mode-javascript.js" defer></script>
<script src="/estatico/cm/addon-matchbrackets.js" defer></script>
<script src="/estatico/cm/addon-activeline.js" defer></script>
<script src="/estatico/cm/dialog.js" defer></script>
<script src="/estatico/cm/searchcursor.js" defer></script>
<script src="/estatico/cm/search.js" defer></script>
<script src="/estatico/editor.js" defer></script>`;

/** Envio de arquivo com barra de progresso - o mapa leva minutos. */
const ENVIO_HEAD = `<script src="/estatico/enviar.js" defer></script>`;

/** A pagina de log precisa rolar para o fim sozinha. */
const LOG_HEAD = `<script src="/estatico/logs.js" defer></script>`;

const MENU = [
  ['/', 'Visao geral'],
  ['/logs', 'Logs'],
  ['/scripts', 'Scripts'],
  ['/itens', 'Itens'],
  ['/donates', 'Doacoes'],
  ['/jogadores', 'Jogadores'],
  ['/backup', 'Backup'],
  ['/auditoria', 'Auditoria'],
];

function pagina({ titulo, ativo, usuario, corpo, aviso, extras = '' }) {
  const nav = MENU.map(([href, rot]) =>
    `<a href="${e(href)}"${href === ativo ? ' class="on"' : ''}>${e(rot)}</a>`).join('');

  const avisoHtml = aviso
    ? `<div class="aviso ${e(aviso.tipo || '')}">${aviso.html || e(aviso.texto)}</div>`
    : '';

  return `<!doctype html>
<html lang="pt-BR"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<title>${e(titulo)} · Painel CrandoriaOT</title>
<style>${CSS}</style>
${extras}
</head><body>
<header>
  <span class="marca">CrandoriaOT</span>
  <nav>${nav}</nav>
  <div class="dir">
    <span>${e(usuario || '')}</span>
    <form method="post" action="/sair" style="margin:0">
      <button class="btn cinza mini" type="submit">Sair</button>
    </form>
  </div>
</header>
<main>${avisoHtml}${corpo}</main>
</body></html>`;
}

function paginaLogin({ erro, aviso }) {
  return `<!doctype html>
<html lang="pt-BR"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<title>Entrar · Painel CrandoriaOT</title>
<style>${CSS}</style>
</head><body>
<form class="login" method="post" action="/entrar">
  <h1>CrandoriaOT</h1>
  ${erro ? `<div class="aviso erro">${e(erro)}</div>` : ''}
  ${aviso ? `<div class="aviso">${e(aviso)}</div>` : ''}
  <input name="username" placeholder="Usuario" autocomplete="username" autofocus required>
  <input name="senha" type="password" placeholder="Senha" autocomplete="current-password" required>
  <button class="btn" type="submit">Entrar</button>
</form>
</body></html>`;
}

/** Botao que dispara um POST com o token anti-CSRF junto. */
function formBotao(action, campos, rotulo, { classe = 'btn', confirmar = null } = {}) {
  const ocultos = Object.entries(campos)
    .map(([k, v]) => `<input type="hidden" name="${e(k)}" value="${e(v)}">`).join('');
  const onsub = confirmar ? ` onsubmit="return confirm('${e(confirmar).replace(/'/g, "\\'")}')"` : '';
  return `<form method="post" action="${e(action)}" style="display:inline;margin:0"${onsub}>
    ${ocultos}<button class="${e(classe)}" type="submit">${e(rotulo)}</button></form>`;
}

/**
 * Load average em porcentagem da capacidade da maquina.
 *
 * Load 2.0 em 2 vCPU e 100%: a fila de processos prontos ocupa exatamente os
 * nucleos disponiveis. Acima disso ha processo esperando vez.
 */
function cargaPct(carga, cpus) {
  if (!carga || !cpus) return 0;
  return Math.round((carga / cpus) * 100);
}

function rotuloCarga(pct) {
  if (pct < 70) return '<span class="pill ok">tranquilo</span>';
  if (pct < 100) return '<span class="pill alerta">ocupado</span>';
  return '<span class="pill erro">saturado</span>';
}

function barra(pct, quenteAcima = 85) {
  const p = Math.max(0, Math.min(100, Number(pct) || 0));
  return `<div class="barra"><i class="${p >= quenteAcima ? 'quente' : ''}" style="width:${p}%"></i></div>`;
}

function cartao(rotulo, valor, obs, extra = '') {
  return `<div class="card"><div class="rot">${e(rotulo)}</div>
    <div class="val">${valor}</div>
    ${obs ? `<div class="obs">${e(obs)}</div>` : ''}${extra}</div>`;
}

/** Colore as linhas do log por severidade, para o olho achar erro rapido. */
function colorirLog(texto) {
  return String(texto || '').split('\n').map((linha) => {
    const cru = e(linha);
    if (/\berror\b|Error Description|attempt to/i.test(linha)) return `<span class="e">${cru}</span>`;
    if (/\bwarning\b|\bwarn\b/i.test(linha)) return `<span class="w">${cru}</span>`;
    if (/\binfo\b/i.test(linha)) return `<span class="i">${cru}</span>`;
    return cru;
  }).join('\n');
}

module.exports = {
  e, moeda, numero, dataHora, duracao, tamanho,
  pagina, paginaLogin, formBotao, barra, cartao, colorirLog, MENU, EDITOR_HEAD,
  cargaPct, rotuloCarga, LOG_HEAD, ENVIO_HEAD,
};
