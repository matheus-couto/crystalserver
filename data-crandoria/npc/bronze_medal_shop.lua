local internalNpcName = "Bronze Medal Shop"
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
	lookBody = 55,
	lookLegs = 55,
	lookFeet = 55,
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
npcConfig.currency = 9217

npcConfig.shop = {
	-- { name = "small stamina refill", clientId = 20138, buy = 3 },
	-- { name = "full stamina refill", clientId = 20139, buy = 5 },
	{ name = "teleportation rune", clientId = 3235, buy = 1 },
	{ name = "vip coins", clientId = 23682, buy = 2 },
	{ name = "perdao real", clientId = 39136, buy = 2 },
	{ name = "black candle", clientId = 9099, buy = 1 },
	{ name = "living crystal", clientId = 24964, buy = 10 },
	{ name = "exercise stash", clientId = 26186, buy = 5 },
	{ name = "silver medal", clientId = 9216, buy = 2 },
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Posso vender alguns itens especiais em troca de bronze medals, basta solicitar por uma {troca}.")
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

npcType:register(npcConfig)