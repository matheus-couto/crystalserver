/* Envio de arquivo em fluxo, com progresso.
 *
 * O formulario multipart junta o corpo inteiro na memoria do painel e para
 * em 8 MB - o mapa tem 130 MB. Aqui o arquivo vai cru no corpo para
 * /scripts/enviar-arquivo, que grava direto no disco. Sem JavaScript, o
 * formulario continua funcionando para os scripts pequenos. */
(function () {
  'use strict';
  var form = document.getElementById('form-enviar');
  if (!form || !window.XMLHttpRequest) return;

  var estado = document.getElementById('estado-envio');
  var botao = form.querySelector('button[type="submit"]');
  var enviando = false;

  function mostrar(texto, classe) {
    if (!estado) return;
    estado.textContent = texto;
    estado.className = classe || '';
  }

  function mb(n) { return (n / 1048576).toFixed(1) + ' MB'; }

  window.addEventListener('beforeunload', function (ev) {
    if (enviando) {
      ev.preventDefault();
      ev.returnValue = '';
    }
  });

  form.addEventListener('submit', function (ev) {
    ev.preventDefault();
    if (enviando) return;
    var input = form.querySelector('input[type="file"]');
    var arq = input && input.files && input.files[0];
    if (!arq) return;

    if (/\.otbm$/i.test(arq.name) && !window.confirm(
      'Substituir o mapa ' + arq.name + ' (' + mb(arq.size) + ')?\n\n' +
      'A versao atual fica guardada. O mapa novo so vale depois de reiniciar o servidor.')) {
      return;
    }

    var q = '?a=' + encodeURIComponent(form.elements.a.value) +
      '&p=' + encodeURIComponent(form.elements.p.value) +
      '&f=' + encodeURIComponent(arq.name);
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/scripts/enviar-arquivo' + q);
    xhr.setRequestHeader('Content-Type', 'application/octet-stream');
    xhr.setRequestHeader('X-CSRF-Token', form.elements._csrf.value);

    xhr.upload.addEventListener('progress', function (e) {
      if (!e.lengthComputable) return;
      var pct = Math.floor(e.loaded * 100 / e.total);
      mostrar(pct < 100 ? 'enviando ' + pct + '% (' + mb(e.loaded) + ' de ' + mb(e.total) + ')'
        : 'gravando no servidor...', 'pill frio');
    });

    function fim(erro) {
      enviando = false;
      if (botao) botao.disabled = false;
      mostrar('Nao enviei: ' + erro, 'pill alerta');
    }

    xhr.addEventListener('load', function () {
      var r = null;
      try { r = JSON.parse(xhr.responseText); } catch (_) { /* resposta nao e JSON */ }
      if (r && r.ok) {
        enviando = false;
        window.location.href = r.destino;
      } else if (r && r.erro) {
        fim(r.erro);
      } else if (xhr.status === 413) {
        fim('arquivo maior que o limite do servidor.');
      } else {
        fim('resposta inesperada do servidor (HTTP ' + xhr.status + ').');
      }
    });
    xhr.addEventListener('error', function () { fim('a conexao caiu durante o envio.'); });

    enviando = true;
    if (botao) botao.disabled = true;
    mostrar('enviando 0%', 'pill frio');
    xhr.send(arq);
  });
})();
