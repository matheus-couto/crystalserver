local internalNpcName = "Dark Coco"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1747,
	lookHead = 116,
	lookBody = 58,
	lookLegs = 54,
	lookFeet = 93,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Candia.Progresso)
	local level = player:getLevel()

    if MsgContains(message, "negociar") then
		npcHandler:say("Para negociar, basta propor uma {troca}.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end


npcHandler:setMessage(MESSAGE_GREET, "Sauadcoes. Eu negocio artigos raros de Candia por Dark Chocolate Coins. Se tiver interesse, podemos fazer uma {troca}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

local function onTradeRequest(npc, creature)
	if Player(creature):getStorageValue(Storage.Quest.Crandoria.Candia.Progresso) < 4 then
		npcHandler:say("Voce precisa de uma permissao da Fada do Doce antes de negociar Chocolate Coins em Candia.", npc, creature)
		return false
	end

	return true
end

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.currency = 48249

npcConfig.shop = {
	{ name = "biscuit barrier", clientId = 45643, buy = 8000 },
	{ name = "ring of temptation", clientId = 45642, buy = 250 },
	{ name = "cocoa grimore", clientId = 45639, buy = 8000 },
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)