local internalNpcName = "Nazhuk"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1539,
	lookHead = 114,
	lookBody = 6,
	lookLegs = 53,
	lookFeet = 42,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) <= 17 then
            npcHandler:say("Por enquanto nao tenho nada para voce. Ja checou se os demais residentes do Palacio percisam de algo? Va falar com eles!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 18 then
            npcHandler:say("Otimo! Nehzzara passou a mensagem para que viesse ate mim, certo? Escute, sou o encarregado das colecoes de pergaminhos e livros magicos do Palacio. \z
            Precisamos sempre estudar mais e mais sobre qualquer magia do Novo Continente. Mas meu problema sempre foi a falta de alguns livros. Se voce pegar um deles para mim, \z
            talvez eu te ajude a chegar ate a Rainha... Aceita essa missao?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 19 then
            npcHandler:say("Voce trouxe o Crude Umbral Spellbook?", npc, creature)
            npcHandler:setTopic(playerId, 2)
            -- if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) == 13998 then
            --     npcHandler:say("Voce trouxe o Depth Scutom?", npc, creature)
            --     npcHandler:setTopic(playerId, 2)
            -- elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) == 8076 then
            --     npcHandler:say("Voce trouxe o Spellscroll of Prophecies?", npc, creature)
            --     npcHandler:setTopic(playerId, 3)
            -- elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) == 22755 then
            --     npcHandler:say("Voce trouxe o Spellscroll of Prophecies?", npc, creature)
            --     npcHandler:setTopic(playerId, 4)
            -- elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) == 8075 then
            --     npcHandler:say("Voce trouxe o Spellbook of Lost Souls?", npc, creature)
            --     npcHandler:setTopic(playerId, 5)
            -- end
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 20 then
            npcHandler:say("Nao tenho mais missoes para voce.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 19)
            npcHandler:say("Entao preste atencao: Eu preciso de 1 Crude Umbral Spellbook. Isso sera tudo. Simples e facil! Traga para mim esse raro Spellbook e voce estara mais perto de encontrar a Rainha.", npc, creature)
            npcHandler:setTopic(playerId, 0)
            -- local book = math.random(1, 4)
            -- if book == 1 then
            --     npcHandler:say("Entao preste atencao: Eu preciso de 1 Depth Scutum. Isso sera tudo. Simples e facil! Traga para mim esse raro Spellbook e voce estara mais perto de encontrar a Rainha.", npc, creature)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 13998)
            --     npcHandler:setTopic(playerId, 0)
            -- elseif book == 2 then
            --     npcHandler:say("Entao preste atencao: Eu preciso de 1 Spellscroll of Prophecies. Isso sera tudo. Simples e facil! Traga para mim esse raro Spellbook e voce estara mais perto de encontrar a Rainha.", npc, creature)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 8076)
            --     npcHandler:setTopic(playerId, 0)
            -- elseif book == 3 then
            --     npcHandler:say("Entao preste atencao: Eu preciso de 1 Book of Lies. Isso sera tudo. Simples e facil! Traga para mim esse raro Spellbook e voce estara mais perto de encontrar a Rainha.", npc, creature)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 22755)
            --     npcHandler:setTopic(playerId, 0)
            -- elseif book == 4 then
            --     npcHandler:say("Entao preste atencao: Eu preciso de 1 Spellbook of Lost Souls. Isso sera tudo. Simples e facil! Traga para mim esse raro Spellbook e voce estara mais perto de encontrar a Rainha.", npc, creature)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 8075)
            --     npcHandler:setTopic(playerId, 0)
            -- end
        elseif npcHandler:getTopic(playerId) == 2 then
            -- if player:getItemCount(13998) >= 1 then
            --     player:removeItem(13998, 1)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
            --     player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 20)
            --     npcHandler:say("Ha!! Isso realmente fez meu dia melhor! Minha colecao agora esta quase completa. Muito obrigado por isso. Voce tera um ultimo desafio no Palacio antes de chegar ate a Rainha. \z
            --     Fale com Salkariss. Ele cuida da nossa cozinha. E cuidado com o que fala! Ele pode ser um pouco rabugento. Aqui, uma recompensa pela ajuda. Faca bom uso.", npc, creature)
            --     player:addItem(3043, 50)
            --     player:addExperience(player:getLevel() * 18000)
            --     player:addItem(20138, 1)
            --     npcHandler:setTopic(playerId, 0)
            -- else
            --     npcHandler:say("Voce nao esta com o Depth Scutum.", npc, creature)
            --     npcHandler:setTopic(playerId, 0)
            -- end
            if player:getItemCount(20088) >= 1 then
                player:removeItem(20088, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 20)
                npcHandler:say("Ha!! Isso realmente fez meu dia melhor! Minha colecao agora esta quase completa. Muito obrigado por isso. Voce tera um ultimo desafio no Palacio antes de chegar ate a Rainha. \z
                Fale com Salkariss. Ele cuida da nossa cozinha. E cuidado com o que fala! Ele pode ser um pouco rabugento. Aqui, uma recompensa pela ajuda. Faca bom uso.", npc, creature)
                player:addItem(3043, 50)
                player:addExperience(player:getLevel() * 18000)
                player:addItem(20138, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com o Crude Umbral Spellbook.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(8076) >= 1 then
                player:removeItem(8076, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 20)
                npcHandler:say("Ha!! Isso realmente fez meu dia melhor! Minha colecao agora esta quase completa. Muito obrigado por isso. Voce tera um ultimo desafio no Palacio antes de chegar ate a Rainha. \z
                Fale com Salkariss. Ele cuida da nossa cozinha. E cuidado com o que fala! Ele pode ser um pouco rabugento. Aqui, uma recompensa pela ajuda. Faca bom uso.", npc, creature)
                player:addItem(3043, 50)
                player:addExperience(player:getLevel() * 18000)
                player:addItem(20138, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com o Spellscroll of Prophecies.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(22755) >= 1 then
                player:removeItem(22755, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 20)
                npcHandler:say("Ha!! Isso realmente fez meu dia melhor! Minha colecao agora esta quase completa. Muito obrigado por isso. Voce tera um ultimo desafio no Palacio antes de chegar ate a Rainha. \z
                Fale com Salkariss. Ele cuida da nossa cozinha. E cuidado com o que fala! Ele pode ser um pouco rabugento. Aqui, uma recompensa pela ajuda. Faca bom uso.", npc, creature)
                player:addItem(3043, 50)
                player:addExperience(player:getLevel() * 18000)
                player:addItem(20138, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com o Book of Lies.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(8075) >= 1 then
                player:removeItem(8075, 1)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 0)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 20)
                npcHandler:say("Ha!! Isso realmente fez meu dia melhor! Minha colecao agora esta quase completa. Muito obrigado por isso. Voce tera um ultimo desafio no Palacio antes de chegar ate a Rainha. \z
                Fale com Salkariss. Ele cuida da nossa cozinha. E cuidado com o que fala! Ele pode ser um pouco rabugento. Aqui, uma recompensa pela ajuda. Faca bom uso.", npc, creature)
                player:addItem(3043, 50)
                player:addExperience(player:getLevel() * 18000)
                player:addItem(20138, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao esta com o Spellbook of Lost Souls.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "Oh! Ola, humano.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
