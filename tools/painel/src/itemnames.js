'use strict';

/**
 * Nomes dos itens, lidos do items.xml.
 *
 * Em memoria, e nao numa tabela do banco: o arquivo e a fonte da verdade e
 * muda junto com o servidor. Uma tabela precisaria de reimportacao a cada
 * alteracao, e a primeira vez que alguem esquecesse disso o painel comecaria
 * a mostrar nome errado - que e pior do que nao mostrar nome nenhum.
 *
 * Sao ~17 mil entradas, varias delas faixas de id. Expandido da uns 40 mil
 * pares id->nome, algo como 3 MB de heap. Cabe folgado.
 */

const fs = require('fs/promises');
const path = require('path');

const CAMINHO = process.env.ITEMS_XML
  || path.join(process.env.SERVER_ROOT || '/srv/crystalserver', 'data/items/items.xml');

// Id acima disto nao existe no jogo; serve de trava contra uma faixa
// absurda no XML virar um laco de milhoes de voltas.
const ID_MAX = 200000;

let cache = null;      // Map<number, string>
let carregadoDe = 0;   // mtime do arquivo quando foi lido
let carregando = null; // promessa em voo, para nao ler o arquivo duas vezes

/**
 * O items.xml e declarado como ISO-8859-1. Ler como utf8 estraga acento e,
 * pior, pode gerar caractere invalido no meio de um nome.
 */
function decodificar(buf) {
  return new TextDecoder('latin1').decode(buf);
}

function desescapar(s) {
  return s.replace(/&(amp|lt|gt|quot|apos|#39);/g, (_, e) => ({
    amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", '#39': "'",
  }[e]));
}

async function carregar() {
  let st;
  try {
    st = await fs.stat(CAMINHO);
  } catch (_) {
    cache = new Map();
    return cache;
  }

  if (cache && st.mtimeMs === carregadoDe) return cache;
  if (carregando) return carregando;

  carregando = (async () => {
    const texto = decodificar(await fs.readFile(CAMINHO));
    const mapa = new Map();

    // Uma regex so, sobre a tag inteira, em vez de um parser de XML: o
    // arquivo e gerado por ferramenta e o formato das tags <item> e estavel.
    const re = /<item\s+([^>]*?)\/?>/g;
    let m;
    while ((m = re.exec(texto)) !== null) {
      const attrs = m[1];
      const nome = /\bname="([^"]*)"/.exec(attrs);
      if (!nome) continue;
      const valor = desescapar(nome[1]).trim();
      if (!valor) continue;

      const unico = /\bid="(\d+)"/.exec(attrs);
      if (unico) {
        mapa.set(Number(unico[1]), valor);
        continue;
      }

      const de = /\bfromid="(\d+)"/.exec(attrs);
      const ate = /\btoid="(\d+)"/.exec(attrs);
      if (de && ate) {
        const a = Number(de[1]);
        const b = Math.min(Number(ate[1]), ID_MAX);
        if (b >= a && b - a < 50000) {
          for (let i = a; i <= b; i++) mapa.set(i, valor);
        }
      }
    }

    cache = mapa;
    carregadoDe = st.mtimeMs;
    carregando = null;
    return mapa;
  })();

  return carregando;
}

/** Nome de um item, ou null se o XML nao souber. */
async function nome(id) {
  const m = await carregar();
  return m.get(Number(id)) || null;
}

/** Varios de uma vez, para nao reabrir o cache por linha de tabela. */
async function nomes(ids) {
  const m = await carregar();
  const fora = new Map();
  for (const id of ids) fora.set(Number(id), m.get(Number(id)) || null);
  return fora;
}

/** Ids cujo nome contem o termo. Usado na busca por nome. */
async function buscar(termo, limite = 60) {
  const m = await carregar();
  const alvo = String(termo || '').toLowerCase().trim();
  if (!alvo) return [];

  const exatos = [];
  const parciais = [];
  for (const [id, n] of m) {
    const baixo = n.toLowerCase();
    if (baixo === alvo) exatos.push({ id, nome: n });
    else if (baixo.includes(alvo)) parciais.push({ id, nome: n });
    if (exatos.length + parciais.length > 4000) break;
  }

  // Nome igual vem antes do que so contem o termo: quem digita "crystal
  // coin" quer o 3043, nao "crystal coin bag".
  const ordena = (a, b) => a.nome.localeCompare(b.nome, 'pt-BR') || a.id - b.id;
  return exatos.sort(ordena).concat(parciais.sort(ordena)).slice(0, limite);
}

async function total() {
  return (await carregar()).size;
}

module.exports = { nome, nomes, buscar, total, CAMINHO };
