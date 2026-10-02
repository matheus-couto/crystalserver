'use strict';

/**
 * Gerador de ZIP em fluxo, sem dependencia.
 *
 * Um arquivo por vez: le, comprime com o deflate do zlib e escreve no
 * destino, esperando o `drain` quando o navegador nao acompanha. Assim os
 * ~55 MB de scripts nunca ficam inteiros na memoria do painel.
 *
 * So o formato basico (sem ZIP64): ate 65535 arquivos e 4 GB, folgado para
 * as pastas de script.
 */

const fs = require('fs/promises');
const zlib = require('zlib');
const { promisify } = require('util');

const deflateRaw = promisify(zlib.deflateRaw);

// zlib.crc32 existe a partir do Node 22.2; a tabela e o plano B.
const TABELA = (() => {
  const t = new Uint32Array(256);
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    t[n] = c >>> 0;
  }
  return t;
})();
const crc32 = zlib.crc32 || ((buf) => {
  let c = 0xffffffff;
  for (let i = 0; i < buf.length; i++) c = TABELA[(c ^ buf[i]) & 0xff] ^ (c >>> 8);
  return (c ^ 0xffffffff) >>> 0;
});

function dataDos(ms) {
  const d = new Date(ms);
  const ano = Math.max(1980, d.getFullYear());
  return {
    hora: (d.getHours() << 11) | (d.getMinutes() << 5) | (d.getSeconds() >> 1),
    data: ((ano - 1980) << 9) | ((d.getMonth() + 1) << 5) | d.getDate(),
  };
}

function escrever(destino, buf) {
  if (destino.write(buf)) return Promise.resolve();
  return new Promise((ok, falha) => {
    const fim = (err) => {
      destino.off('drain', fim);
      destino.off('close', fechou);
      if (err) falha(err); else ok();
    };
    const fechou = () => fim(new Error('conexao encerrada'));
    destino.once('drain', fim);
    destino.once('close', fechou);
  });
}

/**
 * Escreve em `destino` um ZIP com `arquivos` ([{ caminho, nome }], onde
 * `nome` e o caminho dentro do ZIP, com barras normais).
 */
async function gerar(destino, arquivos) {
  if (arquivos.length > 0xffff) throw new Error('arquivos demais para um ZIP sem ZIP64');
  const central = [];
  let offset = 0;

  for (const a of arquivos) {
    let dados;
    let st;
    try {
      st = await fs.stat(a.caminho);
      dados = await fs.readFile(a.caminho);
    } catch (_) {
      continue;  // sumiu entre a listagem e a leitura
    }
    const comprimido = await deflateRaw(dados, { level: 6 });
    // Arquivo que nao encolhe vai sem compressao.
    const guardado = comprimido.length < dados.length;
    const corpo = guardado ? comprimido : dados;
    const nome = Buffer.from(a.nome, 'utf8');
    const { hora, data } = dataDos(st.mtimeMs);
    const crc = crc32(dados) >>> 0;
    if (offset + 30 + nome.length + corpo.length > 0xffffffff) throw new Error('ZIP passou de 4 GB');

    const local = Buffer.alloc(30);
    local.writeUInt32LE(0x04034b50, 0);
    local.writeUInt16LE(20, 4);              // versao necessaria
    local.writeUInt16LE(0x0800, 6);          // nomes em UTF-8
    local.writeUInt16LE(guardado ? 8 : 0, 8);
    local.writeUInt16LE(hora, 10);
    local.writeUInt16LE(data, 12);
    local.writeUInt32LE(crc, 14);
    local.writeUInt32LE(corpo.length, 18);
    local.writeUInt32LE(dados.length, 22);
    local.writeUInt16LE(nome.length, 26);
    local.writeUInt16LE(0, 28);

    await escrever(destino, local);
    await escrever(destino, nome);
    await escrever(destino, corpo);

    const c = Buffer.alloc(46);
    c.writeUInt32LE(0x02014b50, 0);
    c.writeUInt16LE(0x0314, 4);              // feito por: Unix, versao 2.0
    c.writeUInt16LE(20, 6);
    c.writeUInt16LE(0x0800, 8);
    c.writeUInt16LE(guardado ? 8 : 0, 10);
    c.writeUInt16LE(hora, 12);
    c.writeUInt16LE(data, 14);
    c.writeUInt32LE(crc, 16);
    c.writeUInt32LE(corpo.length, 20);
    c.writeUInt32LE(dados.length, 24);
    c.writeUInt16LE(nome.length, 28);
    c.writeUInt32LE(((0o100644) << 16) >>> 0, 38);  // permissao rw-r--r--
    c.writeUInt32LE(offset, 42);
    central.push(c, nome);

    offset += 30 + nome.length + corpo.length;
  }

  const inicioCentral = offset;
  let tamanhoCentral = 0;
  for (const b of central) {
    await escrever(destino, b);
    tamanhoCentral += b.length;
  }

  const fim = Buffer.alloc(22);
  fim.writeUInt32LE(0x06054b50, 0);
  fim.writeUInt16LE(central.length / 2, 8);
  fim.writeUInt16LE(central.length / 2, 10);
  fim.writeUInt32LE(tamanhoCentral, 12);
  fim.writeUInt32LE(inicioCentral, 16);
  await escrever(destino, fim);
  return central.length / 2;
}

module.exports = { gerar };
