local internalNpcName = "Zidrael"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1136,
	lookHead = 0,
	lookBody = 112,
	lookLegs = 66,
	lookFeet = 26,
    	lookAddons = 0,
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

    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral) - os.time()) / 60)

    if MsgContains(message, "mission") or MsgContains(message, "missao") or MsgContains(message, "sim") or MsgContains(message, "yes") then
        if player:getLevel() < 150 then
            npcHandler:say("Sinto muito, mas creio que voce nao conhece Viridia o suficiente para completar minhas missoes a tempo. Retorne quando estiver no nivel 150 ou maior.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        else
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral) < os.time() then
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) < os.time() then
                    local chance = math.random(1, 5)
                    if chance == 5 or chance == 4 then
                        npcHandler:say("Hoje preciso de sua ajuda para acender os farois de Viridia. Ha 6 deles no total espalhados pelas extremidades da cidade. Voce deve acende-los em ordem. \z
                        Primeiro acenda o farol localizado na pequena ilha de areia a nordeste da selva; depois acenda o farol guardado por wyrms; em seguida o farol no arquipelago dos ogres, ao norte; \z
                        O proximo esta localizado no bioma dos insetos gigantes; em seguida voce deve acender o farol na ilha dos silencers e, por ultimo, o farol ao sul das Terras Frias. Corra! Voce tem 2 horas.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time() + 2 * 60 * 60)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral, os.time() + 24 * 60 * 55)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 1)
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 3 then
                        npcHandler:say("Ouvi dizer que ha uma passagem pela agua para o refugio dos temiveis Deeplings. No interior do local ha uma ostra gigante expelindo gases toxicos na agua. \z
                        Sua missao sera encontrar a ostra gigante no refugio dos Deeplings e fecha-la, cessando assim a producao do gas. Voce tem 2 horas para terminar sua missao e retornar ate mim.", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time() + 2 * 60 * 60)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral, os.time() + 24 * 60 * 55)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 10)
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 2 then
                        npcHandler:say("Nas profundezas das cavernas dos Dwarves há uma estatua que deve ser destruida. A destruicao da estatua sera importante para lembrar a todos os dwarves por quem Viridia e realmente governada. \z
                        Para alcanca-la voce tera que descer pelo barco a vapor e enfrentar alguns exilados no caminho... \z
                        Em algum lugar da area dos exilados voce encontrara a estatua de dwarf. Para destrui-la utilize esse martelo. Voce tem duas horas.", npc, creature)
                        player:addItem(3460, 1)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time() + 2 * 60 * 60)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral, os.time() + 24 * 60 * 55)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 20)
                        npcHandler:setTopic(playerId, 0)
                    elseif chance == 1 then
                        npcHandler:say("Ha algum tempo Zoltan havia instalado dois receptores de sinal magico nas profundezas do esconderijo dos Infernalists, mas recentemente o sinal foi perdido. \z
                        Va ate o local e ligue novamente os dois receptores. Atencao: Para que se mantenham ligados voce deve ligar um e, em no maximo 10 segundos, ligar o proximo. Caso contrario nao ira funcionar. \z
                        Voce tera 2 horas para completar essa missao. Estarei esperando!", npc, creature)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time() + 2 * 60 * 60)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral, os.time() + 24 * 60 * 55)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 30)
                        npcHandler:setTopic(playerId, 0)
                    end
                end
            else
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) > os.time() then
                    local timeLeft2 = math.floor((player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest) - os.time()) / 60)
                    local exp = timeLeft2 * 250 * player:getLevel()
                    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) > 0 and player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) < 7 then
                        npcHandler:say("Voce precisa acender todos os 6 farois na ordem correta. Primeiro acenda o farol localizado na pequena ilha de areia a nordeste da selva; depois acenda o farol guardado por wyrms; em seguida o farol no arquipelago dos ogres, ao norte; \z
                        O proximo esta localizado no bioma dos insetos gigantes; em seguida voce deve acender o farol na ilha dos silencers e, por ultimo, o farol ao sul das Terras Frias.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 7 then
                        npcHandler:say("Excelente! Muito obrigado pela sua ajuda. Aqui esta uma quantidade de experiencia de acordo com a velocidade com a qual voce terminou sua missao.", npc, creature)
                        player:addExperience(exp)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 0)
                        player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time())
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 10 then
                        npcHandler:say("Feche a ostra magica que esta soltando seus gases toxicos nas profundezas da area dos Deeplings.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 11 then
                        npcHandler:say("Muito bem! Voce fez um excelente trabalho. Te concedo uma quantia de experiencia de acordo com sua agilidade na missao.", npc, creature)
                        player:addExperience(exp)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 0)
                        player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time())
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 20 then
                        npcHandler:say("Quebre a estatua dos dwarves nas profundezas dos exilados. Va logo! Voce nao tem muito tempo.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 21 then
                        npcHandler:say("Incrivel! Voce foi muito bem. Aqui sua recompensa, uma quantidade de experiencia proporvional ao tempo que voce levou.", npc, creature)
                        player:addExperience(exp)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 0)
                        player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time())
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 30 then
                        npcHandler:say("Ligue os dois receptores de magia localizados entre os Infernalists e retorne ate mim.", npc, creature)
                        npcHandler:setTopic(playerId, 0)
                    elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao) == 31 then
                        npcHandler:say("Voce foi muito bem. Aqui esta sua experiencia de acordo com o tempo que voce levou para finalizar a missao.", npc, creature)
                        player:addExperience(exp)
                        player:setStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.Missao, 0)
                        player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerQuest, os.time())
                        npcHandler:setTopic(playerId, 0)
                    end
                else
                    npcHandler:say("Aguarde por mais " ..timeLeft.. " minuto(s) para pegar sua proxima missao.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                end
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Gostaria de realizar uma {missao} em troca de um pouco de experiencia?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
