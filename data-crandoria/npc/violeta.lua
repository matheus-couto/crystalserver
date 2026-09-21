local internalNpcName = "Violeta"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2
npcConfig.walkRadius = 3

npcConfig.outfit = {
	lookType = 136,
	lookHead = 50,
	lookBody = 0,
	lookLegs = 33,
	lookFeet = 57,
	lookAddons = 1,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso)

    if MsgContains(message, "flor") or MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage < 1 then
            npcHandler:say("Ei! Voce poderia me ajudar trazendo algumas flores para mim? Preciso montar um arranjo. Te darei recompensas por cada uma delas. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 1 then
            npcHandler:say("Voce trouxe as moon flowers?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 2 then
            npcHandler:say("Vai me ajudar mais uma vez? Oba! Entao tudo bem. Agora preciso de 10 Heaven Blossoms. Voce pode obte-las derrotando elfos. \z
            Espero que nao seja um problema pra voce... Eu nao consigo lutar, entao conto com sua ajuda!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 3)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 3 then
            npcHandler:say("Voce trouxe 10 Heaven Blossoms?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 4 then
            npcHandler:say("Como voce conseguiu as Heaven Blossoms, acredito que tambem nao tera problemas conseguindo Holy Orchids, certo? \z
            Preciso de 10 Holy Orchids agora. Leve o tempo que precisar!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 5)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 5 then
            npcHandler:say("Voce trouxe 10 Holy Orchids?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 6 then
            npcHandler:say("As proximas flores serao um pouco mais dificeis, mas sao a chave do meu arranjo! Agora preciso de 10 Ice Flowers. \z
            Voce enfrentara alguns perigos para obte-las, mas sei que vai conseguir! Estarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 7)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 7 then
            npcHandler:say("Voce trouxe as 10 Ice Flowers para o arranjo?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Que legal! Chaos sempre esta muito vazia e fica dificil conseguir ajuda... Estou colhendo 'moon flowers'. Elas nascem por toda parte, no chao. \z
            Traga-me 10 moon flowers, por favor.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3655) >= 10 then
                player:removeItem(3655, 10)
                local container = player:addItem(2853, 1)
                if container then
                    container:addItem(3029, 3)
                    container:addItem(3032, 3)
                    container:addItem(3030, 3)
                    container:addItem(3033, 3)
                end
                player:addExperience(25000)
                player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 2)
                npcHandler:say("Oba! Muito obrigada! Aqui, sua recompensa. Me diga se quiser pegar mais {flores}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce parece nao ter as 10 moon flowers ainda...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5921) >= 10 then
                player:removeItem(5921, 10)
                player:addItem(3043, 1)
                player:addExperience(75000)
                player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 4)
                npcHandler:say("Estao todas aqui e todas muito bonitas! Obrigada mais uma vez. Me avise se quiser me ajudar com outras {flores}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce parece nao ter as 10 heaven blossoms ainda...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(5922) >= 10 then
                player:removeItem(5922, 10)
                player:addItem(30059, 1)
                player:addExperience(200000)
                player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 6)
                npcHandler:say("Que rapido! Agora sim o arranjo esta quase pronto. Se puder me ajudar com outras {flores}, sera muito util.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce parece nao ter as 10 holy orchids ainda...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(30058) >= 10 then
                player:removeItem(30058, 10)
                player:addItem(3043, 5)
                player:addExperience(1000000)
                player:setStorageValue(Storage.Quest.Crandoria.VioletaQuest.Progresso, 8)
                npcHandler:say("Perfeito! Agora nao falta mais nada. Estou muuuito feliz! Obrigada! Aqui esta algum dinheiro, espero que te ajude.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce parece nao ter as 10 holy orchids ainda...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "nao") or MsgContains(message, "no")) then
        npcHandler:say("Tudo bem...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. Estou colhendo {flores}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
