local internalNpcName = "Tarok"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 537,
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

    if MsgContains(message, "passage") or MsgContains(message, "sail") then
        npcHandler:say("Posso te levar para as {profundezas dos condenados} ou de volta para as {masmorras de viridia}. Para onde deseja ir?", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "profundezas") or MsgContains(message, "condenados") then
        npcHandler:say("Deseja ir para as profundezas pelo valor de 50.000 moedas de ouro?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "masmorras") or MsgContains(message, "viridia") then
        npcHandler:say("Deseja retornar para as masmorras de Viridia por 2.000 moedas de ouro?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        local money = player:getBankBalance() + player:getMoney()
        if npcHandler:getTopic(playerId) == 1 then
            if money >= 50000 then
                player:removeMoneyBank(50000)
                player:teleportTo(Position(4433, 5405, 11))
                npcHandler:say("Boa sorte. Voce vai precisar...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if money >= 2000 then
                player:removeMoneyBank(2000)
                player:teleportTo(Position(4510, 5439, 8))
                npcHandler:say("Ate mais!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ah.. Tudo bem.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ah... outro humano. Esta buscando por uma {passagem}, estou certo?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("passage", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
