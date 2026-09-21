local internalNpcName = "Iaashna"
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
	lookBody = 121,
	lookLegs = 94,
	lookFeet = 1,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "task") or MsgContains(message, "desafio") then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) < 2 then
            npcHandler:say("Missao? Ha! Voce realmente acha que pode conquistar algo que eu mesma nao possa conquistar com minhas proprias maos? Nao me faca rir!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 2 then
            npcHandler:say("Bom... Parece que voce pode nao ser uma das pessoas mais fracas entre as que passaram por aqui... Como voce foi capaz de obter o cristal e teve coragem para adentrar o nosso Palacio Secreto, \z
            acho que posso te confiar uma missao importante. No fundo do palacio ha duas Asuras que estao passando por um teste especial e percisam desafiar criaturas poderosas para provar seu valor. \z
            Caso voce consiga derrotar as duas, eu te darei uma recompensa de grande valor. O que acha? Acha que da conta desse desafio?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 3 then
            npcHandler:say("Vejo que ainda nao conseguiu derrotar as duas Asuras Mestres, nao e mesmo? Eu entendo, elas sao mesmo fortes. Retorne aqui se conseguir derrota-las.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) > 3 then
            if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) > 4 and player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) < 8 then
                npcHandler:say("Vejo que ainda nao conseguiu derrotar as duas Asuras Mestres, nao e mesmo? Eu entendo, elas sao mesmo fortes. Retorne aqui se conseguir derrota-las.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 4 then
                npcHandler:say("HA! Parece que aquelas duas realmente precisam de mais treinamento. Voce lutou muito bem, meus parabens. Aqui esta sua recompensa pelo trabalho que elas te deram. Se quiser um {desafio} ainda maior, basta falar.", npc, creature)
                player:addItem(36727, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 8)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 8 then
                npcHandler:say("Talvez agora que as duas irmas foram derrotadas, voce possa derrotar a terceira irma: A mais forte de todas. Voce pode acessar sua sala no portal central do salao do Palacio. Boa sorte, voce vai precisar! Hahaha.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 9)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 9 then
                npcHandler:say("Ainda nao conseguiu derrotar a ultima das Asuras mais fortes? Nao me surpreende, eu sabia que seria dificil. Volte quando tiver exito na missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 10 then
                npcHandler:say("Impressionante! Eu... eu... eu nao esperava que voce conseguiria. Realmente, muito impressionante! Aqui, voce merece receber o nosso maior tesouro, o segredo supremo da asuras: O Holy Falcon!", npc, creature)
                player:addItem(3024, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 11)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 10)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "magic crystal") or MsgContains(message, "cristal magico") then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) < 1 then
            if player:getItemCount(11552) >= 1 then
                npcHandler:say("O QUE VOCE ESTA FAZENDO COM ISSO? Esse cristal... Voce... Escuta aqui, crianca, eu acho que voce nao sabe com o que voce esta lidando... \z
                Que tal voce me deixar ficar com esse cristal? Em troca posso te oferecer 1.000.000 moedas de {ouro}, um {item especial} surpresa ou, caso queira realmente se arriscar... \z
                Posso te oferecer uma {passagem} vitalicia dentro do Palacio Secreto das Asuras. O que voce acha? Gostaria de alguma dessas opcoes em troca do cristal?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            else
                npcHandler:say("Eu nao faco ideia do que voce esta falando... Por favor, me deixe em paz.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) == 1 then
            if player:getItemCount(11552) >= 1 then
                npcHandler:say("Se me entregar este cristal te darei uma {passagem} por toda a vida para o Palacio Secreto das Asuras. O que acha?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                npcHandler:say("Eu nao faco ideia do que voce esta falando... Por favor, me deixe em paz.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) >= 2 then
            npcHandler:say("Voce ja me entregou o cristal e possui agora permissao para acessar o Palacio. Siga em frente.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Excelente! Basta escolher. O que voce prefere? {ouro}, um {item especial} ou uma {passagem} para nosso Palacio Secreto?.", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:removeItem(11552, 1) then
                npcHandler:say("Trato feito! Passe-me este cristal, jovem insolente. Entre no Palacio quando quiser, aposto que nao sobrevivera por muito tempo la dentro... Ha ha ha!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 2)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 3)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 7)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o cristal? Esta tentando me passar pra tras?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Nao sei o que voce tem mais: Coragem ou estupidez. Mas fico feliz que aceite o desafio! Ha ha ha ha! E preste atencao: Apesar de voce ter recebido acesso ao Palacio, saiba que minhas queridas \z
            asuras nao terao piedade de voce e te atacarao como fazem com qualquer outro estranho que acesse nosso solo sagrado. Esta avisado! Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 3)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "ouro") or MsgContains(message, "gold") then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
            if player:removeItem(11552, 1) then
                npcHandler:say("Trato feito! Passe-me este cristal, jovem insolente. Pronto, aqui esta seu ouro.", npc, creature)
                player:addItem(14112, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o cristal? Esta tentando me passar pra tras?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "item especial") or MsgContains(message, "special item") or MsgContains(message, "item") then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
            if player:removeItem(11552, 1) then
                npcHandler:say("Trato feito! Passe-me este cristal, jovem insolente. Pronto, aqui esta seu item.", npc, creature)
                player:addItem(36727, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 1)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o cristal? Esta tentando me passar pra tras?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "passage") or MsgContains(message, "passagem") then
        if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 or npcHandler:getTopic(playerId) == 3 then
            if player:removeItem(11552, 1) then
                npcHandler:say("Trato feito! Passe-me este cristal, jovem insolente. Entre no Palacio quando quiser, aposto que nao sobrevivera por muito tempo la dentro... Ha ha ha!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret, 2)
                player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 12)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("E onde esta o cristal? Esta tentando me passar pra tras?", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz aqui, |PLAYERNAME|?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
