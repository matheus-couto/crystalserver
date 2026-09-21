local internalNpcName = "Lucy"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 136,
	lookHead = 22,
	lookBody = 58,
	lookLegs = 0,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso)
    local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Timer)

    if MsgContains(message, "pai") or MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "negocios") then
        if storage < 1 then
            npcHandler:say("Ha alguns dias meu pai saiu rumo a Crandoria. Ele disse que precisava de olhos de Tarantulas. Nao tenho ideia do que aconteceu, mas nunca mais tive noticias dele. \z
            Tenho muito medo de que ele fique encurralado por alguma Giant Spider... Poderia me ajudar a encontra-lo?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 1 then
            npcHandler:say("Por favor, encontre meu pai!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 2 then
            npcHandler:say("Ele... esta morto?! Isso nao pode ser verdade... Nao posso acreditar, era o que eu mais temia. Preciso descobrir comos seguir com os {negocios} agora... \z
            Aqui, como combinado, sua recompensa. Obrigada por ter se arriscado para encontra-lo.", npc, creature)
            player:addItem(3035, 35)
            player:addExperience(150000, true)
            player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 3)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 3 then
            npcHandler:say("Meu pai era responsavel por buscar alguns recursos para Hakata, como produtos de criaturas e alimentos. Ele sempre foi otimo no que faz, por ser um guerreiro. \z
            Mas devo confessar que eu nao sou a melhor pessoa para derrotar monstros... Talvez voce pudesse me ajudar com isso enquanto treino mais. Te darei outras recompensas. Acha que consegue?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 4 then
            npcHandler:say("Voce trouxe os Bonelord Eyes?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 5 then
            if storageTimer > os.time() then
                npcHandler:say("Voce trouxe os Fish Fins?", npc, creature)
                npcHandler:setTopic(playerId, 4)
            else
                npcHandler:say("Sinto muito, mas o preparo inicial estragou por voce ter demorado mais de tres dias. Voce tera que reiniciar a missao.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 6 then
            if storageTimer > os.time() then
                npcHandler:say("Voce trouxe as Behemoth Claws?", npc, creature)
                npcHandler:setTopic(playerId, 5)
            else
                npcHandler:say("Sinto muito, mas o preparo inicial estragou por voce ter demorado mais de tres dias. Voce tera que reiniciar a missao.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 7 then
            if storageTimer > os.time() then
                npcHandler:say("Voce trouxe os 3 Lizard Leathers?", npc, creature)
                npcHandler:setTopic(playerId, 6)
            else
                npcHandler:say("Sinto muito, mas o preparo inicial estragou por voce ter demorado mais de tres dias. Voce tera que reiniciar a missao.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 8 then
            if storageTimer > os.time() then
                npcHandler:say("Voce trouxe o Cluster of Solace?", npc, creature)
                npcHandler:setTopic(playerId, 7)
            else
                npcHandler:say("Sinto muito, mas o preparo inicial estragou por voce ter demorado mais de tres dias. Voce tera que reiniciar a missao.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Mesmo? Voce faria isso por mim? Muito obrigada! Meu pai se chama Borghan, mas tambem o conhecem como Ghan. Por favor, encontre-o para mim! \z
            Nao tenho muito a oferecer, mas te garanto uma recompensa por qualquer noticia dele.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Que maravilha! Vai me ajudar muito, com certeza. Primeiro preciso confeccionar uma pocao especial que me protegera contra os monstros. \z
            Mas atencao, precisarei que voce me traga todos os ingredientes dentro de no maximo 3 dias, caso contrario o preparo ficara ruim e terei que comecar novamente. \z
            Traga-me 3 Bonelord Eyes. Esse sera o primeiro ingrediente. Quando ele for entregue, seu tempo se iniciara.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 4)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5898) >= 3 then
                npcHandler:say("Otimo! Ja posso comecar meu preparo da pocao. A partir de agora seu tempo de 3 dias se iniciara, entao nao demore, por favor. \z
                Traga-me agora 5 Fish Fins. E desculpe reforcar, mas por favor, seja rapido!", npc, creature)
                player:removeItem(5898, 3)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Timer, os.time() + 3 * 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 5)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao os 3 Bonelord Eyes?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getItemCount(5895) >= 5 then
                npcHandler:say("Muito bom. Estao todos com otima qualidade! Muito obrigada. Vamos ao proximo ingrediente? Agora preciso de 2 Behemoth Claws. \z
                E nao se esqueca, seja rapido!", npc, creature)
                player:removeItem(5895, 5)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao os Fish Fins?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 5 then
            if player:getItemCount(5930) >= 2 then
                npcHandler:say("Uma... duas... Certo! Voce conseguiu. Falta pouco para terminarmos. Agora traga 3 Lizard Leathers para mim.", npc, creature)
                player:removeItem(5930, 2)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 7)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao as Behemoth Claws?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 6 then
            if player:getItemCount(5876) >= 3 then
                npcHandler:say("Excelente! Falta apenas um ingrediente para finalizar a pocao: 1 Cluster of Solace. Acredito que nao sera um desafio para voce. \z
                Por favor, va depressa! Nosso tempo esta se esgotando.", npc, creature)
                player:removeItem(5876, 3)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 8)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde estao os Lizard Leathers? Corra, ou vamos perder o preparo da pocao!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 7 then
            if player:getItemCount(20062) >= 1 then
                npcHandler:say("Maravilha!!! Agora terei uma boa pocao de protecao para iniciar meus trabalho por Hakata no lugar de meu pai. Muito obrigada! \z
                Aqui, sua recompensa, como prometido. 100.000 gold coins e uma Black Candle. Espero que ajude em sua jornada.", npc, creature)
                player:removeItem(20062, 1)
                player:addItem(3043, 25)
                player:addItem(36875, 1)
                player:addItem(9099, 1)
                player:addExperience(player:getLevel() * 75000)
                player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 9)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o Cluster of Solace? Corra, ou vamos perder o preparo da pocao!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Meu {pai} esta fazendo muita falta...")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
