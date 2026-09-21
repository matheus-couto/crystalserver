local internalNpcName = "Tyrtus, o Imortal"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 194,
	lookHead = 84,
	lookBody = 114,
	lookLegs = 84,
	lookFeet = 19,
	lookAddons = 3,
	lookMount = 0,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso)

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        npcHandler:say("???", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "volk galugha") then
        if storage < 9 then
            npcHandler:say("Volk... Voce nao merece passar por este desafio ainda!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 9 then
            npcHandler:say("Volk! Voce parece ter passado por muitas batalhas para chegar aqui... Acredito que voce possa estar pronto para a Arena do Caos! Vejamos se tera forca para isso. \z
            Passando pela porta voce podera acessar o desafio. Serao 12 salas com 1 boss em cada sala. Va so ou, se preferir, leve um companheiro para te ajudar. Voce pode repetir o desafio a cada 7 dias. \z
            Voce podera passar para a proxima sala sempre que derrotar o chefe da sala onde voce esta. Derrote todos os boss e receba suas recompensas na sala a esquerda. Boa sorte, mortal. Voce tera uma hora para completar o desafio.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 10)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 10 then
            npcHandler:say("Volk. Va logo! Teste seu poder na Arena!", npc, creature)
                npcHandler:setTopic(playerId, 0)
        elseif storage == 11 then
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Reward, 1)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 12)
            npcHandler:say("Volk! Muito bem, mortal. Voce finalizou com exito o desafio da Arena do Caos! Agora voce podera obter suas recompensas na sala ao lado.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 12 then
            npcHandler:say("Volk. Va logo! Teste seu poder na Arena!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz em meu centro de treinamento?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
