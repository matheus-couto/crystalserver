/* Rola o log para o fim assim que a pagina abre.
 *
 * O `--tail` ja traz as ultimas linhas, mas o navegador mostra o topo da
 * caixa - ou seja, as mais antigas das que vieram. Quem abre o log quer ver
 * o que acabou de acontecer. */
(function () {
  'use strict';
  var pre = document.querySelector('pre.log');
  if (!pre) return;

  function aoFim() { pre.scrollTop = pre.scrollHeight; }
  aoFim();

  // Fontes e quebra de linha podem mudar a altura depois do primeiro
  // calculo; uma segunda passada garante o fim de verdade.
  window.addEventListener('load', aoFim);

  var btn = document.getElementById('ir-fim');
  if (btn) btn.addEventListener('click', function (e) { e.preventDefault(); aoFim(); });

  var topo = document.getElementById('ir-topo');
  if (topo) topo.addEventListener('click', function (e) { e.preventDefault(); pre.scrollTop = 0; });
})();
