local internalNpcName = "Kaleb"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 146,
	lookHead = 0,
	lookBody = 36,
	lookLegs = 108,
	lookFeet = 115,
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

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        npcHandler:say("Eu nao estou precisando de nada. Mas talvez voce possa falar com Kamila, minha irma. Ela sempre esta com algum problema... Ha ha ha ha...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif (MsgContains(message, "cristal magico") or MsgContains(message, "magic crystal")) then
        npcHandler:say("Cristal magico? E o que exatamente seria isso? Voce possui um com voce?", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(11552) >= 1 then
                npcHandler:say({"Uau! Este deve ser o cristal mais brilhante que eu ja vi! Eu nunca fui muito ligado a riquezas, entao nao entendo muito bem sobre cristais e pedras preciosas, mas com certeza esse cristal parece especial...",
                "Ei! O que voce acha de uma troca? Se voce me der esse cristal, eu te darei um dos meus Dromedarios! Voce podera monta-lo e ir com ele para onde voce quiser. Voce aceita minha oferta?"}, npc, creature)
                npcHandler:setTopic(playerId, 2)
            else
                npcHandler:say("E onde esta esse cristal? Esta tentando me passar para tras? Nao me faca perder tempo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(11552) >= 1 then
                if player:hasMount(20) then
                    npcHandler:say("Ah... Parece que voce ja possui seu proprio dromedario. Nao tem problema algum! Negocios nem sempre dao certo.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    if player:removeItem(11552, 1) then
                        npcHandler:say("Temos um acordo! Aqui esta seu dromedario. Viaje nele o quanto quiser e nao se preocupe com agua. Ele ja bebeu o suficiente para a vida toda! Ha ha ha ha.", npc, creature)
                        player:addMount(20, true)
                        npcHandler:setTopic(playerId, 0)
                    else
                        npcHandler:say("E onde esta esse cristal? Esta tentando me passar para tras? Nao me faca perder tempo.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    end
                end
            else
                npcHandler:say("E onde esta esse cristal? Esta tentando me passar para tras? Nao me faca perder tempo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.") 
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
