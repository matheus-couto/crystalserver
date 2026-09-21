local internalNpcName = "Caronte"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 665,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 74,
	lookAddons = 0
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

npcConfig.flags = {
	floorchange = false
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end
end
---------

keywordHandler:addKeyword({"passage"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Para onde deseja levar sua alma? {Umbra} or {Crandoria}?"
    },
    function(player)
        return player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 1 and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) < 1
    end
)

keywordHandler:addKeyword({"umbra"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Sua alma parece muito pura para meus servicos, crianca."
    },
    function(player)
        return player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 1 and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) < 1
    end
)
keywordHandler:addKeyword({"crandoria"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Sua alma parece muito pura para meus servicos, crianca."
    },
    function(player)
        return player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 1 and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) < 1
    end
)
local travelNode = keywordHandler:addKeyword({"crandoria"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Deseja ser levado para Crandoria por 10.000 gold coins?"
    }
)
travelNode:addChildKeyword({"yes"}, StdModule.travel,
    {
        npcHandler = npcHandler,
        premium = false,
        text = "Tenha uma boa viagem!",
        cost = 10000,
        destination = Position(5102, 5080, 7)
    }
)
travelNode:addChildKeyword({"sim"}, StdModule.travel,
    {
        npcHandler = npcHandler,
        premium = false,
        text = "Tenha uma boa viagem...",
        cost = 10000,
        destination = Position(5102, 5080, 7)
    }
)
travelNode:addChildKeyword({"no"}, StdModule.say,
    {
        npcHandler = npcHandler, reset = true,
        text = "Estarei aqui se mudar de ideia..."
    }
)

travelNode:addChildKeyword({"nao"}, StdModule.say,
    {
        npcHandler = npcHandler, reset = true,
        text = "Estarei aqui se mudar de ideia..."
    }
)

local travelumbra = keywordHandler:addKeyword({"umbra"}, StdModule.say,
    {
        npcHandler = npcHandler,
        text = "Deseja ir para Umbra por 10.000 gold coins?"
    }
)
travelumbra:addChildKeyword({"yes"}, StdModule.travel,
    {
        npcHandler = npcHandler,
        premium = false,
        text = "Tenha uma boa viagem...",
        cost = 10000,
        destination = Position(5959, 5365, 7)
    }
)
travelumbra:addChildKeyword({"no"}, StdModule.say,
    {
        npcHandler = npcHandler, reset = true,
        text = "Estarei aqui se mudar de ideia..."
    }
)
-------

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|! Posso levar sua alma para {Crandoria} ou para {Umbra}. Basta pedir por uma {passagem}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, pobre alma.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, pobre alma.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("passage", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)