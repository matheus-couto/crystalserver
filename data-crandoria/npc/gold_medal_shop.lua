local internalNpcName = "Gold Medal Shop"
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
	lookBody = 78,
	lookLegs = 78,
	lookFeet = 78,
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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 9215

npcConfig.shop = {
	{ name = "addon doll", clientId = 8778, buy = 10 },
	{ name = "pacote do worker", clientId = 39705, buy = 10 },
	{ name = "pacote do progresso i", clientId = 37461, buy = 5 },
	{ name = "pacote do progresso ii", clientId = 37467, buy = 8 },
	{ name = "pacote do progresso iii", clientId = 37462, buy = 10 },
	{ name = "ancient watch", clientId = 24969, buy = 20 },
	{ name = "regressor", clientId = 34079, buy = 8 },
	-- { name = "bag you desire", clientId = 34109, buy = 13 },
	-- { name = "primal bag", clientId = 39546, buy = 16 },
	-- { name = "eldritch you desire", clientId = 29351, buy = 22 },
	-- { name = "bag you covet", clientId = 43895, buy = 25 },
	{ name = "chaotic gamble", clientId = 12811, buy = 20 },
	{ name = "special casino ticket", clientId = 22706, buy = 3 },
	{ name = "passe de batalha", clientId = 9218, buy = 20 },

}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Posso vender alguns itens especiais em troca de gold medals, basta solicitar por uma {troca}.")
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