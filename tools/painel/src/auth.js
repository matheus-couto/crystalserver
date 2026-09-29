'use strict';

/**
 * Login, sessao e bloqueio.
 *
 * Nao ha segundo fator, por escolha: sao duas pessoas e nenhuma quer app
 * autenticador. O que substitui o 2FA aqui e o custo de tentar: o scrypt
 * deixa cada verificacao cara para quem tem o hash, e o bloqueio progressivo
 * deixa cara para quem nao tem.
 */

const crypto = require('crypto');

const SESSION_COOKIE = 'painel_sid';
const SESSION_TTL_MS = 8 * 60 * 60 * 1000;   // 8h, renovada a cada uso
const SESSION_ABS_MS = 24 * 60 * 60 * 1000;  // teto: 24h mesmo em uso continuo

// scrypt com os parametros recomendados pelo RFC 7914 para uso interativo.
// N=2^15 leva ~100ms por tentativa nesta maquina, o que e imperceptivel no
// login e proibitivo para forca bruta.
const SCRYPT = { N: 32768, r: 8, p: 1, keylen: 64, maxmem: 64 * 1024 * 1024 };

// Janela e limites do bloqueio. Depois de 5 erros o IP espera; a espera
// dobra a cada bloco de 5, ate 30 minutos.
const JANELA_MS = 15 * 60 * 1000;
const LIVRES = 5;
const ESPERA_BASE_MS = 60 * 1000;
const ESPERA_MAX_MS = 30 * 60 * 1000;

function agora() {
  return Date.now();
}

function hashSenha(senha) {
  const sal = crypto.randomBytes(16);
  const dk = crypto.scryptSync(senha, sal, SCRYPT.keylen, SCRYPT);
  return ['scrypt', SCRYPT.N, SCRYPT.r, SCRYPT.p,
          sal.toString('base64'), dk.toString('base64')].join('$');
}

function conferirSenha(senha, guardado) {
  const p = String(guardado || '').split('$');
  if (p.length !== 6 || p[0] !== 'scrypt') return false;
  const [, N, r, pp, salB64, dkB64] = p;
  let esperado;
  try {
    esperado = Buffer.from(dkB64, 'base64');
  } catch (_) {
    return false;
  }
  const calc = crypto.scryptSync(senha, Buffer.from(salB64, 'base64'),
    esperado.length, { N: +N, r: +r, p: +pp, maxmem: SCRYPT.maxmem });
  // timingSafeEqual exige mesmo tamanho; o comprimento ja veio do hash.
  return calc.length === esperado.length && crypto.timingSafeEqual(calc, esperado);
}

function sha256(s) {
  return crypto.createHash('sha256').update(String(s)).digest('hex');
}

/**
 * Quanto tempo este IP ainda precisa esperar, em ms. Zero libera.
 *
 * Conta so as falhas desde o ultimo acerto: quem erra, acerta e erra de novo
 * nao carrega o historico antigo.
 */
async function esperaRestante(db, ip) {
  const desde = agora() - JANELA_MS;
  const [linhas] = await db.query(
    'SELECT `ok`, `at` FROM `panel_login_attempts` WHERE `ip` = ? AND `at` >= ? ORDER BY `at` DESC LIMIT 60',
    [ip, desde]
  );

  let falhas = 0;
  let ultimaFalha = 0;
  for (const l of linhas) {
    if (l.ok) break;          // acerto recente zera a contagem
    falhas += 1;
    if (!ultimaFalha) ultimaFalha = Number(l.at);
  }

  if (falhas < LIVRES) return 0;
  const blocos = Math.floor(falhas / LIVRES);
  const espera = Math.min(ESPERA_BASE_MS * Math.pow(2, blocos - 1), ESPERA_MAX_MS);
  const restante = ultimaFalha + espera - agora();
  return restante > 0 ? restante : 0;
}

async function registrarTentativa(db, ip, username, ok) {
  await db.query(
    'INSERT INTO `panel_login_attempts` (`ip`, `username`, `ok`, `at`) VALUES (?, ?, ?, ?)',
    [ip, String(username || '').slice(0, 32), ok ? 1 : 0, agora()]
  );
}

async function entrar(db, { username, senha, ip, userAgent }) {
  const espera = await esperaRestante(db, ip);
  if (espera > 0) {
    return { ok: false, motivo: 'bloqueado', esperaSegundos: Math.ceil(espera / 1000) };
  }

  const [linhas] = await db.query(
    'SELECT `id`, `username`, `password_hash`, `disabled` FROM `panel_users` WHERE `username` = ? LIMIT 1',
    [String(username || '').slice(0, 32)]
  );
  const user = linhas[0];

  // Mesmo sem usuario, gasta o tempo do scrypt: senao o tempo de resposta
  // revela quais nomes existem.
  const hash = user ? user.password_hash : hashSenha(crypto.randomBytes(16).toString('hex'));
  const confere = conferirSenha(String(senha || ''), hash);

  if (!user || !confere || user.disabled) {
    await registrarTentativa(db, ip, username, false);
    return { ok: false, motivo: 'credenciais' };
  }

  await registrarTentativa(db, ip, username, true);

  const sid = crypto.randomBytes(32).toString('base64url');
  const t = agora();
  await db.query(
    'INSERT INTO `panel_sessions` (`id_hash`, `user_id`, `created_at`, `expires_at`, `ip`, `ua_hash`) VALUES (?, ?, ?, ?, ?, ?)',
    [sha256(sid), user.id, t, t + SESSION_TTL_MS, ip, sha256(userAgent || '')]
  );
  await db.query(
    'UPDATE `panel_users` SET `last_login` = ?, `last_ip` = ? WHERE `id` = ?',
    [t, ip, user.id]
  );

  return { ok: true, sid, user: { id: user.id, username: user.username } };
}

/**
 * Resolve o cookie em um usuario, ou null.
 *
 * A sessao e amarrada ao user-agent: roubar so o cookie nao basta, o ladrao
 * precisa reproduzir o navegador tambem. O IP de proposito nao entra - rede
 * movel troca de IP no meio do uso e derrubaria a sessao a toa.
 */
async function sessaoAtual(db, sid, userAgent) {
  if (!sid) return null;
  const [linhas] = await db.query(
    `SELECT s.\`id_hash\`, s.\`user_id\`, s.\`created_at\`, s.\`expires_at\`, s.\`ua_hash\`,
            u.\`username\`, u.\`disabled\`
       FROM \`panel_sessions\` s
       JOIN \`panel_users\` u ON u.\`id\` = s.\`user_id\`
      WHERE s.\`id_hash\` = ? LIMIT 1`,
    [sha256(sid)]
  );
  const s = linhas[0];
  if (!s) return null;

  const t = agora();
  if (t > Number(s.expires_at) || t > Number(s.created_at) + SESSION_ABS_MS || s.disabled) {
    await db.query('DELETE FROM `panel_sessions` WHERE `id_hash` = ?', [s.id_hash]);
    return null;
  }
  if (s.ua_hash && s.ua_hash !== sha256(userAgent || '')) {
    await db.query('DELETE FROM `panel_sessions` WHERE `id_hash` = ?', [s.id_hash]);
    return null;
  }

  // Renova a janela deslizante, respeitando o teto absoluto.
  await db.query('UPDATE `panel_sessions` SET `expires_at` = ? WHERE `id_hash` = ?',
    [Math.min(t + SESSION_TTL_MS, Number(s.created_at) + SESSION_ABS_MS), s.id_hash]);

  return { id: s.user_id, username: s.username };
}

async function sair(db, sid) {
  if (sid) await db.query('DELETE FROM `panel_sessions` WHERE `id_hash` = ?', [sha256(sid)]);
}

async function limpar(db) {
  const t = agora();
  await db.query('DELETE FROM `panel_sessions` WHERE `expires_at` < ?', [t]);
  await db.query('DELETE FROM `panel_login_attempts` WHERE `at` < ?', [t - 7 * 24 * 3600 * 1000]);
}

/**
 * Token anti-CSRF, derivado da sessao com um segredo do servidor.
 *
 * Nao precisa ser guardado: da para recalcular a partir do cookie e conferir.
 * Sem ele, um site qualquer que a pessoa abrisse logada poderia disparar um
 * POST de "reiniciar servidor" por ela.
 */
function csrfToken(sid, segredo) {
  return crypto.createHmac('sha256', segredo).update('csrf:' + sid).digest('base64url');
}

function csrfConfere(sid, segredo, enviado) {
  const esperado = csrfToken(sid, segredo);
  const a = Buffer.from(esperado);
  const b = Buffer.from(String(enviado || ''));
  return a.length === b.length && crypto.timingSafeEqual(a, b);
}

module.exports = {
  SESSION_COOKIE, SESSION_TTL_MS,
  hashSenha, conferirSenha,
  entrar, sessaoAtual, sair, limpar, esperaRestante,
  csrfToken, csrfConfere, sha256,
};
