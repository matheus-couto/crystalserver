local internalNpcName = "Rhonda"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 929,
	lookHead = 115,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 114,
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "cerveja") then
        npcHandler:say("Estou comprando todas as cervejas que tiverem para tentar proteger meu marido dessa maluquice! Se quiser algum dos meus itens, basta oferecer uma {troca}.", npc, creature)
        npcHandler:setTopic(playerId, 0)
	end

end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 30003

npcConfig.shop = {
	-- { name = "small stamina refill", clientId = 20138, buy = 25 },
	{ name = "casino ticket", clientId = 637, buy = 3 },
	{ name = "exercise sword", clientId = 28552, buy = 3 },
	{ name = "exercise club", clientId = 28554, buy = 3 },
	{ name = "exercise axe", clientId = 28553, buy = 3 },
	{ name = "exercise bow", clientId = 28555, buy = 3 },
	{ name = "exercise rod", clientId = 28556, buy = 3 },
	{ name = "exercise wand", clientId = 28557, buy = 3 },
	{ name = "durable exercise sword", clientId = 35279, buy = 12 },
	{ name = "durable exercise club", clientId = 35281, buy = 12 },
	{ name = "durable exercise axe", clientId = 35280, buy = 12 },
	{ name = "durable exercise bow", clientId = 35282, buy = 12 },
	{ name = "durable exercise rod", clientId = 35283, buy = 12 },
	{ name = "durable exercise wand", clientId = 35284, buy = 12 },
	{ name = "lasting exercise sword", clientId = 35285, buy = 50 },
	{ name = "lasting exercise club", clientId = 35287, buy = 50 },
	{ name = "lasting exercise axe", clientId = 35286, buy = 50 },
	{ name = "lasting exercise bow", clientId = 35288, buy = 50 },
	{ name = "lasting exercise rod", clientId = 35289, buy = 50 },
	{ name = "lasting exercise wand", clientId = 35290, buy = 50 },
	{ name = "amulet of loss", clientId = 3057, buy = 1 },
	{ name = "black candle", clientId = 9099, buy = 3},
	{ name = "music box", clientId = 16244, buy = 15},
	{ name = "vip coins", clientId = 23682, buy = 10},
	{ name = "blessed acorn", clientId = 26074, buy = 1},
	{ name = "sun catcher", clientId = 25977, buy = 100},
	{ name = "moon mirror", clientId = 25975, buy = 100},
	{ name = "astralis coin", clientId = 22724, buy = 3},

}

npcHandler:setMessage(MESSAGE_GREET, "Ola. Se quiser me ajuda a evitar essa loucura basta trazer suas cervejas ate mim e faremos uma {troca}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)


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