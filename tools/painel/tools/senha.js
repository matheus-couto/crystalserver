#!/usr/bin/env node
'use strict';

/**
 * Gera o hash de uma senha para a tabela panel_users.
 *
 * A senha entra por stdin, nao por argumento: argumento aparece no `ps` e
 * fica no historico do shell.
 *
 *     docker compose exec painel node tools/senha.js
 */

const readline = require('readline');
const { hashSenha } = require('../src/auth');

const rl = readline.createInterface({ input: process.stdin, output: process.stderr });
rl.question('Senha: ', (senha) => {
  rl.close();
  if (!senha || senha.length < 12) {
    console.error('Use pelo menos 12 caracteres. Sem segundo fator, a senha e a unica barreira.');
    process.exit(1);
  }
  process.stdout.write(hashSenha(senha) + '\n');
});
