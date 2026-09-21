local internalNpcName = "Barter"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1612,
	lookHead = 74,
	lookBody = 45,
	lookLegs = 14,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Barter)

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "task") then
        if storage < 1 then
            if player:getLevel() >= 35 then
                npcHandler:say("Ola, jovem |PLAYERNAME|. Voce se mudou recentemente para Virida, certo? Acredito que o Almirante Haldor tenha mencionado seu nome algumas vezes... \z
                Eu sou o encarregado por 'criar' os insetos da ilha de Viridia, para que os guerreiros tenham sempre uma boa quantidade desses monstros para derrotar e buscar por espolios. \z
                Tudo estava indo muito bem, mas ha alguns dias fui atacado enquanto alimentava alguns deles e perdi minha armadura. Eu usava uma Knight Armor. Voce poderia me conseguir uma armadura nova?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            else
                npcHandler:say("Ola, jovem |PLAYERNAME|. Voce se mudou recentemente para Virida, certo? Acredito que o Almirante Haldor tenha mencionado seu nome algumas vezes... \z
                Estou precisando de ajuda em uma missao, mas acredito que voce ainda nao seja forte o suficiente para executa-la. Retorne apos o nivel 35 e conversaremos novamente.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 1 then
            npcHandler:say("Voce trouxe a Knight Armor que eu preciso?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 2 then
            if player:getLevel() >= 55 then
                npcHandler:say("Como te disse antes, preciso cuidar dos insetos para manter a populacao sob controle para que os guerreiros possam ter monstros para derrotar. \z
                Mas para obter acesso ao local os guerreiros devem completar uma missao e provar que sao fortes o suficiente e nao morrerao atoa no local. Nao sera nada complicado. \z
                Para esse desafio precisarei que voce me traga alguns alimentos para os insetos. Apenas o seu favorito. Voce acha que esta preparado(a) para essa busca?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                npcHandler:say("Voce ainda nao tem poder o suficiente para a essa missao. Pegue nivel 55 e retorne para o proximo desafio.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 3 then
            npcHandler:say("Voce trouxe todos os itens?.", npc, creature)
            npcHandler:setTopic(playerId, 4)
        end
    elseif MsgContains(message, "cookie") then
        if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao) == 5 then
            if player:getItemCount(3598) >= 5 then
                player:removeItem(3598, 5)
                npcHandler:say("Cinco cookies pra mim? Isso... eu nem sei o que dizer. Muito obrigado! Voce melhorou o meu dia!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.EventoNatal.Missao, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Alguns cookies cairiam muito bem... Mas eu tenho muita fome, talvez 5 ou mais poderiam resolver meu problema.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Que otimo! Eu procuraria por conta propria, mas nao posso deixar de vigiar os insetos. Eles podem ser um pouco... imprevisiveis. Muito obrigado.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Barter, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(3370) >= 1 then
                player:removeItem(3370, 1)
                player:addExperience(50000)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Barter, 2)
                npcHandler:say("Voce trouxe mesmo! Ela esta impecavel. Muito obrigado. Se tiver forca o suficiente, tenho uma nova {missao} para voce.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui o item? Lembre-se, preciso de uma Knight Armor.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Otimo! Voce devera me trazer 5 Carniphila Seeds, 5 Dragons Tails, 5 Fish Fins e 1 spider silk. Ficarei esperando.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Barter, 3)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(10300) >= 5 and player:getItemCount(11457) >= 5 and player:getItemCount(5895) >= 5 and player:getItemCount(5879) >= 1 then
                player:removeItem(10300, 5)
                player:removeItem(11457, 5)
                player:removeItem(5895, 5)
                player:removeItem(5879, 1)
                player:addExperience(100000)
                npcHandler:say("Incrivel! Com esses alimentos e a Spider Silk para juntar tudo vou fazer uma bela 'ceia' para os insetos Muito obrigado, voce agora pode acessar o local quando quiser.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Barter, 4)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao tem todos os itens. Preciso de 5 Carniphila Seeds, 5 Dragons Tails, 5 Fish Fins e 1 spider silk.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        npcHandler:say("Oh! Ok. Sem problemas, eu acho...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. O que voce busca por aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
