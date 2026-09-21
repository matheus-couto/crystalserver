local internalNpcName = "Gerard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 335,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 82,
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

    local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
    local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
    local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
    local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
    local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER

    local mTypeA = MonsterType("Dragon Lord")
    local raceIdA = mTypeA:raceId()

    local storage = player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso)


    local area1 = {
        fromPosition = {x = 4457, y = 5464, z = 15},
        toPosition = {x = 4465, y = 5473, z = 15}
    }

    local area2 = {
        fromPosition = {x = 4457, y = 5465, z = 15},
        toPosition = {x = 4465, y = 5473, z = 14}
    }

    local function isInArea(player, area)
        local playerPos = player:getPosition()
        return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
            and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
            and playerPos.z == area.fromPosition.z
    end

    local function hasPlayerInArea(fromPosition, toPosition)
        for x = fromPosition.x, toPosition.x do
            for y = fromPosition.y, toPosition.y do
                local pos = Position(x, y, fromPosition.z)
                local tile = Tile(pos)
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isPlayer() then
                        return true
                    end
                end
            end
        end
        return false
    end

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage < 1 then
            npcHandler:say("Entao voce concluiu todos os desafios do Almirante? Interessante... Quem sabe voce nao sera a pessoa que finalmente podera me ajudar numa tarefa... \z
            Mas antes de te confiar essa grande tarefa, precisarei testar sua forca para descobrir se voce realmente esta pronto para tal jornada. Vejamos... Algo facil para comecar... \z
            Ja sei! Derrote 1000 Dragon Lords e retorne ate mim. Mas escute: Voce so tera tres dias! Estarei esperando. Espero que retorne com vida! Ha ha ha ha!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 1)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 3 * 24 * 60 * 60)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdA)
            player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer) > os.time() then
                if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) < 1000 then
                    npcHandler:say("Voce ainda nao derrotou os 1000 Dragon Lords que eu pedi para medir seu poder, ams voce ainda tem tempo. Volte qunado terminar a missao.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Voce derrotou mesmo os 1000 Dragon Lords? HA! Mas isso realmente me espanta. Por um tempo achei que voce nao voltaria mais. Aqui, uma singela recompensa. \z
                    Muito bem, |PLAYERNAME|! Vamos ao seu proximo desafio. Agora quero que voce va ate o lar dos Wyrms e derrote alguns deles. Traga para mim 25 Wyrm Scales.", npc, creature)
                    player:addExperience(player:getLevel() * 1000)
                    player:addItem(3043, 50)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 2)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Parece que voce nao conseguiu derrotar os 1000 Dragon Lords a tempo, nao e mesmo? Bom, te darei uma segunda chance. Va! Derrote as criaturas em ate tres dias.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 3 * 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraRaceId, raceIdA)
                player:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, 1)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 2 then
            npcHandler:say("Voce trouxe as 25 Wyrm Scales com voce?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 3 then
            npcHandler:say("Como eu disse, preciso que me traga 1 Zaoan Helmet, 1 Zaoan Armor, 1 Zaoan Legs e 1 Zaoan Shoes. Voce tem todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 4 then
            npcHandler:say("Como eu disse, preciso que me traga 1 Zaoan Helmet, 1 Spellweavers Robe, 1 Zaoan Legs e 1 Zaoan Shoes. Voce tem todos os itens?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif storage == 5 then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer) > os.time() then
                npcHandler:say("Suas novas roupas ainda nao estao prontas.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Muito bem, suas novas roupas estao prontas! Aqui, seu novo Warmaster Outfit. Agora voce esta pronto para sua verdadeira {missao}. Me avise quando quiser iniciar.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 6)
                player:addOutfit(335, 0)
                player:addOutfit(336, 0)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 6 then
            npcHandler:say("Bom, |PLAYERNAME|... Minha familia foi a primeira a se mudar para Viridia. Poucos aqui sabem, mas eu e Haldor somos, na verdade, irmaos. \z
            Nossa familia se mudou de Ankrahmun para o Novo Continente logo que os ataques dos demonios comecaram. Ao chegar aqui, travamos algumas batalhas e em uma delas... \z
            Bom, eu me descuidei e acabei perdendo o amuleto da familia. Um amuleto antigo desenterrado na antiga Ankramun ha mais de 100 anos. Preciso de sua ajuda para recupera-lo. Voce pode me ajudar?", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif storage == 7 then
            npcHandler:say("Va e encontra o Amuleto de Suon! Traga-o de volta para mim, por favor.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 8 then
            if player:getItemCount(36707) >= 1 then
                npcHandler:say("Espera um pouco ai... o que e isso? Ele esta incompleto! Nao posso acreditar... E olhe, tem um pedaco de papel preso a ele. Parece que tem algo escrito. \z
                Esta escrito: 'Volk Galugha'. Eu sei o que isso significa... E ja sei onde esta o restante do amuleto. Esta na Arena do Caos. Esse lugar maldito! Eu nao acredito! \z
                Bom, |PLAYERNAME|. Parece que precisarei de voce novamente. Va ate o Almirante Haldor e passe as palavras 'volk galugha' para ele. Ele te guiara para que voce chegue na Arena.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 9)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Va e encontre o Amuleto de Suon! Traga-o de volta para mim, por favor.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 9 then
            npcHandler:say("O que esta esperando, |PLAYERNAME|? Converse com Haldor, obtenha pistas sobre a Arena e encontre o restante do meu amuleto!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 10 then
            npcHandler:say("VOCE ENCONTROU A ARENA? Isso me parece otimo! Mas... onde esta o restante do amuleto?... Voce nao finalizou a arena, nao e mesmo? Tudo bem... eu espero ate que voce consiga terminar o desafio.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif storage == 12 then
            if player:getItemCount(36706) >= 1 then
                player:removeItem(36706, 1)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 13)
                npcHandler:say("Voce... voce encontrou! Eu nao posso acreditar que a busca finalmente terminou! Ou... quase... Bom, eu nao te disse, mas temos outra questao: De acordo com as lendas, apenas uma pessoa com coracao puro pode unir as duas pecas. \z
                Caso contrario, a lenda diz que um grande mal podera se espalhar. Escute, |PLAYERNAME|, eu nao sei se sou uma pessoa digna, entao quero que voce me acompanhe ao tentar {unir} as duas pecas. Caso algo ruim aconteca, precisarei de ajuda ou, quem sabe... \z
                Pode haver a possibilidade de que voce tenha que me sacrificar. Te darei novos equipamentos para seu Warmaster Outfits, isso o ajudara na missao. Me avise quando estiver pronto para que possamos {unir} as pecas.", npc, creature)
                player:addOutfitAddon(335, 1)
                player:addOutfitAddon(336, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu soube que voce finalizou o desafio da Arena do Caos! Meus parabens! Mas onde esta a gema do meu amuleto? Por favor, traga-a ate mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif storage == 13 then
            npcHandler:say("Esta pronto para unir as pecas?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        elseif storage == 14 then
            npcHandler:say("Voce conseguiu derrotar o Tormento de Suon? Quando unimos as pecas Suon apareceu para mim e disse que voce passaria por uma provacao. Caso voce concluisse, ficaria com o amuleto. \z
            Eu nao contestarei o desejo de um ser que ate o momento eu imaginava ser apenas lenda... Entao, aqui esta. Voce mereceu realmente. E alem do amuleto estarei te concedendo o ultimo adorno da sua Warmaster Outfits. \z
            Agora voce se tornou realmente um mestre de guerra. Muito obrigado e parabens pela conquista. Converse com Haldor para registra-la com as demais.", npc, creature)
            player:addItem(36708, 1)
            player:addOutfitAddon(335, 2)
            player:addOutfitAddon(336, 2)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 15)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Reward, 2)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "unir") then
        if storage == 12 then
            npcHandler:say("Tem certeza de que esta pronto?", npc, creature)
            npcHandler:setTopic(playerId, 5)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        local money = player:getBankBalance() + player:getMoney()
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(9665) >= 25 then
                if knight or paladin or monk then
                    player:removeItem(9665, 25)
                    player:addExperience(player:getLevel() * 1000)
                    npcHandler:say("Olha so! Voce realmente conseguiu. Talvez Haldor tivesse razao em confiar em voce, afinal... Mas ainda nao tenho certeza de que esta pronto para o que esta por vir... \z
                    Facamos mais um teste: Derrote alguns lizards e drakens e me traga 1 Zaoan Helmet, 1 Zaoan Armor, 1 Zaoan Legs e 1 Zaoan Shoes. Traga todos os itens e passaremos a missao de verdade.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 3)
                    npcHandler:setTopic(playerId, 0)
                else
                    player:removeItem(9665, 25)
                    player:addExperience(player:getLevel() * 1000)
                    npcHandler:say("Olha so! Voce realmente conseguiu. Talvez Haldor tivesse razao em confiar em voce, afinal... Mas ainda nao tenho certeza de que esta pronto para o que esta por vir... \z
                    Facamos mais um teste: Derrote alguns lizards e drakens e me traga 1 Zaoan Helmet, 1 Spellweavers Robe, 1 Zaoan Legs e 1 Zaoan Shoes. Traga todos os itens e passaremos a missao de verdade.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 4)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("E onde estao os itens? Acho que sua cabeca nao esta funcionando bem...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(10385) >= 1 and player:getItemCount(10384) >= 1 and player:getItemCount(10387) >= 1 and player:getItemCount(10386) >= 1 then
                player:removeItem(10385, 1)
                player:removeItem(10384, 1)
                player:removeItem(10387, 1)
                player:removeItem(10386, 1)
                player:addExperience(player:getLevel() * 1000)
                npcHandler:say("Otimo! Eu nao havia te contado, mas na verdade esses equipamentos servirao para fazer uma nova roupa para que voce possa se sair melhor em sua proxma missao. Voce recebera o Warmaster Outfit. \z
                Passarei o equipamento para meu ferreiro particular. Volte aqui em um dia e sua roupa estara pronta e, em seguida, te iniciaremos a verdadeira missao! Ate breve!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 5)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Acredito que tenha se confundido. Voce nao possui todos os itens que solicitei.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(10385) >= 1 and player:getItemCount(10438) >= 1 and player:getItemCount(10387) >= 1 and player:getItemCount(10386) >= 1 then
                player:removeItem(10385, 1)
                player:removeItem(10438, 1)
                player:removeItem(10387, 1)
                player:removeItem(10386, 1)
                player:addExperience(player:getLevel() * 1000)
                npcHandler:say("Otimo! Eu nao havia te contado, mas na verdade esses equipamentos servirao para fazer uma nova roupa para que voce possa se sair melhor em sua proxma missao. Voce recebera o Warmaster Outfit. \z
                Passarei o equipamento para meu ferreiro particular. Volte aqui em um dia e sua roupa estara pronta e, em seguida, te iniciaremos a verdadeira missao! Ate breve!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Timer, os.time() + 24 * 60 * 60)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 5)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Acredito que tenha se confundido. Voce nao possui todos os itens que solicitei.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 4 then
            npcHandler:say("Eu sabia que voce seria de grande ajuda! Olha, eu me mudei para Viridia apenas para encontrar esse amuleto. Haldor disse que um explorador descreveu um item que assemelhava a ele. \z
            Esse item havia sido encontrado nas profundezas da grande Piramide, a leste da selva de Viridia. De acordo com o explorador, ao tentar pegar o objeto ele sentiu uma tremenda forca maligna a sua volta. \z
            Com medo, ele fugiu sem olhar para tras. Se quiser mais informacoes, tenho alguns registros no andar de cima. Fique a vontade para pesquisar. Por favor, recupere nosso amuleto!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 7)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 5 then
            if hasPlayerInArea(Position(4458, 5465, 14), Position(4465, 5473, 14)) or hasPlayerInArea(Position(4458, 5465, 15), Position(4465, 5473, 15)) then
                npcHandler:say("Nada acontceu... Talvez tenhamos que tentar novamente depois. Volte em alguns segundos e tentaremos mais uma vez.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("AAAAAAARGH!!!", npc, creature)
                player:teleportTo(Position(player:getPosition().x - 35, player:getPosition().y - 10, 15))
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ah.. Tudo bem.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz em meu centro de treinamento?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
