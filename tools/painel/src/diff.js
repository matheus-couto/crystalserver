'use strict';

/**
 * Diferenca linha a linha entre duas versoes de um arquivo (algoritmo de
 * Myers), agrupada em trechos com algumas linhas de contexto - o mesmo
 * formato de um `git diff`.
 *
 * Sem dependencia externa: a imagem do painel fica do mesmo tamanho e o
 * calculo e pequeno para os arquivos que o painel abre (ate 4 MB).
 */

// Acima disso a comparacao vira custo demais para uma pagina web: sao
// arquivos praticamente reescritos, e a lista de diferencas nao ajudaria.
const MAX_EDICOES = 2000;

function separar(texto) {
  const linhas = String(texto).replace(/\r\n/g, '\n').split('\n');
  if (linhas.length && linhas[linhas.length - 1] === '') linhas.pop();
  return linhas;
}

/** Lista de operacoes { t: ' ' | '-' | '+', a, b, texto }, ou null se grande demais. */
function operacoes(antes, depois) {
  const A = separar(antes);
  const B = separar(depois);

  // Prefixo e sufixo iguais saem da conta: na edicao tipica sobra pouco.
  let ini = 0;
  while (ini < A.length && ini < B.length && A[ini] === B[ini]) ini++;
  let fimA = A.length;
  let fimB = B.length;
  while (fimA > ini && fimB > ini && A[fimA - 1] === B[fimB - 1]) { fimA--; fimB--; }

  const a = A.slice(ini, fimA);
  const b = B.slice(ini, fimB);
  const N = a.length;
  const M = b.length;
  const MAX = N + M;
  const off = MAX + 1;
  const v = new Int32Array(2 * MAX + 3);
  const trilha = [];

  let achou = N === 0 && M === 0;
  for (let d = 0; d <= MAX && !achou; d++) {
    if (d > MAX_EDICOES) return null;
    // So a faixa que o passo d le (k de -d-1 a d+1): guardar o vetor inteiro
    // a cada passo passaria de centenas de MB num arquivo grande reescrito.
    trilha.push(v.slice(off - d - 1, off + d + 2));
    for (let k = -d; k <= d; k += 2) {
      let x = (k === -d || (k !== d && v[off + k - 1] < v[off + k + 1]))
        ? v[off + k + 1]
        : v[off + k - 1] + 1;
      let y = x - k;
      while (x < N && y < M && a[x] === b[y]) { x++; y++; }
      v[off + k] = x;
      if (x >= N && y >= M) { achou = true; break; }
    }
  }

  // Volta pela trilha para montar as operacoes do meio.
  const meio = [];
  let x = N;
  let y = M;
  for (let d = trilha.length - 1; d >= 0 && (x > 0 || y > 0); d--) {
    const faixa = trilha[d];
    const vv = (kk) => faixa[kk + d + 1];
    const k = x - y;
    const kAnt = (k === -d || (k !== d && vv(k - 1) < vv(k + 1))) ? k + 1 : k - 1;
    const xAnt = vv(kAnt);
    const yAnt = xAnt - kAnt;
    while (x > xAnt && y > yAnt) { meio.push({ t: ' ', ia: x - 1, ib: y - 1 }); x--; y--; }
    if (d > 0) {
      if (x === xAnt) meio.push({ t: '+', ib: y - 1 });
      else meio.push({ t: '-', ia: x - 1 });
    }
    x = xAnt;
    y = yAnt;
  }
  meio.reverse();

  const ops = [];
  for (let i = 0; i < ini; i++) ops.push({ t: ' ', a: i + 1, b: i + 1, texto: A[i] });
  for (const o of meio) {
    if (o.t === ' ') ops.push({ t: ' ', a: ini + o.ia + 1, b: ini + o.ib + 1, texto: a[o.ia] });
    else if (o.t === '-') ops.push({ t: '-', a: ini + o.ia + 1, b: null, texto: a[o.ia] });
    else ops.push({ t: '+', a: null, b: ini + o.ib + 1, texto: b[o.ib] });
  }
  for (let i = fimA; i < A.length; i++) {
    ops.push({ t: ' ', a: i + 1, b: fimB + (i - fimA) + 1, texto: A[i] });
  }
  return ops;
}

/**
 * Trechos com mudanca, cada um com `contexto` linhas iguais em volta.
 * Devolve { trechos, adicionadas, removidas } ou null se grande demais.
 */
function trechos(antes, depois, contexto = 3) {
  const ops = operacoes(antes, depois);
  if (!ops) return null;

  let adicionadas = 0;
  let removidas = 0;
  const marcar = new Uint8Array(ops.length);
  ops.forEach((o, i) => {
    if (o.t === ' ') return;
    if (o.t === '+') adicionadas++; else removidas++;
    for (let j = Math.max(0, i - contexto); j <= Math.min(ops.length - 1, i + contexto); j++) marcar[j] = 1;
  });

  const lista = [];
  let atual = null;
  ops.forEach((o, i) => {
    if (!marcar[i]) { atual = null; return; }
    if (!atual) { atual = []; lista.push(atual); }
    atual.push(o);
  });
  return { trechos: lista, adicionadas, removidas };
}

module.exports = { trechos, operacoes, MAX_EDICOES };
