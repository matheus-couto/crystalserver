--[[
	Ponte entre a tabela `donate_transactions` e o jogo.

	Tres tarefas a cada ciclo:
	  1. AWAITING_PAYMENT e ainda nao entregue -> da o scroll com o link
	  2. PAID                                  -> credita as Tibia Coins
	  3. PENDING/AWAITING_PAYMENT vencidas     -> marca EXPIRED

	Quem preenche `invoice_url` e quem marca PAID e o worker em
	tools/asaas-donate. Este script so le e escreve no banco.
]]

local config = {
	enabled = configManager.getBoolean(configKeys.DONATE_ENABLED),
	interval = configManager.getNumber(configKeys.DONATE_CHECK_INTERVAL),
	scrollItemId = configManager.getNumber(configKeys.DONATE_SCROLL_ITEM_ID),
	expireMinutes = configManager.getNumber(configKeys.DONATE_EXPIRE_MINUTES),
	worldId = configManager.getNumber(configKeys.WORLD_ID),
}

if not config.enabled then
	return
end

local function eachRow(query, callback)
	local resultId = db.storeQuery(query)
	if not resultId then
		return
	end

	repeat
		callback(resultId)
	until not Result.next(resultId)

	Result.free(resultId)
end

-- 1) Entrega do scroll -------------------------------------------------------

local function deliverPendingLinks()
	local rows = {}

	eachRow(
		string.format(
			"SELECT `id`, `player_id`, `amount_cents`, `coins`, `invoice_url` FROM `donate_transactions` "
				.. "WHERE `status` = 'AWAITING_PAYMENT' AND `delivered` = 0 AND `invoice_url` <> '' AND `world_id` = %d LIMIT 20",
			config.worldId
		),
		function(resultId)
			rows[#rows + 1] = {
				id = Result.getNumber(resultId, "id"),
				playerId = Result.getNumber(resultId, "player_id"),
				amountCents = Result.getNumber(resultId, "amount_cents"),
				coins = Result.getNumber(resultId, "coins"),
				url = Result.getString(resultId, "invoice_url"),
			}
		end
	)

	for _, row in ipairs(rows) do
		local player = Player(row.playerId)
		-- Offline continua pendente: a linha fica com delivered = 0 e o scroll
		-- sai no proximo ciclo em que ele estiver online.
		if player then
			local scroll = player:addItem(config.scrollItemId, 1)
			if scroll then
				scroll:setAttribute(
					ITEM_ATTRIBUTE_TEXT,
					string.format(
						"Doacao #%d\n\nValor: R$ %s\nTibia Coins: %d\n\nAbra o link para pagar:\n%s\n\nO credito e automatico apos a confirmacao.",
						row.id,
						(string.format("%.2f", row.amountCents / 100):gsub("%.", ",")),
						row.coins,
						row.url
					)
				)
				scroll:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Link de pagamento da doacao #%d.", row.id))

				db.query(string.format("UPDATE `donate_transactions` SET `delivered` = 1, `updated_at` = %d WHERE `id` = %d", os.time(), row.id))

				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu um scroll com o link de pagamento da sua doacao.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua doacao esta pronta, mas voce nao tem espaco para receber o scroll. Abra espaco na mochila.")
			end
		end
	end
end

-- 2) Credito das coins -------------------------------------------------------

local function creditPaidDonations()
	local rows = {}

	eachRow(
		string.format(
			"SELECT `id`, `account_id`, `player_id`, `player_name`, `coins`, `amount_cents` FROM `donate_transactions` "
				.. "WHERE `status` = 'PAID' AND `world_id` = %d LIMIT 20",
			config.worldId
		),
		function(resultId)
			rows[#rows + 1] = {
				id = Result.getNumber(resultId, "id"),
				accountId = Result.getNumber(resultId, "account_id"),
				playerId = Result.getNumber(resultId, "player_id"),
				playerName = Result.getString(resultId, "player_name"),
				coins = Result.getNumber(resultId, "coins"),
				amountCents = Result.getNumber(resultId, "amount_cents"),
			}
		end
	)

	for _, row in ipairs(rows) do
		local player = Player(row.playerId)

		if player then
			-- Online: a API de coins escreve na conta em memoria e persiste.
			-- Mexer no banco direto aqui seria sobrescrito no proximo save.
			player:addTransferableCoins(row.coins)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sua doacao foi confirmada! Voce recebeu %d Tibia Coins.", row.coins))
			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)

			db.query(string.format(
				"UPDATE `donate_transactions` SET `status` = 'CREDITED', `credited_at` = %d, `updated_at` = %d WHERE `id` = %d",
				os.time(), os.time(), row.id
			))

			logger.info("[donate] Creditadas {} coins para {} (doacao #{})", row.coins, row.playerName, row.id)
		end
		-- Offline: nao credita agora. A linha continua PAID e e processada
		-- assim que o personagem entrar, evitando escrever na conta enquanto
		-- ela nao esta carregada.
	end
end

-- 3) Expiracao ---------------------------------------------------------------

local function expireOldIntents()
	local deadline = os.time() - (config.expireMinutes * 60)

	db.query(string.format(
		"UPDATE `donate_transactions` SET `status` = 'EXPIRED', `updated_at` = %d "
			.. "WHERE `status` IN ('PENDING', 'AWAITING_PAYMENT') AND `created_at` < %d",
		os.time(), deadline
	))
end

local donateProcessor = GlobalEvent("DonateProcessor")

function donateProcessor.onThink(interval)
	deliverPendingLinks()
	creditPaidDonations()
	expireOldIntents()
	return true
end

donateProcessor:interval(config.interval)
donateProcessor:register()
