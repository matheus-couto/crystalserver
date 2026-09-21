local internalNpcName = "Billy Bob"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 2,
	lookBody = 52,
	lookLegs = 77,
	lookFeet = 2,
	lookAddons = 3
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
npcConfig.currency = 21184

npcConfig.shop = {
	{ name = "chaotic gamble", clientId = 12811, buy = 250 },
	{ name = "exercise stash", clientId = 26186, buy = 10 },
	{ name = "obsidian knife", clientId = 5908, buy = 3, },
	{ name = "black candle", clientId = 9099, buy = 5},
	{ name = "sneaky stabber of eliteness", clientId = 9594, buy = 25},
	{ name = "squeezing gear of girlpower", clientId = 9596, buy = 35},
	{ name = "whacking driller of fate", clientId = 9598, buy = 25},
	{ name = "music box", clientId = 16244, buy = 15},
	{ name = "casino ticket", clientId = 637, buy = 2},
	{ name = "sun catcher", clientId = 25977, buy = 100},
	{ name = "moon mirror", clientId = 25975, buy = 100},
	{ name = "starlight vial", clientId = 25976, buy = 100},
	{ name = "perdao real", clientId = 39136, buy = 10},
	{ name = "passe afk", clientId = 9220, buy = 30},
	{ name = "medalha de honra", clientId = 9219, buy = 25},
	{ name = "small stamina refill", clientId = 20138, buy = 10},
	{ name = "full stamina refill", clientId = 20139, buy = 20},
	{ name = "addon doll", clientId = 8778, buy = 50},
	{ name = "experience boost potion", clientId = 11372, buy = 25},
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

npcHandler:setMessage(MESSAGE_GREET, "Ofereco varios itens em {troca} de Caldos de Feijao.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)
