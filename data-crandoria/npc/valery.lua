local internalNpcName = "Valery"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 149,
	lookHead = 2,
	lookBody = 0,
	lookLegs = 97,
	lookFeet = 2,
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

    storage = player:getStorageValue(Storage.Quest.Crandoria.Eventos.Caldos)
    caldosLeft = 19 - player:getStorageValue(Storage.Quest.Crandoria.Eventos.Caldos)

    if MsgContains(message, "missao") or MsgContains(message, "caldo") or MsgContains(message, "mission") or MsgContains(message, "caldos") then
        if player:getStorageValue(Storage.Quest.Crandoria.Eventos.SaoJoao) < 1 then
            npcHandler:say({"Na vespera da Festa Junina de Crandoria aqueles Orcs horrendos roubaram meus Caldos de Feijao. Eles distribuiram os caldos entre os monstros do Novo Continente e agora esotu sem nenhum caldo na minha barraca. ...", 
            "Por isso preciso de ajuda para recuperar meus Caldos de Feijao desses malditos vermes espalhados por todo lugar! Darei uma enorme {recompensa} para todos que pegarem uma boa quantidade deles. Voce poderia pega-los para mim?"}, npc, creature)
            npcHandler:setTopic(playerId, 1)
        else
            if storage < 20 then
                npcHandler:say("Voce possui Caldos de Feijao para mim?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                npcHandler:say("Voce ja me entregou todos os Caldos de Feijao que eu pedi. Agora aguarde ate as 22:00h do ultimo dia do evento de Sao Joao para acessar o portal ao lado e enfrentar Groguron.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say({"Maravilha! Os habitantes de Crandoria nunca decepcionam! Escute, quarta as 22:00h eu abrirei um portal ao lado da minha barraca. Cada vez que voce quiser entrar no portal sera necessario ter entregue pelo menos 20 Caldos de Feijao. ...",
            "Detro do portal reside Groguron, um demonio terrivel, faminto por especiarias de Festa Junina. Ele foi preso nessa ilha ha muito tempo e carrega consigo diversos tesouros. Quem entrar no portal tera a chance de enfrenta-lo e reivindicar esse premio inestimavel! ...",
            "Voce esta pronto para esse desafio?"}, npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Entao va e traga-me quantos Caldos de Feijao conseguir!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Eventos.SaoJoao, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:removeItem(21184, 1) then
                if storage < 1 then
                    npcHandler:say("Muito bom! Comecamos bem. Traga-me mais 19 Caldos e voce podera acessar o portal na proxima vez que ele estiver aberto!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, 1)
                    npcHandler:setTopic(playerId, 0)
                elseif storage >= 1 and storage < 19 then
                    npcHandler:say("Otimo. Traga-me mais " ..caldosLeft.. " Caldos de Feijao e voce tera permissao para acessar o portal quando ele estiver aberto.", npc, creature)
                    player:addMoney(5000, true)
                    player:addExperience(player:getLevel() * 100, true)
                    player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, storage + 1)
                    npcHandler:setTopic(playerId, 0)
                elseif storage == 19 then
                    npcHandler:say("Que maravilha! Voce me trouxe 20 Caldos de Feijao rapidamente! Te concedo permissao para entrar no portal e enfrentar Groguron na proxima vez que estiver aberto.", npc, creature)
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                    player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, 20)
                    npcHandler:setTopic(playerId, 0)
                elseif storage >= 20 then
                    npcHandler:say("Quanto mais melhor! Como combinado, aqui estao suas moedas de ouro e sua experiencia!", npc, creature)
                    player:addMoney(15000 + (500 * storage), true)
                    player:addExperience((player:getLevel() * 250) + (1000 * storage), true)
                    player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, storage + 1)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("E onde estaria esse Caldo de Feijao? Esta se confundindo ou tentando me enganar? ...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        npcHandler:say("Ah.. Tudo bem entao.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. Estou buscando por {caldos} de feijao. Poderia me ajudar nessa {missao}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)



-- local internalNpcName = "Valery"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 149,
-- 	lookHead = 2,
-- 	lookBody = 0,
-- 	lookLegs = 97,
-- 	lookFeet = 2,
-- 	lookAddons = 3
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
--     npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
--     npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
--     npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
--     npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
--     npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
--     npcHandler:onCloseChannel(npc, creature)
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

--     storage = player:getStorageValue(Storage.Quest.Crandoria.Eventos.Caldos)
--     caldosLeft = 9 - player:getStorageValue(Storage.Quest.Crandoria.Eventos.Caldos)

--     if MsgContains(message, "missao") or MsgContains(message, "caldo") or MsgContains(message, "mission") or MsgContains(message, "caldos") then
--         if player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) ~= 6 then
--             if player:getStorageValue(Storage.Quest.Crandoria.Eventos.SaoJoao) < 1 then
--                 npcHandler:say({"Na vespera da Festa Junina de Crandoria aqueles Orcs horrendos roubaram meus Caldos de Feijao. Eles distribuiram os caldos entre os monstros do Novo Continente e agora esotu sem nenhum caldo na minha barraca. ...", 
--                 "Por isso preciso de ajuda para recuperar meus Caldos de Feijao desses malditos vermes espalhados por todo lugar! Darei uma enorme {recompensa} para todos que pegarem uma boa quantidade deles. Voce poderia pega-los para mim?"}, npc, creature)
--                 npcHandler:setTopic(playerId, 1)
--             else
--                 npcHandler:say("Voce possui Caldos de Feijao para mim?", npc, creature)
--                 npcHandler:setTopic(playerId, 3)
--             end
--         end
--     elseif MsgContains(message, "reward") or MsgContains(message, "recompensa") then
--         if player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) == 5 or player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) == 6 or player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) == 7 then
--             player:setStorageValue(Storage.Quest.Crandoria.Eventos.Portais, 20)
--             player:addItem(12811, 1, true)
--             npcHandler:say("Incrivel! Voce foi de grande ajuda durante este evento. Aqui estasua recompensa especial, espero que goste!", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         else
--             npcHandler:say("Voce ja pegou sua recompensa.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         end
--     elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say({"Maravilha! Os habitantes de Crandoria nunca decepcionam! Escute, todas as quartas as 22:00h e domingos as 20:00h eu abrirei um portal ao lado da minha barraca. Cada vez que voce quiser entrar no portal sera necessario ter entregue pelo menos 10 Caldos de Feijao. ...",
--             "Detro do portal reside Groguron, um demonio terrivel, faminto por especiarias de Festa Junina. Ele foi preso nessa ilha ha muito tempo e carrega consigo um tesouro inestimavel. Quem entrar no portal tera a chance de enfrenta-lo e reivindicar esse premio inestimavel! ...",
--             "Para cada Caldo de Feijao alem dos 20 necessarios que voce me trouxer, te entregarei moedas de ouro e pontos de experiencia. CUIDADO! Ao entrar no portal sua contagem de Caldos Entregues sera zerada! Voce esta pronto para esse desafio?"}, npc, creature)
--             npcHandler:setTopic(playerId, 2)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             npcHandler:say("Entao va e traga-me quantos Caldos de Feijao conseguir!", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.Eventos.SaoJoao, 1)
--             npcHandler:setTopic(playerId, 0)
--         elseif npcHandler:getTopic(playerId) == 3 then
--             if player:removeItem(21184, 1) then
--                 if storage < 1 then
--                     npcHandler:say("Muito bom! Comecamos bem. Traga-me mais 19 Caldos e voce podera acessar o portal na proxima vez que ele estiver aberto!", npc, creature)
--                     player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, 1)
--                     npcHandler:setTopic(playerId, 0)
--                 elseif storage >= 1 and storage < 19 then
--                     npcHandler:say("Otimo. Traga-me mais " ..caldosLeft.. " Caldos de Feijao e voce tera permissao para acessar o portal quando ele estiver aberto.", npc, creature)
--                     player:addMoney(5000, true)
--                     player:addExperience(player:getLevel() * 100, true)
--                     player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, storage + 1)
--                     npcHandler:setTopic(playerId, 0)
--                 elseif storage == 19 then
--                     npcHandler:say("Que maravilha! Voce me trouxe 10 Caldos de Feijao rapidamente! Te concedo permissao para entrar no portal e enfrentar Groguron na proxima vez que estiver aberto.", npc, creature)
--                     player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
--                     player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
--                     player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
--                     player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, 20)
--                     npcHandler:setTopic(playerId, 0)
--                 elseif storage >= 20 then
--                     npcHandler:say("Quanto mais melhor! Como combinado, aqui estao suas moedas de ouro e sua experiencia!", npc, creature)
--                     player:addMoney(15000 + (500 * storage), true)
--                     player:addExperience((player:getLevel() * 250) + (1000 * storage), true)
--                     player:setStorageValue(Storage.Quest.Crandoria.Eventos.Caldos, storage + 1)
--                     npcHandler:setTopic(playerId, 0)
--                 end
--             else
--                 npcHandler:say("E onde estaria esse Caldo de Feijao? Esta se confundindo ou tentando me enganar? ...", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
--         npcHandler:say("Ah.. Tudo bem entao.", npc, creature)
--         npcHandler:setTopic(playerId, 0)
--     elseif MsgContains(message, "recompensa") then
--         if player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) == 6 then
--             npcHandler:say("Excelente! Voce realmente me ajudou muito recuperando meus Caldos de Feijao e enfrentando o terrivel Groguron. Aqui esta sua recompensa especial!", npc, creature)
--             player:addPremiumDays(3, true)
--             player:addExperience(player:getLevel() * 25000, true)
--             player:setStorageValue(Storage.Quest.Crandoria.Eventos.Portais, 7)
--         elseif player:getStorageValue(Storage.Quest.Crandoria.Eventos.Portais) < 6 then
--             npcHandler:setTopic(playerId, 0)
--             npcHandler:say({"Entregue 20 Caldos de Feijao e recebera permissao para acessar o proximo portal. Para cada caldo alem dos 10 entregues, voce recebera 15.000 moedas de ouro e 250 x seu nivel em pontos de experiencia. ...",
--             "Ao final do evento, se voce tiver entrado em pelo menos 5 dos portais, recebera uma recompensa {especial}. Basta falar sobre os {caldos} comigo e eu ja saberei o que fazer!"}, npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         end
--     elseif MsgContains(message, "especial") then
--         npcHandler:say("Ei, ei, ei! Voces estao sempre querendo estragar as surpresas! Malditos guerreiros e sua curiosidade... Ha Ha Ha! Voce nao vai se arrepender, confie em mim! Mas ser uma surpresa... Apenas traga-me os {caldos}. Estarei esperando!", npc, creature)
--         npcHandler:setTopic(playerId, 0)
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola. Estou buscando por {caldo}s de feijao. Poderia me ajudar nessa {missao}?")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
