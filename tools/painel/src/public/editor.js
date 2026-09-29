/* Editor de arquivos do painel.
 *
 * Em arquivo separado de proposito: assim a pagina nao precisa de script
 * inline, e a politica de seguranca pode continuar recusando qualquer
 * codigo que nao venha do proprio painel.
 */
(function () {
  'use strict';

  var area = document.getElementById('editor');
  if (!area || typeof CodeMirror === 'undefined') return;

  var MODOS = {
    '.lua': 'lua',
    '.xml': 'xml',
    '.json': { name: 'javascript', json: true },
    '.js': 'javascript',
  };

  var nome = area.getAttribute('data-nome') || '';
  var ponto = nome.lastIndexOf('.');
  var modo = ponto >= 0 ? MODOS[nome.slice(ponto).toLowerCase()] : null;

  var cm = CodeMirror.fromTextArea(area, {
    mode: modo || null,
    lineNumbers: true,
    lineWrapping: false,
    matchBrackets: true,
    styleActiveLine: true,
    indentUnit: 4,
    tabSize: 4,
    // Os scripts do servidor sao indentados com tab; espaco aqui deixaria o
    // arquivo misturado e o diff ilegivel.
    indentWithTabs: true,
    extraKeys: {
      'Ctrl-S': function () { salvar(); },
      'Cmd-S': function () { salvar(); },
      'Ctrl-F': 'findPersistent',
      Tab: function (editor) {
        if (editor.somethingSelected()) editor.indentSelection('add');
        else editor.replaceSelection('\t');
      },
    },
  });

  var form = document.getElementById('form-editor');
  var aviso = document.getElementById('estado-editor');
  var original = cm.getValue();
  var sujo = false;
  var salvando = false;

  function marcar() {
    var agora = cm.getValue() !== original;
    if (agora === sujo) return;
    sujo = agora;
    if (aviso) {
      aviso.textContent = sujo ? 'alteracoes nao salvas' : '';
      aviso.className = sujo ? 'pill alerta' : '';
    }
  }

  function salvar() {
    if (salvando) return;
    salvando = true;
    cm.save();       // devolve o conteudo para o textarea que sera enviado
    form.submit();
  }

  cm.on('change', marcar);

  if (form) {
    form.addEventListener('submit', function () {
      salvando = true;
      cm.save();
    });
  }

  // Sair da pagina com alteracao pendente e a forma mais facil de perder
  // trabalho aqui, entao o navegador pergunta antes.
  window.addEventListener('beforeunload', function (ev) {
    if (sujo && !salvando) {
      ev.preventDefault();
      ev.returnValue = '';
    }
  });

  var btn = document.getElementById('btn-salvar');
  if (btn) {
    btn.addEventListener('click', function (ev) {
      ev.preventDefault();
      salvar();
    });
  }

  var pos = document.getElementById('pos-editor');
  function atualizarPos() {
    if (!pos) return;
    var c = cm.getCursor();
    pos.textContent = 'linha ' + (c.line + 1) + ', coluna ' + (c.ch + 1);
  }
  cm.on('cursorActivity', atualizarPos);
  atualizarPos();

  cm.focus();
})();
