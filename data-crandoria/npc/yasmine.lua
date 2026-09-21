local internalNpcName = "Yasmine"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 150,
	lookHead = 0,
	lookBody = 68,
	lookLegs = 0,
	lookFeet = 114,
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
---------------------------------

    if MsgContains(message, "teleport") then
        if player:getStorageValue(Storage.Quest.Crandoria.AsuraCitadel.Access) == 1 then
            npcHandler:say("Obrigada pelos tokens. Voce pode acessar o portal agora.", npc, creature)
            return true
        else
            npcHandler:say("O valor para entrar na Asura Citadel e de 5 Gold Tokens. Gostaria de pagar e entrar na cidade?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            if not player:removeItem(22721, 5) then
                npcHandler:say("E onde estao os 5 Gold Tokens? Volte quando tiver todos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
                return true
            else
                npcHandler:say("Obrigada! Apenas uma vez, deixarei que voce acesse o portal.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsuraCitadel.Access, 1)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(11552) >= 1 then
                npcHandler:say("Bom, trato feito. Agora guardarei este cristal, voce podera acessar a Citadela sempre que quiser e nos nunca mais falaremos sobre isso! Obrigada.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
                player:setStorageValue(Storage.Quest.Crandoria.AsuraCitadel.Access, 2)
                player:removeItem(11552, 1)
                npcHandler:setTopic(playerId, 0)
                return true 
            else
                npcHandler:say("Entao traga-me o cristal, por favor!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "no") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Tudo bem. Me diga se mudar de ideia.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "magic crystal") or MsgContains(message, "cristal magico") then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 11 and player:getItemCount(11552) >= 1 then
            npcHandler:say("O QUE? Como assim? Onde voce conseguiu isso? Escuta... Eu sou a protetora da Citadela, se alguem souber que deixei sairem de la com o Cristal Magico eu... \z
            Ok. Escute aqui. Se voce me der este cristal eu te concederei passagem gratuita pelo portal por toda a sua vida! O que me diz? Trato feito?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        else
            npcHandler:say("Cristal? Nao faco ideia do que voce esta dizendo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello, dear |PLAYERNAME|. Do you want to use our {teleport} to the Asura Citadel?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
