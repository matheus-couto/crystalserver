# Doações via Asaas

Integração do comando `!donate` com o Asaas. O servidor de jogo nunca faz HTTP —
ele só lê e escreve na tabela `donate_transactions`. Este worker cuida de toda a
conversa com o Asaas.

## Como funciona

```
jogador            jogo (Lua)              banco                 worker (Node)          Asaas
   |                   |                     |                        |                   |
   | !donate 100       |                     |                        |                   |
   |------------------>| INSERT PENDING ---->|                        |                   |
   |                   |                     |<-- le PENDING ---------|                   |
   |                   |                     |                        |-- cria link ----->|
   |                   |                     |<-- grava invoice_url --|<------------------|
   |                   |<-- le AWAITING -----|                        |                   |
   |<-- scroll c/ link-|                     |                        |                   |
   |                                                                                      |
   |------------------------- paga no navegador ----------------------------------------->|
   |                   |                     |                        |<-- webhook -------|
   |                   |                     |<-- marca PAID ---------|                   |
   |                   |<-- le PAID ---------|                        |                   |
   |<-- +Tibia Coins --|  (status CREDITED)  |                        |                   |
```

## Instalação

**1. Rode a migration.** Suba o servidor uma vez; a migration 68 cria a tabela.

**2. Configure o worker.**

```bash
cd tools/asaas-donate
cp .env.example .env
# preencha ASAAS_API_KEY, ASAAS_WEBHOOK_TOKEN e os dados do banco
npm install
npm start
```

**3. Cadastre o webhook no Asaas.** Painel → Integrações → Webhooks:

| Campo | Valor |
|---|---|
| URL | `https://SEU_DOMINIO/asaas/webhook` |
| Token de autenticação | o mesmo `ASAAS_WEBHOOK_TOKEN` do `.env` |
| Eventos | `PAYMENT_RECEIVED`, `PAYMENT_CONFIRMED`, `PAYMENT_REFUNDED` |

O Asaas precisa **alcançar** essa URL pela internet. Em desenvolvimento use um
túnel (`cloudflared tunnel --url http://localhost:3000` ou ngrok) e cadastre a
URL pública que ele gerar.

**4. Ligue no jogo.** Em `config.lua`:

```lua
donateEnabled = true
donateCoinsPerReal = 10   -- R$ 1,00 = 10 Tibia Coins
donateMinValue = 5        -- mínimo do Asaas por cobrança
donateMaxValue = 5000
```

## Configuração

Tudo que muda o comportamento no jogo está no `config.lua`:

| Chave | Padrão | O que faz |
|---|---|---|
| `donateEnabled` | `false` | Liga o `!donate` e o processador |
| `donateCoinsPerReal` | `10` | Cotação: coins por R$ 1,00 |
| `donateMinValue` | `5` | Mínimo em reais (o Asaas não aceita abaixo de R$ 5) |
| `donateMaxValue` | `5000` | Máximo em reais |
| `donateCheckInterval` | `5000` | Intervalo do processador, em ms |
| `donateExpireMinutes` | `60` | Validade de uma intenção não paga |
| `donateScrollItemId` | `639` | Item usado para entregar o link |

O resto (chave de API, token do webhook, banco, porta) fica no `.env`.

## A tabela

`donate_transactions` guarda uma linha por doação, do pedido ao crédito.

| `status` | Significado |
|---|---|
| `PENDING` | `!donate` gravou; o worker ainda não criou o link |
| `AWAITING_PAYMENT` | link criado, `invoice_url` preenchida |
| `PAID` | webhook confirmou o pagamento |
| `CREDITED` | coins entregues — estado final de sucesso |
| `EXPIRED` | passou de `donateExpireMinutes` sem pagar |
| `FAILED` | o worker não conseguiu criar a cobrança, ou o valor pago foi menor |
| `REFUNDED` | estorno recebido |

O valor fica em `amount_cents`, como inteiro. Dinheiro em float perde centavos
no arredondamento.

Consultas úteis:

```sql
-- doações do dia
SELECT id, player_name, amount_cents/100 AS reais, coins, status
FROM donate_transactions
WHERE created_at > UNIX_TIMESTAMP(CURDATE())
ORDER BY id DESC;

-- pagas mas ainda não creditadas (jogador offline)
SELECT id, player_name, coins FROM donate_transactions WHERE status = 'PAID';

-- total recebido
SELECT SUM(amount_cents)/100 AS total_reais FROM donate_transactions
WHERE status = 'CREDITED';
```

## Decisões que valem saber

**Link de pagamento, não cobrança direta.** Criar uma cobrança no Asaas exige um
`customer` com CPF, que o jogo não tem. O link de pagamento não exige cliente —
quem preenche os dados é o próprio pagador no checkout.

**Crédito só com o jogador online.** O `addTransferableCoins` escreve na conta em
memória. Se a linha for `PAID` e o jogador estiver offline, ela fica esperando e
é processada no próximo ciclo em que ele entrar. Escrever direto no banco seria
sobrescrito no save seguinte.

**Webhook repetido não credita duas vezes.** O `UPDATE` exige o status de origem
(`WHERE status IN ('PENDING','AWAITING_PAYMENT')`), então a segunda entrega do
mesmo evento atualiza zero linhas.

**Pagamento a menor não credita.** O worker compara o valor pago com o
`amount_cents` esperado e marca `FAILED` se vier menos.

**Estorno não remove coins.** Um `PAYMENT_REFUNDED` marca a linha como
`REFUNDED` e registra no log, mas as coins já entregues continuam com o jogador.
Retirar automaticamente abriria espaço para saldo negativo. Trate manualmente.

## Operação

O worker precisa estar rodando para as doações andarem. Se ele cair, as
intenções ficam em `PENDING` e voltam a ser processadas quando ele subir — nada
se perde. Para mantê-lo no ar, use um gerenciador de processos (pm2, systemd ou
um serviço do Windows).
