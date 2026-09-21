local internalNpcName = "Zannar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 152,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 84,
	lookFeet = 26,
    	lookAddons = 3,
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


    if MsgContains(message, "ilha das sombras") or MsgContains(message, "shadow island") then
        if os.date("%A") == "Monday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas em troca vou precisar de 2 minutaur leathers. Voce tem os itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif os.date("%A") == "Tuesday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas em troca vou precisar de 1 iron ore. Voce tem o item com voce?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif os.date("%A") == "Wednesday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas em troca quero 1 yellow piece of cloth. Voce tem o item com voce?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif os.date("%A") == "Thursday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas em troca quero 3 tarantula eggs. Voce tem os itens com voce?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif os.date("%A") == "Friday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas apenas se voce me entregar 1 shard. Voce tem o item com voce?", npc, creature)
            npcHandler:setTopic(playerId, 6)
        elseif os.date("%A") == "Saturday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas vai te custar 1 holy orchid. Voce tem o item com voce?", npc, creature)
            npcHandler:setTopic(playerId, 7)
        elseif os.date("%A") == "Sunday" then
            npcHandler:say("Posso te levar para a ilha das sombras, mas vai te custar 1 bonelord eye. Voce tem o item com voce?", npc, creature)
            npcHandler:setTopic(playerId, 8)
        end
    elseif MsgContains(message, "viridia") then
        npcHandler:say("Quer voltar para Viridia? Vai te custar 200 gold coins.", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getMoney() >= 200 then
                player:teleportTo(Position(4545, 5309, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui ouro suficiente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(5878) >= 2 then
                player:removeItem(5878, 2)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5880) >= 1 then
                player:removeItem(5880, 1)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(5914) >= 1 then
                player:removeItem(5914, 1)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(10281) >= 3 then
                player:removeItem(10281, 3)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui os itens. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(7290) >= 1 then
                player:removeItem(7290, 1)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if player:getItemCount(5922) >= 1 then
                player:removeItem(5922, 1)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 8 then
            if player:getItemCount(5898) >= 1 then
                player:removeItem(5898, 1)
                npcHandler:say("Boa viagem!", npc, creature)
                player:teleportTo(Position(4556, 5297, 7))
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item. Nao seria a coisa mais prudente tentar enganar um assassino...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Entao o que voce esta fazendo aqui? Esta tentando expor nosso esconderijo? Saia ja daqui!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, forasteiro. Posso te levar para a {ilha das sombras} ou de volta para {viridia}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Fique nas sombras!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Fique nas sombras.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("yes", "no", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
