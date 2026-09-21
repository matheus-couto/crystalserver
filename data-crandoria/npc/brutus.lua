local internalNpcName = "Brutus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 143,
	lookHead = 97,
	lookBody = 77,
	lookLegs = 78,
	lookFeet = 116,
	lookAddons = 3
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
        npcHandler:say("Posso te levar para a {ilha obscura} ou para {viridia}. Para onde deseja ir?", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "viridia") then
        npcHandler:say("Deseja retornar para a fortaleza dos orcs em Viridia? Vai te custar 5.000 gold coins.", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "ilha") then
        npcHandler:say("Em troca de um Life Crystal posso te levar para a lha Obscura. Voce possui um com voce?", npc, creature)
        npcHandler:setTopic(playerId, 2)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        local money = player:getBankBalance() + player:getMoney()
        if npcHandler:getTopic(playerId) == 1 then
            if money >= 10000 then
                player:removeMoneyBank(10000)
                player:teleportTo(Position(4466, 5475, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3061) >= 1 then
                player:removeItem(3061, 1)
                player:teleportTo(Position(4456, 5525, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item necessario.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem. Entao ate mais.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Deseja uma {passagem} no meu bote?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("passagem", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
