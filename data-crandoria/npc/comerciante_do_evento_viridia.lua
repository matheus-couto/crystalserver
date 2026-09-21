local internalNpcName = "Comerciante do Evento Viridia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = "Comerciante do Evento"
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 114,
	lookFeet = 78,
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

npcConfig.voices = {
	interval = 30000,
	chance = 100,
	{text = 'Utilize seus Tokens de Evento aqui!'},
}


local shopToday = math.random(1, 6)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 6526

npcConfig.shop = {
	{ name = "exercise sword", clientId = 28552, buy = 2 },
	{ name = "exercise club", clientId = 28554, buy = 2 },
	{ name = "exercise axe", clientId = 28553, buy = 2 },
	{ name = "exercise bow", clientId = 28555, buy = 2 },
	{ name = "exercise rod", clientId = 28556, buy = 2 },
	{ name = "exercise wand", clientId = 28557, buy = 2 },
	{ name = "durable exercise sword", clientId = 35279, buy = 4 },
	{ name = "durable exercise club", clientId = 35281, buy = 4 },
	{ name = "durable exercise axe", clientId = 35280, buy = 4 },
	{ name = "durable exercise bow", clientId = 35282, buy = 4 },
	{ name = "durable exercise rod", clientId = 35283, buy = 4 },
	{ name = "durable exercise wand", clientId = 35284, buy = 4 },
	{ name = "amulet of loss", clientId = 3057, buy = 1 },
	{ name = "black candle", clientId = 9099, buy = 3 },
	{ name = "music box", clientId = 16244, buy = 10},
	{ name = "perdao real", clientId = 39136, buy = 2},
	{ name = "livro sagrado", clientId = 25745, buy = 3},
	{ name = "espelho do mercador", clientId = 36875, buy = 5},
	{ name = "crandoria boots", clientId = 3550, buy = 50},
	{ name = "magical teleport stone", clientId = 39036, buy = 30},
	{ name = "pocao do reinicio", clientId = 39145, buy = 25},
	{ name = "addon doll", clientId = 8778, buy = 40},
	{ name = "gold token", clientId = 22721, buy = 2},
	{ name = "silver token", clientId = 22516, buy = 2},
	{ name = "passe afk", clientId = 9220, buy = 35},
	{ name = "worker shirt", clientId = 32099, buy = 30},
	{ name = "worker helmet", clientId = 11700, buy = 30},
	{ name = "worker legs", clientId = 32097, buy = 30},
	{ name = "worker shoes", clientId = 9017, buy = 30},
	{ name = "chaotic jar", clientId = 39707, buy = 15},
	{ name = "exercise stash", clientId = 26186, buy = 10},
	{ name = "mascara de carnaval", clientId = 31372, sell = 1 },
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

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Troque seus Tokens do Evento comigo.")

npcType:addDialogOptions("bye")
npcType:register(npcConfig)

