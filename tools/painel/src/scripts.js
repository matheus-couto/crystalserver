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
const { Transform } = require('stream');
const { pipeline } = require('stream/promises');

const agent = require('./agent');

const RAIZ = process.env.SERVER_ROOT || '/srv/crystalserver';

// Pastas que o painel pode abrir. Fora daqui nao existe, nem para leitura.
const AREAS = [
  { chave: 'crandoria', rotulo: 'data-crandoria (seus scripts)', rel: 'data-crandoria' },
  { chave: 'core', rotulo: 'data (core do servidor)', rel: 'data' },
  // Sem montagem: o painel le e grava pelo agente do host (ver agent.py).
  { chave: 'config', rotulo: 'config.lua', rel: null, viaAgente: true },
];

const CONFIG_NOME = 'config.lua';

function ehConfig(areaChave) {
  return areaChave === 'config';
}

async function lerConfig() {
  const r = await agent.configLer();
  if (!r.ok) throw new Error('nao consegui ler o config.lua: ' + (r.erro || 'erro no agente'));
  return r;
}

const EXT_EDITAVEIS = new Set(['.lua', '.xml', '.json', '.txt', '.md']);
const MAX_BYTES = 4 * 1024 * 1024;

// O mapa nao abre no editor - e binario e tem 130 MB -, mas pode ser
// substituido pelo envio em fluxo (`receber`).
const EXT_MAPA = new Set(['.otbm']);
const MAX_ENVIO = 512 * 1024 * 1024;
// Cada versao guardada do mapa ocupa o mesmo que ele, num disco de 38 GB.
const BACKUPS_POR_MAPA = 2;
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
  if (!area || area.viaAgente) throw new Error('area desconhecida');

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
  if (ehConfig(areaChave)) {
    const c = await lerConfig();
    return {
      area: areaPorChave(areaChave), rel: '',
      itens: [{ nome: CONFIG_NOME, pasta: false, tamanho: c.tamanho, mtime: c.mtime, editavel: true }],
    };
  }
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
    const ext = path.extname(d.name).toLowerCase();
    itens.push({
      nome: d.name,
      pasta: d.isDirectory(),
      tamanho,
      mtime,
      editavel: !d.isDirectory() && EXT_EDITAVEIS.has(ext),
      mapa: !d.isDirectory() && EXT_MAPA.has(ext),
    });
  }

  itens.sort((a, b) => (a.pasta !== b.pasta ? (a.pasta ? -1 : 1)
    : a.nome.localeCompare(b.nome, 'pt-BR')));

  const relLimpo = path.relative(base, real).split(path.sep).join('/');
  return { area, rel: relLimpo, itens };
}

async function ler(areaChave, rel) {
  if (ehConfig(areaChave)) {
    if (rel !== CONFIG_NOME) throw new Error('caminho nao encontrado');
    const c = await lerConfig();
    return { texto: c.texto, tamanho: c.tamanho, mtime: c.mtime };
  }
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
  if (!fssync.existsSync(real)) return null;  // arquivo novo: nao ha o que guardar
  const carimbo = new Date().toISOString().replace(/[:.]/g, '-');
  const destino = path.join(BACKUP_DIR, areaChave, rel + '.' + carimbo);
  await fs.mkdir(path.dirname(destino), { recursive: true });
  // copyFile, e nao ler para a memoria: o anterior pode ser o mapa inteiro.
  await fs.copyFile(real, destino);
  return destino;
}

/**
 * Substitui um arquivo.
 *
 * A gravacao e atomica: escreve num temporario ao lado e renomeia. Sem isso,
 * o servidor poderia ler o arquivo pela metade se recarregasse no meio.
 */
async function gravar(areaChave, rel, conteudo, { validar = true } = {}) {
  if (ehConfig(areaChave)) {
    // Arquivo unico e caminho fixo: o agente valida, guarda o anterior e grava.
    if (rel !== CONFIG_NOME) throw new Error('so o config.lua pode ser gravado nesta area');
    const r = await agent.configGravar(conteudo);
    if (!r.ok) return { ok: false, erro: r.erro || 'o agente nao gravou o config.lua', sintaxe: !!r.sintaxe };
    return r;
  }
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

/**
 * Recebe um arquivo enviado, lendo de `origem` (a propria requisicao) direto
 * para o disco.
 *
 * Existe por causa do mapa: o envio multipart junta o corpo inteiro na
 * memoria e converte para texto, o que nao serve para 130 MB de binario.
 * Aqui o arquivo vai para um temporario ao lado do destino e so troca de
 * nome no fim, entao um envio interrompido nao deixa o mapa pela metade.
 *
 * Lua continua passando pelo luajit: e pequeno, entao junta e cai no
 * `gravar` de sempre.
 */
async function receber(areaChave, rel, origem, tamanhoDeclarado = 0) {
  if (ehConfig(areaChave)) throw new Error('o config.lua se altera pelo editor, nao por envio');
  const ext = path.extname(rel).toLowerCase();
  if (!EXT_EDITAVEIS.has(ext) && !EXT_MAPA.has(ext)) {
    throw new Error('extensao nao permitida: ' + (ext || '(sem extensao)'));
  }
  if (tamanhoDeclarado > MAX_ENVIO) throw new Error('arquivo grande demais');

  if (ext === '.lua') {
    const partes = [];
    let total = 0;
    for await (const pedaco of origem) {
      total += pedaco.length;
      if (total > MAX_BYTES) throw new Error('conteudo grande demais');
      partes.push(pedaco);
    }
    return gravar(areaChave, rel, Buffer.concat(partes).toString('utf8'));
  }

  const { real, alvo } = await resolver(areaChave, rel, { precisaExistir: false });
  const destinoFinal = real || alvo;

  // Temporario + versao guardada + o arquivo atual ficam no disco ao mesmo
  // tempo. Melhor recusar antes do que encher o disco no meio do envio.
  if (tamanhoDeclarado && fs.statfs) {
    const sf = await fs.statfs(path.dirname(destinoFinal));
    const livre = sf.bavail * sf.bsize;
    if (livre < tamanhoDeclarado * 2 + 512 * 1024 * 1024) {
      throw new Error(`pouco espaco em disco (${Math.round(livre / 2 ** 20)} MB livres)`);
    }
  }

  let total = 0;
  let inicio = Buffer.alloc(0);
  const contador = new Transform({
    transform(pedaco, _enc, cb) {
      total += pedaco.length;
      if (total > MAX_ENVIO) return cb(new Error('arquivo grande demais'));
      if (inicio.length < 8) inicio = Buffer.concat([inicio, pedaco.subarray(0, 8)]).subarray(0, 8);
      cb(null, pedaco);
    },
  });

  const tmp = destinoFinal + '.painel-tmp';
  try {
    await pipeline(origem, contador, fssync.createWriteStream(tmp));
    if (!total) throw new Error('arquivo vazio');
    // Cabecalho OTBM: identificador "OTBM" (ou quatro zeros, que o loader
    // tambem aceita) seguido do inicio do no raiz, 0xFE. Pega o engano mais
    // comum - mandar o .rar, o .otbm de outro editor salvo errado - antes
    // de ele derrubar o boot.
    if (EXT_MAPA.has(ext)) {
      const id = inicio.subarray(0, 4).toString('latin1');
      if (inicio.length < 5 || (id !== 'OTBM' && inicio.readUInt32LE(0) !== 0) || inicio[4] !== 0xFE) {
        throw new Error('nao parece um mapa .otbm valido');
      }
    }
    const backup = await guardarBackup(destinoFinal, areaChave, rel);
    await fs.rename(tmp, destinoFinal);
    if (EXT_MAPA.has(ext)) podarBackups().catch(() => {});
    return { ok: true, backup, bytes: total };
  } catch (err) {
    await fs.unlink(tmp).catch(() => {});
    if (err.code === 'EACCES' || err.code === 'EPERM') {
      throw new Error(
        'sem permissao de escrita nesta pasta. No servidor, rode: ' +
        `chgrp -R painel ${RAIZ}/<area> && chmod -R g+rwX ${RAIZ}/<area>`
      );
    }
    throw err;
  }
}

/**
 * Cria uma pasta dentro de `rel`.
 *
 * O nome e um componente so - sem barra, sem `..`, sem ponto no inicio
 * (pasta oculta nao aparece na listagem, entao ficaria invisivel no painel).
 * O pai passa pelo mesmo resolver de sempre.
 */
async function criarPasta(areaChave, rel, nome) {
  if (ehConfig(areaChave)) throw new Error('nao ha pastas nesta area');
  nome = String(nome || '').trim();
  if (!/^[A-Za-z0-9_][A-Za-z0-9 _.-]{0,63}$/.test(nome)) {
    throw new Error('nome de pasta invalido: use letras, numeros, espaco, ponto, - e _');
  }
  const { real } = await resolver(areaChave, rel);
  const st = await fs.stat(real);
  if (!st.isDirectory()) throw new Error('nao e uma pasta');

  const nova = path.join(real, nome);
  try {
    await fs.mkdir(nova);
  } catch (err) {
    if (err.code === 'EEXIST') throw new Error(`ja existe "${nome}" nesta pasta`);
    if (err.code === 'EACCES' || err.code === 'EPERM') {
      throw new Error('sem permissao de escrita nesta pasta. No servidor, rode: ' +
        `chgrp -R painel ${RAIZ}/<area> && chmod -R g+rwX ${RAIZ}/<area>`);
    }
    throw err;
  }
  // Grupo com escrita e setgid, como o ajuste do README: assim o que for
  // criado dentro dela tambem nasce gravavel pelo painel.
  await fs.chmod(nova, 0o2775).catch(() => {});
  const relNova = path.relative(path.resolve(RAIZ, areaPorChave(areaChave).rel), nova).split(path.sep).join('/');
  return { rel: relNova };
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
    for (const [base, lista] of porArquivo) {
      const manter = EXT_MAPA.has(path.extname(base).toLowerCase())
        ? Math.min(manterPorArquivo, BACKUPS_POR_MAPA) : manterPorArquivo;
      lista.sort((a, b) => b.mtime - a.mtime);
      for (let i = 0; i < lista.length; i++) {
        if (i >= manter || lista[i].mtime < limite) {
          try { await fs.unlink(lista[i].completo); removidos += 1; } catch (_) { /* ignora */ }
        }
      }
    }
  }

  if (fssync.existsSync(BACKUP_DIR)) await varrer(BACKUP_DIR);
  return removidos;
}

/**
 * Conteudo de uma versao guardada, para comparar com a atual.
 *
 * O nome vem da URL, entao passa pelo mesmo teste da lista do historico:
 * precisa ser um backup daquele arquivo, e nada com barra entra.
 */
async function lerBackup(areaChave, rel, nome) {
  const prefixo = path.basename(rel) + '.';
  if (!nome || nome.includes('/') || nome.includes('\\') || !nome.startsWith(prefixo)) {
    throw new Error('versao invalida');
  }
  if (!areaPorChave(areaChave)) throw new Error('area desconhecida');
  const completo = path.join(BACKUP_DIR, areaChave, path.dirname(rel), nome);
  const base = path.resolve(BACKUP_DIR, areaChave);
  if (!path.resolve(completo).startsWith(base + path.sep)) throw new Error('versao invalida');
  const st = await fs.stat(completo).catch(() => null);
  if (!st) throw new Error('versao nao encontrada');
  if (st.size > MAX_BYTES) throw new Error('versao grande demais para comparar');
  return { texto: await fs.readFile(completo, 'utf8'), mtime: st.mtimeMs };
}

/**
 * Arquivos editaveis alterados nos ultimos `dias`, do mais novo para o mais
 * velho, em todas as areas.
 *
 * Varre as pastas inteiras (uns 10 mil arquivos), entao o resultado fica
 * guardado por alguns segundos: recarregar a pagina nao repete a varredura.
 */
let cacheRecentes = { quando: 0, itens: null };
const CACHE_RECENTES_MS = 15 * 1000;

async function varrerTudo() {
  if (cacheRecentes.itens && Date.now() - cacheRecentes.quando < CACHE_RECENTES_MS) {
    return cacheRecentes.itens;
  }
  const itens = [];
  for (const area of AREAS) {
    if (area.viaAgente) continue;
    const base = path.resolve(RAIZ, area.rel);
    const pilha = [''];
    while (pilha.length) {
      const rel = pilha.pop();
      let entradas;
      try {
        entradas = await fs.readdir(path.join(base, rel), { withFileTypes: true });
      } catch (_) {
        continue;
      }
      for (const d of entradas) {
        if (d.name.startsWith('.')) continue;
        const r = rel ? rel + '/' + d.name : d.name;
        // Sem seguir link simbolico: e o mesmo confinamento do resolver.
        // logs/ sao registros do servidor (logins, comandos), nao codigo.
        if (d.isDirectory()) { if (d.name !== 'logs') pilha.push(r); continue; }
        if (!d.isFile() || !EXT_EDITAVEIS.has(path.extname(d.name).toLowerCase())) continue;
        try {
          const s = await fs.stat(path.join(base, r));
          itens.push({ area: area.chave, rel: r, tamanho: s.size, mtime: s.mtimeMs });
        } catch (_) { /* sumiu no meio */ }
      }
    }
  }
  try {
    const c = await lerConfig();
    itens.push({ area: 'config', rel: CONFIG_NOME, tamanho: c.tamanho, mtime: c.mtime });
  } catch (_) { /* agente fora: a lista sai sem o config */ }

  itens.sort((a, b) => b.mtime - a.mtime);
  cacheRecentes = { quando: Date.now(), itens };
  return itens;
}

// Muitos arquivos com o mesmo minuto sao um envio em lote (deploy, upload
// da pasta inteira), nao edicoes. Soltos na lista, enterrariam o resto.
const MIN_LOTE = 30;
const minuto = (ms) => Math.floor(ms / 60000);

/**
 * Alterados no periodo. Envios em lote saem da lista e voltam resumidos em
 * `lotes`; com `lote` (o minuto de um deles), lista so os arquivos dele.
 */
async function recentes({ dias = 7, busca = '', area = '', lote = null, limite = 300 } = {}) {
  const desde = Date.now() - dias * 86400000;
  const termo = String(busca || '').toLowerCase();
  const todos = await varrerTudo();
  const filtrados = todos.filter((i) => i.mtime >= desde
    && (!area || i.area === area)
    && (!termo || i.rel.toLowerCase().includes(termo)));

  if (lote != null) {
    const soLote = filtrados.filter((i) => minuto(i.mtime) === lote);
    return { itens: soLote.slice(0, limite), total: soLote.length, lotes: [] };
  }

  const porMinuto = new Map();
  for (const i of filtrados) porMinuto.set(minuto(i.mtime), (porMinuto.get(minuto(i.mtime)) || 0) + 1);
  const lotes = [...porMinuto].filter(([, n]) => n >= MIN_LOTE)
    .map(([m, n]) => ({ minuto: m, quantidade: n })).sort((a, b) => b.minuto - a.minuto);
  const emLote = new Set(lotes.map((l) => l.minuto));
  const soltos = filtrados.filter((i) => !emLote.has(minuto(i.mtime)));
  return { itens: soltos.slice(0, limite), total: soltos.length, lotes };
}

// Fora do ZIP de scripts: os mapas e pacotes (centenas de MB, e quem baixa
// ja tem) e os logs do servidor, que sao registro e nao codigo.
const FORA_DO_ZIP = new Set(['.otbm', '.rar']);

/**
 * Todos os arquivos das areas em disco, para o ZIP de "baixar tudo".
 * `nome` e o caminho dentro do ZIP, comecando pela pasta da area.
 */
async function arquivosParaZip() {
  const lista = [];
  for (const area of AREAS) {
    if (area.viaAgente) continue;
    const base = path.resolve(RAIZ, area.rel);
    const pilha = [''];
    while (pilha.length) {
      const rel = pilha.pop();
      let entradas;
      try {
        entradas = await fs.readdir(path.join(base, rel), { withFileTypes: true });
      } catch (_) {
        continue;
      }
      for (const d of entradas) {
        if (d.name.startsWith('.') || d.name.endsWith('.painel-tmp')) continue;
        const r = rel ? rel + '/' + d.name : d.name;
        // Sem seguir link simbolico, como na varredura dos recentes.
        if (d.isDirectory()) { if (d.name !== 'logs') pilha.push(r); continue; }
        if (!d.isFile() || FORA_DO_ZIP.has(path.extname(d.name).toLowerCase())) continue;
        lista.push({ caminho: path.join(base, r), nome: area.rel + '/' + r });
      }
    }
  }
  lista.sort((a, b) => a.nome.localeCompare(b.nome));
  return lista;
}

function esquecerRecentes() {
  cacheRecentes = { quando: 0, itens: null };
}

module.exports = {
  AREAS, EXT_EDITAVEIS, EXT_MAPA, MAX_BYTES, BACKUP_DIR, RAIZ,
  listar, ler, gravar, receber, criarPasta, historico, validarLua, podarBackups, resolver,
  lerBackup, recentes, esquecerRecentes, arquivosParaZip,
};
