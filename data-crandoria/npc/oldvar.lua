local internalNpcName = "Oldvar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 633,
	lookHead = 93,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 39,
	lookAddons = 2
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
npcConfig.currency = 22720

npcConfig.shop = {
	{ name = "exercise stash", clientId = 26186, buy = 25 },
	{ name = "black candle", clientId = 9099, buy = 5},
	{ name = "casino ticket", clientId = 637, buy = 10 },
	{ name = "vip coins", clientId = 23682, buy = 35 },
	{ name = "perdao real", clientId = 39136, buy = 5 },
	{ name = "experience boost potion", clientId = 11372, buy = 35 },
	{ name = "lasting exercise sword", clientId = 35285, buy = 100 },
	{ name = "lasting exercise club", clientId = 35287, buy = 100 },
	{ name = "lasting exercise axe", clientId = 35286, buy = 100 },
	{ name = "lasting exercise bow", clientId = 35288, buy = 100 },
	{ name = "lasting exercise rod", clientId = 35289, buy = 100 },
	{ name = "lasting exercise wand", clientId = 35290, buy = 100 },
	{ name = "lasting exercise shield", clientId = 44067, buy = 100 },
	{ name = "small stamina refill", clientId = 20138, buy = 15 },
	{ name = "full stamina refill", clientId = 20139, buy = 25 },
	{ name = "gold token", clientId = 22721, buy = 3 },
	{ name = "star ring", clientId = 12669, buy = 30 },
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
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)