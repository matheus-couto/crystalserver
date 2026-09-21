local internalNpcName = "Howard Rootberg"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1146,
	lookHead = 29,
	lookBody = 114,
	lookLegs = 73,
	lookFeet = 26,
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

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "ilha perdida") then
        if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) >= 1 then
            if player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) < 1 then
                npcHandler:say("Ah... a Ilha Perdida de Astralis... passando pelo portao e pegando o bote na costa voce chegara rapidamente a uma ilha. Essa ilha abriga criaturas mutantes poderosas e uma abominacao terrivel. \z
                De tempos em tempos a abominacao ganha mais forcas e as criaturas da ilha se multiplicam, por isso estamos sempre buscando por guerreiros que possam nos ajudar a conte-la. Esta interessado nessa missao? ( {sim} / {nao} )", npc, creature)
                npcHandler:setTopic(playerId, 1)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 1 then
                npcHandler:say("Voce trouxe as 100 Dragonfruits, os 25 Cobalt Ridges e as 10 Pieces of Wood com voce? ( {sim} / {nao} ) - ({liberar} acesso por 5000 Tibia Coins)", npc, creature)
                npcHandler:setTopic(playerId, 2)
            elseif player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 2 then
                npcHandler:say("Pegue o barco passando pelo portao e tente encontrar Elendor, o elfo que se encontra no centro da ilha. Ele te explicara qual sera sua missao. E cuidado com os monstros no caminho!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say("Sinto muito, mas nao posso compartilhar informacoes sobre a ilha com aqueles que nao fazem parte da Sociedade dos Magos.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "liberar") then
        npcHandler:say("Uma contribuicao de 5000 Tibia Coins tambem podera resolver meu problema. Voce deseja seguir esse caminho? ({liberar} acesso por 5000 Tibia Coins).", npc, creature)
        npcHandler:setTopic(playerId, 3)
    elseif MsgContains(message, "runa") or MsgContains(message, "rune") then
        if player:getStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso) == 2 then
            if player:getItemCount(3161) >= 25 and player:getItemCount(3202) >= 25 and player:getItemCount(3191) >= 25 then
                player:removeItem(3161, 25)
                player:removeItem(3202, 25)
                player:removeItem(3191, 25)
                player:setStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso, 3)
                player:addExperience(50000)
                npcHandler:say("As runas de Hindrael? Muito bom... muito bom mesmo. Preciso sempre me proteger de possiveis invasores e essas runas sao de grande ajuda. \z
                Por favor, agradeca a ele por mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Estou precisando de algumas runas para minha protecao. Me disseram que Hindrael as enviaria para mim.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem! Mas nao se afobe, primeiro preciso saber se eu posso realmente confiar que voce trabalha pelo bem de Astralis... Para isso te darei um simples teste: \z
            Trabalhe por um tempo na cidade e me traga alguns dos recursos obtidos no local. Digamos... 100 Dragonfruits, 25 Cobalt Ridges e 10 Pieces of Wood. Traga tudo para mim e te explicarei mais sobre a sua missao e a Ilha Perdida. \z
            (liberar este acesso por 5000 Tibia Coins? {sim} / {nao})", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(11682) >= 100 and player:getItemCount(39037) >= 25 and player:getItemCount(32002) >= 10 then
                player:removeItem(11682, 100)
                player:removeItem(39037, 25)
                player:removeItem(32002, 10)
                npcHandler:say("Humm.. parece que esta tudo em perfeito estado. Excelente! Muito bem, parece que voce realmente se importa com o bom andamento de Astralis e deseja mesmo ajudar. \z
                A partir de agora voce tera acesso ao barco que leva ate a ilha perdida. A sua proxima missao sera se encontrar com Elendor, o elfo anciao que se encontra num rochedo no centro da ilha. Va! Ele ja esta te esperando.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 2)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao possui todos os itens.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Voce tem certeza? ({sim} / {nao})", npc, creature)
            npcHandler:setTopic(playerId, 4)
        elseif npcHandler:getTopic(playerId) == 4 then
            if player:getTransferableCoins() >= 5000 then
                player:removeTransferableCoins(5000)
                npcHandler:say("Muito bem! Agradeco pela contribuicao. Voce podera acessar a Lost Island quando quiser!", npc, creature)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 8)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Se voce nao tiver Tibia Coins pode seguir a {missao} sem nenhum problema! (voce nao possui as Tibia Coins necessarias)", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Ok. Sem problemas!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. Estou protegendo o acesso a {ilha perdida}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)










-- local internalNpcName = "Howard Rootberg"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1146,
-- 	lookHead = 29,
-- 	lookBody = 114,
-- 	lookLegs = 73,
-- 	lookFeet = 26,
--     	lookAddons = 1,
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

--     if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "ilha perdida") then
--         if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) >= 1 then
--             if player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) < 1 then
--                 npcHandler:say("Ah... a Ilha Perdida de Astralis... passando pelo portao e pegando o bote na costa voce chegara rapidamente a uma ilha. Essa ilha abriga criaturas mutantes poderosas e uma abominacao terrivel. \z
--                 De tempos em tempos a abominacao ganha mais forcas e as criaturas da ilha se multiplicam, por isso estamos sempre buscando por guerreiros que possam nos ajudar a conte-la. Esta interessado nessa missao? ( {sim} / {nao} )", npc, creature)
--                 npcHandler:setTopic(playerId, 1)
--             elseif player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 1 then
--                 npcHandler:say("Voce trouxe as 100 Dragonfruits, os 25 Cobalt Ridges e as 10 Pieces of Wood com voce? ( {sim} / {nao} )", npc, creature)
--                 npcHandler:setTopic(playerId, 2)
--             elseif player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) == 2 then
--                 npcHandler:say("Pegue o barco passando pelo portao e tente encontrar Elendor, o elfo que se encontra no centro da ilha. Ele te explicara qual sera sua missao. E cuidado com os monstros no caminho!", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         else
--             npcHandler:say("Sinto muito, mas nao posso compartilhar informacoes sobre a ilha com aqueles que nao fazem parte da Sociedade dos Magos.", npc, creature)
--             npcHandler:setTopic(playerId, 0)
--         end
--     elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Muito bem! Mas nao se afobe, primeiro preciso saber se eu posso realmente confiar que voce trabalha pelo bem de Astralis... Para isso te darei um simples teste: \z
--             Trabalhe por um tempo na cidade e me traga alguns dos recursos obtidos no local. Digamos... 100 Dragonfruits, 25 Cobalt Ridges e 10 Pieces of Wood. Traga tudo para mim e te explicarei mais sobre a sua missao e a Ilha Perdida.", npc, creature)
--             player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 1)
--             npcHandler:setTopic(playerId, 0)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             if player:getItemCount(11682) >= 100 and player:getItemCount(39037) >= 25 and player:getItemCount(32002) >= 10 then
--                 player:removeItem(11682, 100)
--                 player:removeItem(39037, 25)
--                 player:removeItem(32002, 10)
--                 npcHandler:say("Humm.. parece que esta tudo em perfeito estado. Excelente! Muito bem, parece que voce realmente se importa com o bom andamento de Astralis e deseja mesmo ajudar. \z
--                 A partir de agora voce tera acesso ao barco que leva ate a ilha perdida. A sua proxima missao sera se encontrar com Elendor, o elfo anciao que se encontra num rochedo no centro da ilha. Va! Ele ja esta te esperando.", npc, creature)
--                 player:setStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso, 2)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 npcHandler:say("Voce nao possui todos os itens.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
--         npcHandler:say("Ok. Sem problemas!", npc, creature)
--         npcHandler:setTopic(playerId, 0)
--     end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem. Estou protegendo o acesso a {ilha perdida}.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
