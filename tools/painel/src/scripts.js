'use strict';

/**
 * Navegacao, leitura e troca de arquivos de script.
 *
 * Tres travas, porque este e o modulo que mais pode estragar o servidor:
 *
 *  1. confinamento: todo caminho e resolvido e comparado com as raizes
 *     permitidas. `..`, link simbolico e caminho absoluto nao escapam.
 *  2. extensao: so grava o que o servidor le como dado ou script.
 *  3. sintaxe: Lua passa pelo luajit antes de substituir o arquivo. Um erro
 *     de digitacao impede o boot inteiro - foi o que o blessing.lua fez.
 *
 * Toda substituicao guarda a versao anterior, entao voltar atras e copiar
 * um arquivo de volta.
 */

const fs = require('fs/promises');
const fssync = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');

const agent = require('./agent');

const RAIZ = process.env.SERVER_ROOT || '/srv/crystalserver';

// Pastas que o painel pode abrir. Fora daqui nao existe, nem para leitura.
const AREAS = [
  { chave: 'crandoria', rotulo: 'data-crandoria (seus scripts)', rel: 'data-crandoria' },
  { chave: 'core', rotulo: 'data (core do servidor)', rel: 'data' },
];

const EXT_EDITAVEIS = new Set(['.lua', '.xml', '.json', '.txt', '.md']);
const MAX_BYTES = 4 * 1024 * 1024;
const BACKUP_DIR = process.env.BACKUP_SCRIPTS_DIR || '/opt/crandoria/backups/scripts';

function areaPorChave(chave) {
  return AREAS.find((a) => a.chave === chave) || null;
}

/**
 * Resolve `rel` dentro da area e recusa qualquer coisa que saia dela.
 *
 * realpath do pai resolve link simbolico antes da comparacao: um link
 * apontando para /etc dentro da pasta de scripts nao vira uma janela para
 * o resto do disco.
 */
async function resolver(areaChave, rel, { precisaExistir = true } = {}) {
  const area = areaPorChave(areaChave);
  if (!area) throw new Error('area desconhecida');

  const base = path.resolve(RAIZ, area.rel);
  const alvo = path.resolve(base, rel || '.');

  const dentro = (p) => p === base || p.startsWith(base + path.sep);
  if (!dentro(alvo)) throw new Error('caminho fora da area permitida');

  let real = alvo;
  try {
    real = await fs.realpath(alvo);
  } catch (e) {
    if (precisaExistir) throw new Error('caminho nao encontrado');
    // Arquivo novo: confere o pai, que precisa existir de verdade.
    const paiReal = await fs.realpath(path.dirname(alvo));
    if (!dentro(paiReal)) throw new Error('caminho fora da area permitida');
    return { base, alvo, real: alvo, area };
  }
  if (!dentro(real)) throw new Error('caminho fora da area permitida (link simbolico)');

  return { base, alvo, real, area };
}

async function listar(areaChave, rel) {
  const { real, base, area } = await resolver(areaChave, rel);
  const st = await fs.stat(real);
  if (!st.isDirectory()) throw new Error('nao e uma pasta');

  const nomes = await fs.readdir(real, { withFileTypes: true });
  const itens = [];
  for (const d of nomes) {
    if (d.name.startsWith('.')) continue;
    const completo = path.join(real, d.name);
    let tamanho = 0;
    let mtime = 0;
    try {
      const s = await fs.stat(completo);
      tamanho = s.size;
      mtime = s.mtimeMs;
    } catch (_) { /* arquivo sumiu entre o readdir e o stat */ }
    itens.push({
      nome: d.name,
      pasta: d.isDirectory(),
      tamanho,
      mtime,
      editavel: !d.isDirectory() && EXT_EDITAVEIS.has(path.extname(d.name).toLowerCase()),
    });
  }

  itens.sort((a, b) => (a.pasta !== b.pasta ? (a.pasta ? -1 : 1)
    : a.nome.localeCompare(b.nome, 'pt-BR')));

  const relLimpo = path.relative(base, real).split(path.sep).join('/');
  return { area, rel: relLimpo, itens };
}

async function ler(areaChave, rel) {
  const { real } = await resolver(areaChave, rel);
  const st = await fs.stat(real);
  if (st.isDirectory()) throw new Error('e uma pasta');
  if (st.size > MAX_BYTES) throw new Error('arquivo grande demais para abrir no painel');
  const texto = await fs.readFile(real, 'utf8');
  return { texto, tamanho: st.size, mtime: st.mtimeMs };
}

/**
 * Valida Lua sem executar.
 *
 * `luajit -b` so compila: gera bytecode e descarta. Codigo no topo do
 * arquivo nao roda, entao validar um script enviado nao e um caminho para
 * execucao. A checagem acontece no host, via agente, porque e la que o
 * luajit esta instalado.
 */
async function validarLua(conteudo) {
  // O codigo vai pelo socket, nao como caminho: o painel roda em container e
  // o agente no host, entao um arquivo criado aqui nao existe la.
  const r = await agent.luacheck(conteudo);
  if (r.ok) return { ok: true };
  return { ok: false, erro: r.erro || 'erro de sintaxe' };
}

async function guardarBackup(real, areaChave, rel) {
  let anterior;
  try {
    anterior = await fs.readFile(real);
  } catch (_) {
    return null;  // arquivo novo: nao ha o que guardar
  }
  const carimbo = new Date().toISOString().replace(/[:.]/g, '-');
  const destino = path.join(BACKUP_DIR, areaChave, rel + '.' + carimbo);
  await fs.mkdir(path.dirname(destino), { recursive: true });
  await fs.writeFile(destino, anterior);
  return destino;
}

/**
 * Substitui um arquivo.
 *
 * A gravacao e atomica: escreve num temporario ao lado e renomeia. Sem isso,
 * o servidor poderia ler o arquivo pela metade se recarregasse no meio.
 */
async function gravar(areaChave, rel, conteudo, { validar = true } = {}) {
  const ext = path.extname(rel).toLowerCase();
  if (!EXT_EDITAVEIS.has(ext)) {
    throw new Error('extensao nao permitida: ' + (ext || '(sem extensao)'));
  }
  if (Buffer.byteLength(conteudo, 'utf8') > MAX_BYTES) {
    throw new Error('conteudo grande demais');
  }

  if (validar && ext === '.lua') {
    const v = await validarLua(conteudo);
    if (!v.ok) return { ok: false, erro: v.erro, sintaxe: true };
  }

  const { real, alvo } = await resolver(areaChave, rel, { precisaExistir: false });
  const destinoFinal = real || alvo;
  const backup = await guardarBackup(destinoFinal, areaChave, rel);

  const tmp = destinoFinal + '.painel-tmp';
  try {
    await fs.writeFile(tmp, conteudo, 'utf8');
    await fs.rename(tmp, destinoFinal);
  } catch (err) {
    await fs.unlink(tmp).catch(() => {});
    if (err.code === 'EACCES' || err.code === 'EPERM') {
      // Acontece quando a pasta foi criada depois do ajuste de permissao e
      // nasceu sem escrita para o grupo. O erro cru do Node nao diz o que
      // fazer, entao a mensagem traz o comando.
      throw new Error(
        'sem permissao de escrita nesta pasta. No servidor, rode: ' +
        `chgrp -R painel ${RAIZ}/<area> && chmod -R g+rwX ${RAIZ}/<area>`
      );
    }
    throw err;
  }

  return { ok: true, backup, bytes: Buffer.byteLength(conteudo, 'utf8') };
}

/** Backups do arquivo, do mais novo para o mais velho. */
async function historico(areaChave, rel) {
  const pasta = path.join(BACKUP_DIR, areaChave, path.dirname(rel));
  const prefixo = path.basename(rel) + '.';
  let nomes = [];
  try {
    nomes = await fs.readdir(pasta);
  } catch (_) {
    return [];
  }
  const itens = [];
  for (const n of nomes) {
    if (!n.startsWith(prefixo)) continue;
    try {
      const s = await fs.stat(path.join(pasta, n));
      itens.push({ nome: n, quando: n.slice(prefixo.length), tamanho: s.size, mtime: s.mtimeMs });
    } catch (_) { /* ignora */ }
  }
  itens.sort((a, b) => b.mtime - a.mtime);
  return itens.slice(0, 20);
}

/**
 * Apaga backups velhos. O disco esta em 68% e cada troca de script deixa uma
 * copia; sem teto isso cresce sozinho.
 */
async function podarBackups(manterDias = 30, manterPorArquivo = 10) {
  const limite = Date.now() - manterDias * 86400000;
  let removidos = 0;

  async function varrer(dir) {
    let entradas;
    try {
      entradas = await fs.readdir(dir, { withFileTypes: true });
    } catch (_) {
      return;
    }
    const porArquivo = new Map();
    for (const e of entradas) {
      const completo = path.join(dir, e.name);
      if (e.isDirectory()) {
        await varrer(completo);
        continue;
      }
      const base = e.name.replace(/\.\d{4}-\d{2}-\d{2}T.*$/, '');
      if (!porArquivo.has(base)) porArquivo.set(base, []);
      try {
        const s = await fs.stat(completo);
        porArquivo.get(base).push({ completo, mtime: s.mtimeMs });
      } catch (_) { /* ignora */ }
    }
    for (const lista of porArquivo.values()) {
      lista.sort((a, b) => b.mtime - a.mtime);
      for (let i = 0; i < lista.length; i++) {
        if (i >= manterPorArquivo || lista[i].mtime < limite) {
          try { await fs.unlink(lista[i].completo); removidos += 1; } catch (_) { /* ignora */ }
        }
      }
    }
  }

  if (fssync.existsSync(BACKUP_DIR)) await varrer(BACKUP_DIR);
  return removidos;
}

module.exports = {
  AREAS, EXT_EDITAVEIS, MAX_BYTES, BACKUP_DIR, RAIZ,
  listar, ler, gravar, historico, validarLua, podarBackups, resolver,
};
