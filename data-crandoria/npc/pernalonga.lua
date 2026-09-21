local internalNpcName = "Bugs Bunny"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 262,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 3250

npcConfig.shop = {
	{ name = "exercise sword", clientId = 28552, buy = 25 },
	{ name = "exercise club", clientId = 28554, buy = 25 },
	{ name = "exercise axe", clientId = 28553, buy = 25 },
	{ name = "exercise bow", clientId = 28555, buy = 25 },
	{ name = "exercise rod", clientId = 28556, buy = 25 },
	{ name = "exercise wand", clientId = 28557, buy = 25 },
	{ name = "durable exercise sword", clientId = 35279, buy = 75 },
	{ name = "durable exercise club", clientId = 35281, buy = 75 },
	{ name = "durable exercise axe", clientId = 35280, buy = 75 },
	{ name = "durable exercise bow", clientId = 35282, buy = 75 },
	{ name = "durable exercise rod", clientId = 35283, buy = 75 },
	{ name = "durable exercise wand", clientId = 35284, buy = 75 },
	{ name = "lasting exercise sword", clientId = 35285, buy = 375 },
	{ name = "lasting exercise club", clientId = 35287, buy = 375 },
	{ name = "lasting exercise axe", clientId = 35286, buy = 375 },
	{ name = "lasting exercise bow", clientId = 35288, buy = 375 },
	{ name = "lasting exercise rod", clientId = 35289, buy = 375 },
	{ name = "lasting exercise wand", clientId = 35290, buy = 375 },
	{ name = "amulet of loss", clientId = 3057, buy = 5 },
	{ name = "ovo de pascoa", clientId = 37167, buy = 100 },
	{ name = "obsidian knife", clientId = 5908, buy = 50, },
	{ name = "black candle", clientId = 9099, buy = 25},
	{ name = "music box", clientId = 16244, buy = 100},
	{ name = "perdao real", clientId = 39136, buy = 25},
	{ name = "leech", clientId = 17858, buy = 500},
	{ name = "small stamina refill", clientId = 20138, buy = 100},
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcHandler:setMessage(MESSAGE_GREET, "O que é que há, velhinho? Se tiver cenouras por ai, diga {trade} e escolha algum dos meus tesouros em troca delas.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando tiver algumas cenouras sobrando.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais! Volte quando tiver algumas cenouras sobrando.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)