local internalNpcName = "Online Token Shop"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 68,
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
npcConfig.currency = 22723

npcConfig.shop = {
	{ name = "exercise sword", clientId = 28552, buy = 45 },
	{ name = "exercise club", clientId = 28554, buy = 45 },
	{ name = "exercise axe", clientId = 28553, buy = 45 },
	{ name = "exercise bow", clientId = 28555, buy = 45 },
	{ name = "exercise rod", clientId = 28556, buy = 45 },
	{ name = "exercise wand", clientId = 28557, buy = 45 },
	{ name = "durable exercise sword", clientId = 35279, buy = 130 },
	{ name = "durable exercise club", clientId = 35281, buy = 130 },
	{ name = "durable exercise axe", clientId = 35280, buy = 130 },
	{ name = "durable exercise bow", clientId = 35282, buy = 130 },
	{ name = "durable exercise rod", clientId = 35283, buy = 130 },
	{ name = "durable exercise wand", clientId = 35284, buy = 130 },
	-- { name = "lasting exercise sword", clientId = 35285, buy = 450 },
	-- { name = "lasting exercise club", clientId = 35287, buy = 450 },
	-- { name = "lasting exercise axe", clientId = 35286, buy = 450 },
	-- { name = "lasting exercise bow", clientId = 35288, buy = 450 },
	-- { name = "lasting exercise rod", clientId = 35289, buy = 450 },
	-- { name = "lasting exercise wand", clientId = 35290, buy = 450 },
	{ name = "amulet of loss", clientId = 3057, buy = 5 }, -- CRANDORIAEDIT
	{ name = "obsidian knife", clientId = 5908, buy = 100 },
	{ name = "stone skin amulet", clientId = 3081, buy = 1 },
	{ name = "black candle", clientId = 9099, buy = 75 },
	{ name = "music box", clientId = 16244, buy = 500},
	{ name = "casino ticket", clientId = 637, buy = 20},
	{ name = "vip coins", clientId = 23682, buy = 200},
	{ name = "mechanical fishing rod", clientId = 9306, buy = 200},
	{ name = "sun catcher", clientId = 25977, buy = 1000},
	{ name = "moon mirror", clientId = 25975, buy = 1000},
	-- { name = "perdao real", clientId = 39136, buy = 20},
	{ name = "livro sagrado", clientId = 25745, buy = 50},
	{ name = "espelho do mercador", clientId = 36875, buy = 100},
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