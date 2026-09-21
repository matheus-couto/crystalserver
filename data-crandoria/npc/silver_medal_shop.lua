local internalNpcName = "Silver Medal Shop"
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
	lookHead = 77,
	lookBody = 29,
	lookLegs = 29,
	lookFeet = 115,
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
npcConfig.currency = 9216

npcConfig.shop = {
	{ name = "nightmare doll", clientId = 10227, buy = 20 },
	{ name = "stuffed dragon", clientId = 6566, buy = 12 },
	{ name = "baby seal doll", clientId = 7183, buy = 12 },
	{ name = "draken doll", clientId = 12043, buy = 16 },
	{ name = "dread doll", clientId = 12904, buy = 20 },
	{ name = "fan doll of queen eloise", clientId = 12570, buy = 16 },
	{ name = "assassin doll", clientId = 21962, buy = 20 },
	{ name = "ferumbras' teddy", clientId = 22775, buy = 30 },
	{ name = "demon doll", clientId = 32918, buy = 16 },
	{ name = "gold medal", clientId = 9215, buy = 2 },
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Posso vender alguns itens especiais em troca de silver medals, basta solicitar por uma {troca}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus!")

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