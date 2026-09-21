local internalNpcName = "Chuckles"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 99
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

npcConfig.shop = {
	{ itemName = "brown mushroom", clientId = 3725, buy = 20 },
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 150 },
	{ itemName = "blank rune", clientId = 3147, buy = 30 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 500 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 320 },
	{ itemName = "cure poison rune", clientId = 3153, buy = 240 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 120 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 100 },
	{ itemName = "empty potion flask", clientId = 283, sell = 5 },
	{ itemName = "empty potion flask", clientId = 284, sell = 5 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "energy field rune", clientId = 3164, buy = 150 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 500 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 320 },
	{ itemName = "explosion rune", clientId = 3200, buy = 120 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "fire field rune", clientId = 3188, buy = 120 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 240 },
	{ itemName = "fireball rune", clientId = 3189, buy = 120 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 150 },
	{ itemName = "great health potion", clientId = 239, buy = 335 },
	{ itemName = "great mana potion", clientId = 238, buy = 210 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 335 },
	{ itemName = "health potion", clientId = 266, buy = 53 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 45 },
	{ itemName = "holy missile rune", clientId = 3182, buy = 60 },
	{ itemName = "icicle rune", clientId = 3158, buy = 120 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 200 },
	{ itemName = "life ring", clientId = 3052, buy = 2000 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 18 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 400 },
	{ itemName = "mana potion", clientId = 268, buy = 60 },
	{ itemName = "poison field rune", clientId = 3172, buy = 80 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 150 },
	{ itemName = "spellbook", clientId = 3059, buy = 500 },
	{ itemName = "stalagmite rune", clientId = 3179, buy = 50 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 120 },
	{ itemName = "strong health potion", clientId = 236, buy = 160 },
	{ itemName = "strong mana potion", clientId = 237, buy = 125 },
	{ itemName = "sudden death rune", clientId = 3155, buy = 450 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 750 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 150 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 375 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 525 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 538650 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 650 },
	{ itemName = "vial", clientId = 2874, sell = 5 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 400 },
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

npcType:register(npcConfig)
