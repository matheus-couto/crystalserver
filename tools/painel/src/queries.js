'use strict';

/**
 * Consultas de jogo: jogadores, doacoes e itens.
 *
 * Sobre os itens, um aviso que vale repetir na tela: estas tabelas guardam o
 * que foi SALVO. O inventario de quem esta online mora na memoria do
 * servidor e so desce para o banco no logout ou no save. Entao numero de
 * jogador online esta sempre atrasado, e procurar duplicacao com gente
 * logada rende pista falsa.
 */

// As tres tabelas cobrem inventario, depot e inbox. Elas tem o mesmo formato,
// o que permite somar as tres num UNION ALL e tratar como um estoque so.
const FONTES_ITENS = [
  { tabela: 'player_items', rotulo: 'inventario' },
  { tabela: 'player_depotitems', rotulo: 'depot' },
  { tabela: 'player_inboxitems', rotulo: 'inbox' },
];

const UNIAO_ITENS = FONTES_ITENS
  .map((f) => `SELECT \`player_id\`, \`itemtype\`, \`count\`, '${f.rotulo}' AS \`origem\` FROM \`${f.tabela}\``)
  .join(' UNION ALL ');

/** Um item nao empilhavel grava count 0. Contar como 1 evita somar zero. */
const QTD = 'GREATEST(`count`, 1)';

async function resumoServidor(db) {
  const [[online]] = await db.query('SELECT COUNT(*) AS n FROM `players_online`');
  const [[contas]] = await db.query('SELECT COUNT(*) AS n FROM `accounts`');
  const [[chars]] = await db.query('SELECT COUNT(*) AS n FROM `players` WHERE `deletion` = 0');
  const [[bazaar]] = await db.query(
    'SELECT COUNT(*) AS n FROM `players` WHERE `charbazaar` = 1'
  ).catch(() => [[{ n: 0 }]]);
  return {
    online: Number(online.n),
    contas: Number(contas.n),
    personagens: Number(chars.n),
    noBazaar: Number(bazaar ? bazaar.n : 0),
  };
}

// Saldo da conta, junto de cada personagem. Coins moram no banco (o jogo le
// e grava direto la); o fim do VIP de quem esta online pode estar alguns
// minutos atrasado, ate o proximo save.
const CONTA = 'a.`coins`, a.`coins_transferable`, a.`lastday`';

async function jogadoresOnline(db) {
  const [linhas] = await db.query(
    `SELECT p.\`id\`, p.\`name\`, p.\`level\`, p.\`vocation\`, p.\`account_id\`,
            p.\`lastlogin\`, p.\`lastip\`, ${CONTA}
       FROM \`players_online\` o
       JOIN \`players\` p ON p.\`id\` = o.\`player_id\`
       JOIN \`accounts\` a ON a.\`id\` = p.\`account_id\`
      ORDER BY p.\`level\` DESC`
  );
  return linhas;
}

async function buscarJogadores(db, termo, limite = 50) {
  const like = '%' + String(termo || '').slice(0, 40) + '%';
  const [linhas] = await db.query(
    `SELECT p.\`id\`, p.\`name\`, p.\`level\`, p.\`account_id\`, p.\`lastlogin\`,
            p.\`balance\`, p.\`deletion\`, ${CONTA},
            (SELECT COUNT(*) FROM \`players_online\` o WHERE o.\`player_id\` = p.\`id\`) AS \`online\`
       FROM \`players\` p
       JOIN \`accounts\` a ON a.\`id\` = p.\`account_id\`
      WHERE p.\`name\` LIKE ?
      ORDER BY p.\`level\` DESC
      LIMIT ?`,
    [like, limite]
  );
  return linhas;
}

// ------------------------------------------------------------------ itens

/** Estoque de um jogador, agrupado por item e separado por origem. */
async function itensDoJogador(db, playerId) {
  const [linhas] = await db.query(
    `SELECT \`itemtype\`, \`origem\`, SUM(${QTD}) AS \`total\`, COUNT(*) AS \`pilhas\`
       FROM (${UNIAO_ITENS}) t
      WHERE \`player_id\` = ?
      GROUP BY \`itemtype\`, \`origem\`
      ORDER BY \`total\` DESC`,
    [playerId]
  );

  // Junta as origens numa linha por item, que e como se lê melhor.
  const porItem = new Map();
  for (const l of linhas) {
    const id = Number(l.itemtype);
    if (!porItem.has(id)) {
      porItem.set(id, { itemtype: id, total: 0, pilhas: 0, inventario: 0, depot: 0, inbox: 0 });
    }
    const e = porItem.get(id);
    e.total += Number(l.total);
    e.pilhas += Number(l.pilhas);
    e[l.origem] = Number(l.total);
  }
  return [...porItem.values()].sort((a, b) => b.total - a.total);
}

/**
 * Os itens com maior quantidade total no servidor, com quantos jogadores os
 * possuem e quanto esta na mao do maior detentor.
 *
 * `concentracao` e o que denuncia duplicacao: um item legitimo se espalha
 * entre varios jogadores. Quando um so responde por quase todo o estoque,
 * vale olhar de perto.
 */
async function rankingItens(db, limite = 80, minimo = 1) {
  const [linhas] = await db.query(
    `SELECT t.\`itemtype\`,
            SUM(${QTD}) AS \`total\`,
            COUNT(DISTINCT t.\`player_id\`) AS \`donos\`,
            MAX(t.\`por_jogador\`) AS \`maior\`
       FROM (
         SELECT \`player_id\`, \`itemtype\`, \`count\`,
                SUM(${QTD}) OVER (PARTITION BY \`itemtype\`, \`player_id\`) AS \`por_jogador\`
           FROM (${UNIAO_ITENS}) u
       ) t
      GROUP BY t.\`itemtype\`
     HAVING \`total\` >= ?
      ORDER BY \`total\` DESC
      LIMIT ?`,
    [minimo, limite]
  );

  return linhas.map((l) => {
    const total = Number(l.total);
    const maior = Number(l.maior);
    return {
      itemtype: Number(l.itemtype),
      total,
      donos: Number(l.donos),
      maior,
      // Fracao do estoque total que esta com um unico jogador.
      concentracao: total > 0 ? Math.round((maior / total) * 100) : 0,
    };
  });
}

/** Quem tem mais de um item especifico. A tela de "quem duplicou". */
async function donosDoItem(db, itemtype, limite = 50) {
  const [linhas] = await db.query(
    `SELECT t.\`player_id\`, p.\`name\`, p.\`level\`, p.\`account_id\`,
            SUM(${QTD}) AS \`total\`,
            SUM(CASE WHEN t.\`origem\` = 'inventario' THEN ${QTD} ELSE 0 END) AS \`inventario\`,
            SUM(CASE WHEN t.\`origem\` = 'depot'      THEN ${QTD} ELSE 0 END) AS \`depot\`,
            SUM(CASE WHEN t.\`origem\` = 'inbox'      THEN ${QTD} ELSE 0 END) AS \`inbox\`
       FROM (${UNIAO_ITENS}) t
       LEFT JOIN \`players\` p ON p.\`id\` = t.\`player_id\`
      WHERE t.\`itemtype\` = ?
      GROUP BY t.\`player_id\`, p.\`name\`, p.\`level\`, p.\`account_id\`
      ORDER BY \`total\` DESC
      LIMIT ?`,
    [itemtype, limite]
  );
  return linhas;
}

/**
 * Contas com varios personagens guardando o mesmo item raro.
 *
 * E o padrao classico de duplicacao: o item e passado entre chars da mesma
 * conta para espalhar o estoque e nao chamar atencao no ranking individual.
 */
async function itensEspalhadosPorConta(db, limite = 40) {
  const [linhas] = await db.query(
    `SELECT p.\`account_id\`, t.\`itemtype\`,
            COUNT(DISTINCT t.\`player_id\`) AS \`chars\`,
            SUM(${QTD}) AS \`total\`
       FROM (${UNIAO_ITENS}) t
       JOIN \`players\` p ON p.\`id\` = t.\`player_id\`
      GROUP BY p.\`account_id\`, t.\`itemtype\`
     HAVING \`chars\` >= 2
      ORDER BY \`total\` DESC
      LIMIT ?`,
    [limite]
  );
  return linhas;
}

/** Quantos jogadores online agora - para avisar que os numeros estao velhos. */
async function frescorDosItens(db) {
  const [[r]] = await db.query('SELECT COUNT(*) AS n FROM `players_online`');
  return { online: Number(r.n) };
}

// --------------------------------------------------------------- doacoes

async function resumoDonates(db) {
  const [porStatus] = await db.query(
    `SELECT \`status\`, COUNT(*) AS \`n\`, COALESCE(SUM(\`amount_cents\`), 0) AS \`centavos\`,
            COALESCE(SUM(\`coins\`), 0) AS \`coins\`
       FROM \`donate_transactions\`
      GROUP BY \`status\``
  );

  const agora = Math.floor(Date.now() / 1000);
  const [[mes]] = await db.query(
    `SELECT COUNT(*) AS \`n\`, COALESCE(SUM(\`amount_cents\`), 0) AS \`centavos\`
       FROM \`donate_transactions\`
      WHERE \`status\` IN ('PAID','CREDITED') AND \`paid_at\` >= ?`,
    [agora - 30 * 86400]
  );
  const [[hoje]] = await db.query(
    `SELECT COUNT(*) AS \`n\`, COALESCE(SUM(\`amount_cents\`), 0) AS \`centavos\`
       FROM \`donate_transactions\`
      WHERE \`status\` IN ('PAID','CREDITED') AND \`paid_at\` >= ?`,
    [agora - 86400]
  );
  const [[total]] = await db.query(
    `SELECT COUNT(*) AS \`n\`, COALESCE(SUM(\`amount_cents\`), 0) AS \`centavos\`,
            COALESCE(SUM(\`coins\`), 0) AS \`coins\`
       FROM \`donate_transactions\`
      WHERE \`status\` IN ('PAID','CREDITED')`
  );

  // Pago mas nao creditado e o que precisa de olho humano: o dinheiro entrou
  // e o jogador nao recebeu.
  const [[pendentes]] = await db.query(
    `SELECT COUNT(*) AS \`n\`, COALESCE(SUM(\`amount_cents\`), 0) AS \`centavos\`
       FROM \`donate_transactions\`
      WHERE \`status\` = 'PAID' AND \`delivered\` = 0`
  );

  return {
    porStatus: porStatus.map((l) => ({
      status: l.status, n: Number(l.n),
      centavos: Number(l.centavos), coins: Number(l.coins),
    })),
    hoje: { n: Number(hoje.n), centavos: Number(hoje.centavos) },
    mes: { n: Number(mes.n), centavos: Number(mes.centavos) },
    total: { n: Number(total.n), centavos: Number(total.centavos), coins: Number(total.coins) },
    aCreditar: { n: Number(pendentes.n), centavos: Number(pendentes.centavos) },
  };
}

async function listarDonates(db, { status = '', limite = 100 } = {}) {
  const cond = status ? 'WHERE `status` = ?' : '';
  const args = status ? [status, limite] : [limite];
  const [linhas] = await db.query(
    `SELECT \`id\`, \`account_id\`, \`player_name\`, \`amount_cents\`, \`coins\`, \`status\`,
            \`delivered\`, \`fail_reason\`, \`created_at\`, \`paid_at\`, \`credited_at\`,
            \`invoice_url\`
       FROM \`donate_transactions\`
       ${cond}
      ORDER BY \`id\` DESC
      LIMIT ?`,
    args
  );
  return linhas;
}

/** Quem mais doou, para saber quem apoia o servidor. */
async function topDoadores(db, limite = 20) {
  const [linhas] = await db.query(
    `SELECT \`account_id\`, MAX(\`player_name\`) AS \`ultimo_char\`,
            COUNT(*) AS \`doacoes\`, SUM(\`amount_cents\`) AS \`centavos\`,
            SUM(\`coins\`) AS \`coins\`, MAX(\`paid_at\`) AS \`ultima\`
       FROM \`donate_transactions\`
      WHERE \`status\` IN ('PAID','CREDITED')
      GROUP BY \`account_id\`
      ORDER BY \`centavos\` DESC
      LIMIT ?`,
    [limite]
  );
  return linhas;
}

module.exports = {
  resumoServidor, jogadoresOnline, buscarJogadores,
  itensDoJogador, rankingItens, donosDoItem, itensEspalhadosPorConta, frescorDosItens,
  resumoDonates, listarDonates, topDoadores,
  FONTES_ITENS,
};
