local internalNpcName = "Calabreso"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 873,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 52,
	lookFeet = 114,
	lookAddons = 3
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

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)


npcConfig.shop = {
	{ name = "stone skin amulet", clientId = 3081, buy = 5000 },
	{ name = "leviathan's amulet", clientId = 9303, buy = 35000 },
	{ name = "shockwave amulet", clientId = 9304, buy = 35000 },
	{ name = "bonfire amulet", clientId = 9301, buy = 35000 },
	{ name = "sacred tree amulet", clientId = 9302, buy = 35000 },
	{ name = "bronze amulet", clientId = 3056, buy = 25000 },
	{ name = "collar of blue plasma", clientId = 23542, sell = 6000 },
	{ name = "collar of green plasma", clientId = 23543, sell = 6000 },
	{ name = "collar of red plasma", clientId = 23544, sell = 6000 },
	{ name = "ring of blue plasma", clientId = 23529, sell = 8000 },
	{ name = "ring of green plasma", clientId = 23531, sell = 8000 },
	{ name = "ring of red plasma", clientId = 23533, sell = 8000 },

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