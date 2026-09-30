'use strict';

/**
 * Cliente do agente privilegiado.
 *
 * O painel nao tem acesso ao Docker. Tudo que envolve container passa por
 * este socket unix, e o agente do outro lado so conhece uma lista fechada
 * de verbos. Ver tools/painel/agent/agent.py para o porque.
 */

const net = require('net');

const SOCKET = process.env.AGENT_SOCKET || '/run/crandoria-painel/agent.sock';
const TIMEOUT_MS = Number(process.env.AGENT_TIMEOUT_MS || 200000);

function chamar(verbo, args = {}, timeoutMs = TIMEOUT_MS) {
  return new Promise((resolve) => {
    let respondido = false;
    const terminar = (r) => {
      if (respondido) return;
      respondido = true;
      try { sock.destroy(); } catch (_) { /* ja fechado */ }
      resolve(r);
    };

    const sock = net.createConnection(SOCKET);
    let buf = '';

    sock.setTimeout(timeoutMs);
    sock.on('connect', () => {
      sock.write(JSON.stringify({ verbo, ...args }) + '\n');
    });
    sock.on('data', (d) => {
      buf += d.toString('utf8');
      const nl = buf.indexOf('\n');
      if (nl >= 0) {
        try {
          terminar(JSON.parse(buf.slice(0, nl)));
        } catch (e) {
          terminar({ ok: false, erro: 'resposta invalida do agente' });
        }
      }
    });
    sock.on('timeout', () => terminar({ ok: false, erro: 'o agente nao respondeu a tempo' }));
    sock.on('error', (e) => terminar({
      ok: false,
      erro: e.code === 'ENOENT'
        ? 'agente fora do ar (socket nao existe) - confira o servico crandoria-painel-agent'
        : e.code === 'EACCES'
          ? 'sem permissao no socket do agente - confira o grupo painel'
          : e.message,
    }));
    sock.on('close', () => terminar({ ok: false, erro: 'conexao com o agente encerrada' }));
  });
}

module.exports = {
  status: () => chamar('status'),
  stats: () => chamar('stats', {}, 40000),
  host: () => chamar('host'),
  logs: (servico, linhas) => chamar('logs', { servico, linhas }),
  restart: (servico) => chamar('restart', { servico }),
  stop: (servico) => chamar('stop', { servico }),
  start: (servico) => chamar('start', { servico }),
  luacheck: (conteudo) => chamar('luacheck', { conteudo }, 30000),
  dump: (destino) => chamar('dump', { destino }, 600000),
  configLer: () => chamar('config_ler', {}, 20000),
  configGravar: (conteudo) => chamar('config_gravar', { conteudo }, 40000),
  SOCKET,
};
