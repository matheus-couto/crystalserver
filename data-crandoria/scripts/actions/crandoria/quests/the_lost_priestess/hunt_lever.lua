local config = {
	leverItemPosition = {x = 5039, y = 4424, z = 15}, -- posição do item da alavanca no mapa (confirmar: 4024 ou 4424?)
	pullerRequiredPosition = Position(5039, 4425, 15), -- jogador que puxa a alavanca precisa estar aqui
	playerPositions = {
		Position(5039, 4425, 15),
		Position(5039, 4426, 15),
		Position(5039, 4427, 15),
		Position(5039, 4428, 15),
		Position(5039, 4429, 15),
	},
	destination = Position(5039, 4517, 15),
	requiredLevel = 500,
	cooldown = 12 * 60 * 60,
	storage = Storage.Quest.Crandoria.TheLostPriestess.HuntTimer,
}

local huntLever = Action()

function huntLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getPosition() ~= config.pullerRequiredPosition then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa estar na posicao correta para puxar esta alavanca.")
		return true
	end

	-- Coleta os jogadores nas 5 posições
	local players = {}
	for _, pos in ipairs(config.playerPositions) do
		local creature = Tile(pos):getTopCreature()
		if not creature or not creature:isPlayer() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "E necessario exatamente 5 jogadores, um em cada posicao designada, para puxar esta alavanca.")
			return true
		end
		table.insert(players, creature)
	end

	-- Nível mínimo
	for _, p in ipairs(players) do
		if p:getLevel() < config.requiredLevel then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
				"Todos os jogadores precisam ser nivel %d ou superior. %s esta abaixo do nivel necessario.",
				config.requiredLevel, p:getName()
			))
			return true
		end
	end

	-- Cooldown de 12h
	for _, p in ipairs(players) do
		local cooldownUntil = p:getStorageValue(config.storage)
		if cooldownUntil and cooldownUntil > os.time() then
			local remaining = cooldownUntil - os.time()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
				"%s ainda esta em cooldown. Aguarde mais %d hora(s) e %d minuto(s).",
				p:getName(), math.floor(remaining / 3600), math.floor((remaining % 3600) / 60)
			))
			return true
		end
	end

	-- Uma vocação de cada (druid, knight, paladin, sorcerer, monk)
	local hasKnight, hasPaladin, hasDruid, hasSorcerer, hasMonk = false, false, false, false, false
	for _, p in ipairs(players) do
		local baseId = p:getVocation():getBaseId()
		if baseId == VOCATION.BASE_ID.KNIGHT then
			hasKnight = true
		elseif baseId == VOCATION.BASE_ID.PALADIN then
			hasPaladin = true
		elseif baseId == VOCATION.BASE_ID.DRUID then
			hasDruid = true
		elseif baseId == VOCATION.BASE_ID.SORCERER then
			hasSorcerer = true
		elseif baseId == VOCATION.BASE_ID.MONK then
			hasMonk = true
		end
	end

	if not (hasKnight and hasPaladin and hasDruid and hasSorcerer and hasMonk) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "E necessario um jogador de cada vocacao: Druid, Knight, Paladin, Sorcerer e Monk.")
		return true
	end

	-- Todas as condições atendidas: teleporta e aplica cooldown
	for _, p in ipairs(players) do
		p:teleportTo(config.destination)
		config.destination:sendMagicEffect(CONST_ME_TELEPORT)
		p:setStorageValue(config.storage, os.time() + config.cooldown)
	end

	return true
end

huntLever:position(config.leverItemPosition)
huntLever:register()