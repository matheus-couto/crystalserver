'use strict';

/**
 * Worker de doacoes - Asaas
 *
 * Duas metades que nunca se falam direto, so pelo banco:
 *
 *   poller   le `donate_transactions` com status PENDING, cria um link de
 *            pagamento no Asaas e grava a URL de volta na linha.
 *
 *   webhook  recebe os eventos do Asaas e marca a linha como PAID.
 *
 * O servidor de jogo nao faz HTTP: ele so le e escreve nessa mesma tabela.
 */

require('dotenv').config();

const express = require('express');
const mysql = require('mysql2/promise');

// --- configuracao -----------------------------------------------------------

function required(name) {
  const value = process.env[name];
  if (!value) {
    console.error(`[config] Falta a variavel ${name} no .env`);
    process.exit(1);
  }
  return value;
}

const config = {
  asaas: {
    baseUrl: (process.env.ASAAS_BASE_URL || 'https://api-sandbox.asaas.com/v3').replace(/\/+$/, ''),
    apiKey: required('ASAAS_API_KEY'),
    // Token que o Asaas devolve no header asaas-access-token. Configure o
    // mesmo valor no painel, em Integracoes > Webhooks.
    webhookToken: required('ASAAS_WEBHOOK_TOKEN'),
    // UNDEFINED deixa o pagador escolher entre Pix, boleto e cartao.
    billingType: process.env.ASAAS_BILLING_TYPE || 'UNDEFINED',
    dueDateLimitDays: Number(process.env.ASAAS_DUE_DATE_LIMIT_DAYS || 1),
    maxInstallmentCount: Number(process.env.ASAAS_MAX_INSTALLMENTS || 1),
  },
  db: {
    host: process.env.DB_HOST || '127.0.0.1',
    port: Number(process.env.DB_PORT || 3306),
    user: required('DB_USER'),
    password: process.env.DB_PASSWORD || '',
    database: required('DB_NAME'),
    connectionLimit: 4,
  },
  port: Number(process.env.PORT || 3000),
  pollIntervalMs: Number(process.env.POLL_INTERVAL_MS || 5000),
  batchSize: Number(process.env.BATCH_SIZE || 10),
  serverName: process.env.SERVER_NAME || 'Crandoria',
};

const pool = mysql.createPool(config.db);

const log = (...args) => console.log(new Date().toISOString(), ...args);
const logError = (...args) => console.error(new Date().toISOString(), ...args);

// --- Asaas ------------------------------------------------------------------

async function asaas(path, options = {}) {
  const response = await fetch(`${config.asaas.baseUrl}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      access_token: config.asaas.apiKey,
      ...(options.headers || {}),
    },
  });

  const text = await response.text();
  let body = null;
  if (text) {
    try {
      body = JSON.parse(text);
    } catch {
      body = { raw: text };
    }
  }

  if (!response.ok) {
    const detail = body && body.errors ? body.errors.map((e) => e.description).join('; ') : response.statusText;
    const error = new Error(`Asaas ${response.status}: ${detail}`);
    error.status = response.status;
    throw error;
  }

  return body;
}

/**
 * Link de pagamento em vez de cobranca direta: criar uma cobranca exige um
 * `customer` com CPF, que o jogo nao tem. Com o link, quem preenche os dados
 * e o proprio pagador no checkout.
 */
async function createPaymentLink(row) {
  const value = Number((row.amount_cents / 100).toFixed(2));

  const link = await asaas('/paymentLinks', {
    method: 'POST',
    body: JSON.stringify({
      name: `${config.serverName} - ${row.coins} Tibia Coins`,
      description: `Doacao #${row.id} de ${row.player_name}. Credito automatico no jogo apos a confirmacao.`,
      billingType: config.asaas.billingType,
      chargeType: 'DETACHED',
      value,
      // Liga o pagamento de volta a nossa linha. Volta no webhook.
      externalReference: String(row.id),
      dueDateLimitDays: config.asaas.dueDateLimitDays,
      maxInstallmentCount: config.asaas.maxInstallmentCount,
      notificationEnabled: false,
    }),
  });

  if (!link || !link.url) {
    throw new Error('Asaas nao devolveu a URL do link de pagamento');
  }

  return link;
}

// --- poller -----------------------------------------------------------------

async function processPendingIntents() {
  const [rows] = await pool.query(
    "SELECT `id`, `player_name`, `amount_cents`, `coins` FROM `donate_transactions` WHERE `status` = 'PENDING' ORDER BY `id` ASC LIMIT ?",
    [config.batchSize]
  );

  for (const row of rows) {
    try {
      const link = await createPaymentLink(row);

      // A condicao no WHERE evita que duas instancias do worker gravem a
      // mesma linha: quem chegar depois atualiza 0 linhas.
      const [result] = await pool.execute(
        "UPDATE `donate_transactions` SET `status` = 'AWAITING_PAYMENT', `asaas_payment_link_id` = ?, `invoice_url` = ?, `updated_at` = ? WHERE `id` = ? AND `status` = 'PENDING'",
        [link.id, link.url, Math.floor(Date.now() / 1000), row.id]
      );

      if (result.affectedRows === 0) {
        logError(`[poller] Doacao #${row.id} ja tinha sido processada por outro worker`);
      } else {
        log(`[poller] Doacao #${row.id}: link criado (${link.url})`);
      }
    } catch (err) {
      logError(`[poller] Doacao #${row.id} falhou: ${err.message}`);
      await pool.execute(
        "UPDATE `donate_transactions` SET `status` = 'FAILED', `fail_reason` = ?, `updated_at` = ? WHERE `id` = ? AND `status` = 'PENDING'",
        [String(err.message).slice(0, 255), Math.floor(Date.now() / 1000), row.id]
      );
    }
  }
}

function startPoller() {
  let running = false;

  setInterval(async () => {
    // Evita sobrepor ciclos se o Asaas demorar a responder.
    if (running) {
      return;
    }
    running = true;
    try {
      await processPendingIntents();
    } catch (err) {
      logError(`[poller] Erro no ciclo: ${err.message}`);
    } finally {
      running = false;
    }
  }, config.pollIntervalMs);

  log(`[poller] Ativo, checando a cada ${config.pollIntervalMs}ms`);
}

// --- webhook ----------------------------------------------------------------

const PAID_EVENTS = new Set(['PAYMENT_RECEIVED', 'PAYMENT_CONFIRMED']);
const REFUND_EVENTS = new Set(['PAYMENT_REFUNDED', 'PAYMENT_CHARGEBACK_REQUESTED']);

async function findTransaction(payment) {
  // externalReference e o caminho normal. O paymentLink e a rede de seguranca
  // para o caso de o Asaas nao propagar a referencia do link para a cobranca.
  if (payment.externalReference) {
    const [rows] = await pool.execute('SELECT * FROM `donate_transactions` WHERE `id` = ? LIMIT 1', [
      payment.externalReference,
    ]);
    if (rows.length) {
      return rows[0];
    }
  }

  if (payment.paymentLink) {
    const [rows] = await pool.execute(
      'SELECT * FROM `donate_transactions` WHERE `asaas_payment_link_id` = ? ORDER BY `id` DESC LIMIT 1',
      [payment.paymentLink]
    );
    if (rows.length) {
      return rows[0];
    }
  }

  return null;
}

async function handleWebhook(req, res) {
  // Responde 200 sempre que a autenticacao passar. O Asaas reenvia em caso de
  // erro e desativa o webhook depois de muitas falhas seguidas, entao um
  // problema nosso nao pode virar 500.
  const body = req.body || {};
  const event = body.event;
  const payment = body.payment;

  if (!event || !payment) {
    log('[webhook] Payload sem event/payment, ignorado');
    return res.status(200).json({ ok: true });
  }

  try {
    const tx = await findTransaction(payment);

    if (!tx) {
      log(`[webhook] ${event} sem transacao correspondente (ref=${payment.externalReference}, link=${payment.paymentLink})`);
      return res.status(200).json({ ok: true });
    }

    const now = Math.floor(Date.now() / 1000);

    if (PAID_EVENTS.has(event)) {
      const paidCents = Math.round(Number(payment.value) * 100);

      // Pago a menos nao credita. Sem esta checagem, um valor alterado no
      // checkout daria as coins cheias.
      if (paidCents < tx.amount_cents) {
        logError(`[webhook] Doacao #${tx.id}: pago ${paidCents} < esperado ${tx.amount_cents}`);
        await pool.execute(
          "UPDATE `donate_transactions` SET `status` = 'FAILED', `fail_reason` = ?, `asaas_payment_id` = ?, `updated_at` = ? WHERE `id` = ? AND `status` IN ('PENDING','AWAITING_PAYMENT')",
          [`Valor pago menor que o esperado (${paidCents} de ${tx.amount_cents})`, payment.id, now, tx.id]
        );
        return res.status(200).json({ ok: true });
      }

      // O WHERE com os status de origem torna a entrega repetida inofensiva:
      // o Asaas pode mandar o mesmo evento mais de uma vez.
      const [result] = await pool.execute(
        "UPDATE `donate_transactions` SET `status` = 'PAID', `asaas_payment_id` = ?, `paid_at` = ?, `updated_at` = ? WHERE `id` = ? AND `status` IN ('PENDING','AWAITING_PAYMENT')",
        [payment.id, now, now, tx.id]
      );

      if (result.affectedRows > 0) {
        log(`[webhook] Doacao #${tx.id} confirmada (${event}), ${tx.coins} coins a creditar`);
      } else {
        log(`[webhook] Doacao #${tx.id}: ${event} repetido, ja estava em ${tx.status}`);
      }

      return res.status(200).json({ ok: true });
    }

    if (REFUND_EVENTS.has(event)) {
      await pool.execute(
        "UPDATE `donate_transactions` SET `status` = 'REFUNDED', `fail_reason` = ?, `updated_at` = ? WHERE `id` = ?",
        [`Estorno recebido: ${event}`, now, tx.id]
      );
      logError(`[webhook] Doacao #${tx.id} estornada (${event}) - as coins ja creditadas NAO sao removidas automaticamente`);
      return res.status(200).json({ ok: true });
    }

    log(`[webhook] Evento ${event} ignorado para a doacao #${tx.id}`);
    return res.status(200).json({ ok: true });
  } catch (err) {
    logError(`[webhook] Erro processando ${event}: ${err.message}`);
    // 500 faz o Asaas reenviar, que e o que queremos quando a falha foi nossa.
    return res.status(500).json({ ok: false });
  }
}

function startWebhook() {
  const app = express();
  app.use(express.json({ limit: '256kb' }));

  app.get('/health', (req, res) => res.json({ ok: true }));

  app.post('/asaas/webhook', (req, res) => {
    const token = req.get('asaas-access-token');
    if (token !== config.asaas.webhookToken) {
      logError('[webhook] Requisicao rejeitada: asaas-access-token invalido');
      return res.status(401).json({ ok: false });
    }
    return handleWebhook(req, res);
  });

  app.listen(config.port, () => {
    log(`[webhook] Ouvindo em http://0.0.0.0:${config.port}/asaas/webhook`);
  });
}

// --- start ------------------------------------------------------------------

(async () => {
  try {
    const conn = await pool.getConnection();
    await conn.query('SELECT 1 FROM `donate_transactions` LIMIT 1');
    conn.release();
    log(`[db] Conectado em ${config.db.host}:${config.db.port}/${config.db.database}`);
  } catch (err) {
    logError(`[db] Nao foi possivel usar a tabela donate_transactions: ${err.message}`);
    logError('[db] Suba o servidor uma vez para rodar a migration 68.');
    process.exit(1);
  }

  log(`[asaas] Base: ${config.asaas.baseUrl}`);
  startWebhook();
  startPoller();
})();
