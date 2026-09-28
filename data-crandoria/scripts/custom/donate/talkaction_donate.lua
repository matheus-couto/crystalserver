--[[
	!donate <valor em reais>

	Grava apenas uma intencao de doacao na tabela `donate_transactions`. Quem
	fala com o Asaas e o worker em tools/asaas-donate: ele ve a linha PENDING,
	cria o link de pagamento e escreve a URL de volta. O globalevent
	donate_processor.lua entrega essa URL ao jogador num scroll e, depois que
	o webhook confirmar, credita as Tibia Coins.

	O jogo nunca faz HTTP: isso manteria a thread principal travada esperando
	a resposta do Asaas.
]]

local config = {
	enabled = configManager.getBoolean(configKeys.DONATE_ENABLED),
	coinsPerReal = configManager.getNumber(configKeys.DONATE_COINS_PER_REAL),
	minValue = configManager.getNumber(configKeys.DONATE_MIN_VALUE),
	maxValue = configManager.getNumber(configKeys.DONATE_MAX_VALUE),
	expireMinutes = configManager.getNumber(configKeys.DONATE_EXPIRE_MINUTES),
	worldId = configManager.getNumber(configKeys.WORLD_ID),
}

local donate = TalkAction("!donate")

local function say(player, message)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
end

function donate.onSay(player, words, param)
	if not config.enabled then
		say(player, "As doacoes estao desativadas no momento.")
		return true
	end

	local value = tonumber(param)
	if not value or value ~= math.floor(value) or value <= 0 then
		say(player, string.format("Use: !donate <valor em reais inteiros>. Exemplo: !donate %d", config.minValue))
		return true
	end

	value = math.floor(value)

	if value < config.minValue then
		say(player, string.format("O valor minimo para doar e R$ %d,00.", config.minValue))
		return true
	end

	if value > config.maxValue then
		say(player, string.format("O valor maximo por doacao e R$ %d,00.", config.maxValue))
		return true
	end

	local accountId = player:getAccountId()
	if not accountId or accountId == 0 then
		say(player, "Nao foi possivel identificar sua conta. Avise um administrador.")
		return true
	end

	-- Uma intencao aberta por vez, por conta. Sem isto, um jogador impaciente
	-- gera varios links e paga o errado, ou paga dois por engano.
	local openId = db.storeQuery(string.format(
		"SELECT `id` FROM `donate_transactions` WHERE `account_id` = %d AND `status` IN ('PENDING', 'AWAITING_PAYMENT') LIMIT 1",
		accountId
	))
	if openId then
		Result.free(openId)
		say(player, "Voce ja tem uma doacao aguardando pagamento. Conclua ou espere ela expirar antes de abrir outra.")
		return true
	end

	local coins = value * config.coinsPerReal
	local now = os.time()

	local inserted = db.query(string.format(
		"INSERT INTO `donate_transactions` (`account_id`, `player_id`, `player_name`, `amount_cents`, `coins`, `status`, `world_id`, `created_at`, `updated_at`) "
			.. "VALUES (%d, %d, %s, %d, %d, 'PENDING', %d, %d, %d)",
		accountId,
		player:getGuid(),
		db.escapeString(player:getName()),
		value * 100,
		coins,
		config.worldId,
		now,
		now
	))

	if not inserted then
		say(player, "Nao foi possivel registrar sua doacao agora. Tente novamente em instantes.")
		logger.error("[!donate] Falha ao inserir intencao para a conta {}", accountId)
		return true
	end

	say(player, string.format("Doacao de R$ %d,00 registrada (%d Tibia Coins).", value, coins))
	say(player, string.format("Em instantes voce recebera um scroll com o link de pagamento. Ele vale por %d minutos.", config.expireMinutes))
	logger.info("[!donate] {} registrou doacao de R$ {},00 ({} coins)", player:getName(), value, coins)
	return true
end

donate:separator(" ")
donate:groupType("normal")
donate:register()
