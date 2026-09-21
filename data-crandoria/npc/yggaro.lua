local internalNpcName = "Yggaro"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1200,
	lookHead = 111,
	lookBody = 38,
	lookLegs = 77,
	lookFeet = 38,
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
        if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights < os.time()) then
            if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Outfit) < 1 then
                if player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) < 1 then
                    npcHandler:say({"Me chamo Yggaro e sou responsavel pelos farois de Nivabi. Nosso arquipelago possui muitas extremidades rochosas e perigosas para os navios, alem de sempre haver neblina por toda a parte. ...",
                    "Meu trabalho sempre foi acender os farois na sequencia correta para que os Navios que dao a volta em Nivabi possam seguir seu caminho em paz, porem agora estou velho e ando tendo dificuldades para chegar a alguns locais. ...",
                    "Estou oferecendo uma boa recompensa para quem puder me auxiliar nessa tafera. Voce gostaria de me ajudar?"}, npc, creature)
                    npcHandler:setTopic(playerId, 1)
                elseif player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 1 then
                    npcHandler:say("Por favor, acenda todos os doze farois, deixando este por ultimo. Depois volte a falar comigo e te entregarei sua recompensa. E lembre-se: Voce nao pode demorar mais que tres minutos entre cada farol!", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
                    npcHandler:setTopic(playerId, 0)
                elseif player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) > 1 and player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) < 13 then
                    npcHandler:say("Voce ja iniciou o processo de acender as tochas. Gostaria de reiniciar?", npc, creature)
                    npcHandler:setTopic(playerId, 3)
                elseif player:getStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress) == 13 then
                    npcHandler:say("Muito obrigado! Finalmente consegui descansar um pouco por um dia, depois de todos esses anos... Aqui esta, como prometido, sua recompensa. Te darei tambem algumas roupas tipicas de Nivabi, para que se sinta mais em casa.", npc, creature)
                    player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 14)
                    player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Outfit, 1)
                    player:addOutfit(1386, 0)
                    player:addOutfit(1387, 0)
                    player:addItem(14112, 1)
                    player:addItem(30060, 1)
                    local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                    npcHandler:setTopic(playerId, 0)
                end
            else
                npcHandler:say("Ah, nao vi que era voce! Nao tenho mais nada a te pedir. Eu e Nivabi agradecemos por sua ajuda!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say("Voce foi muito lento! Precisara comecar tudo novamente... Voce esta pronto?", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 0)
            npcHandler:setTopic(playerId, 1)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Excelente! Em instantes um navio vai passar por aqui, preciso que voce acenda todos os doze farois do arquipelago de Nivabi. O navio precisara seguir por todos eles. \z
            Para acender um farol basta usar o carvao no centro. Voce vera uma chama especial sendo alimentada sobre ele. Mas preste atencao! O navio precisa seguir seu curso, entao voce precisara acender o proximo farol \z
            em no maximo 5 minutos apos o anterior. Se voce demorar mais que 5 minutos o navio pode ficar perdido. Vou comecar a conta o tempo. Voce esta pronto?", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 1)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
            npcHandler:say("Entao corra! Voce tem pouco tempo e o tempo ja esta correndo. Acenda todos os doze farois e volte para falar comigo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            npcHandler:say("Entao tudo bem. Lembre-se que voce tem apenas 5 minutos entre cada uma. Pode comecar!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Progress, 1)
            player:setStorageValue(Storage.Quest.Crandoria.NivabiLights.Lights, os.time() + 300)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        if npcHandler:getTopic(playerId) ~= 0 then
            npcHandler:say("Entao tudo bem.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. Poderia me dar uma ajuda com uma {missao} importante?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser usar a forja.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
