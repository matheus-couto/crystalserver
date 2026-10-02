local internalNpcName = "Frigard"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
	lookHead = 74,
	lookBody = 114,
	lookLegs = 114,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "task") then

        local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.QuestTimers.Frigard)
        local time = math.max(0, player:getStorageValue(Storage.Quest.Crandoria.QuestTimers.Frigard) - os.time())
        local minutes = math.floor(time / 60)


        if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Timer) <= os.time() then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 1 then
                npcHandler:say("Descendo as escadas ao lado voce entrara no caminho de sangue. Esse caminho leva a um covil de criaturas terriveis e sanguinarias, possibilitando aos guerreiros de Crandoria derrota-las e controlar sua multiplicacao pelo Novo Continente. \z
                O problema maior do local esta na iluminacao. O lugar deve ser um dos mais escuros que existe. Minha missao diaria sempre foi descer as escadas e puxar algumas alavancas que acionam as luzes do local. Mas agora estou velho e quase nao enxergo \z
                mais. Vendo alguem jovem como voce me faz pensar que esse srevico pode ser ideal para seu perfil. Obviamente se voce o fizer, poderei te oferecer uma recompensa valiosa. O que voce acha? Tem interesse nessa missao?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) >= 1 and player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers) < 11 then
                npcHandler:say("Voce ainda nao ativou todas as alavancas. Por favor, ative todas as dez alavancas na ordem correta e retorne ate mim e eu te recompensarei.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Estao todas acesas? Perfeito! Muito obrigado pela sua ajuda, eu nao me esquecerei disso. Aqui esta, algum dinheiro e uma boa quantidade de experiencia como recompensa.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 0)
                player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Timer, os.time() + 24 * 60 * 59 )
                local experienceReward = (player:getLevel() * 5000)
                player:addExperience(experienceReward)
                player:sendTextMessage(MESSAGE_EXPERIENCE, "You gained " .. experienceReward .. " experience points.")
                player:addItem(14112, 1)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                npcHandler:setTopic(playerId, 0)
                if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 160 then
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 161)
                end
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Timer) > os.time() then
            if player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) < 1 then
                npcHandler:say("Posso te oferecer uma nova tarefa, mas sera muito mais desafiadora que a primeira... Voce esta preparado?", npc, creature)
                npcHandler:setTopic(playerId, 2)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) == 2 then
                npcHandler:say("Muito bom, vejo que conseguiu destruir uma das flores de sangue. Posso sentir a forca dos demonios infernais diminuindo. Sobre a sua recompensa... \z
                Tenho varias coisas no meu bau, aqui ao lado. Abra-o e peque o primeiro item que voce enxergar. Sera todo seu. ", npc, creature)
                if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 161 then
                    player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 162)
                end
                player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask, 3)
                local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
                player:addExperience(1500000 + (time * player:getLevel() * 350))
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) == 1 then
                npcHandler:say("Ainda nao destruiu a flor? Essa poder ser uma missao dificil, mas caso consiga, retorne ate mim e te recompensarei!.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            elseif player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask) == 3 then
                npcHandler:say("Pegue a recompensa da sua ultima missao no meu bau. Depois conversamos sobre outras missoes.", npc, creature)
                npcHandler:setTopic(playerId, 0) 
            end
        else
            npcHandler:say("Voce me ajudou ha pouco tempo. Preciso executar minhas tarefas apenas uma vez a cada 24 horas. Volte depois e talvez possamos conversar.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Voce parecia mesmo uma pessoa generosa. Eu estava certo em te pedir ajuda. Preste atencao, no total sao 10 alavancas que voce devera acionar. Cada uma delas vai ativar uma fonte de luz para aquele local. \z
            Mas preste atencao! As alavancas devem ser utilizadas na ordem correta, seguindo um sentido anti horario. Como minha memoria ja nao e a mesma, ha placas ao lado de cada uma das alavancas identificando sua ordem. Basta segui-las. \z
            Volte quando tiver ativado todas as alavancas!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.Levers, 1)
            player:getStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask, 0)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Otimo. Me escute bem. Passando pelo caminho de sangue voce chegara a escadas de pedra. Descendo essas escadas voce vai se deparar com monstros terriveis e demonios infernais. No fundo do lugar ha uma fissura no solo \z
            onde costumam brotar flores de sangue. Essas maltiras flores dao forcas para os demonios, por isso preciso que voce pegue este veneno e jogue sobre qualquer flor que voce encontrar. Destrua pelo menos uma delas e volte ate mim e te recompensarei! \z
            Aqui, use esse veneno que preparo especialmente contra essas flores. Basta jogar sobre elas e estara feito. Se completar a missao em menos de 30 minutos te darei um bonus de experiencia!", npc, creature)
            player:addItem(11364, 1)
            player:setStorageValue(Storage.Quest.Crandoria.BloodPassageQuest.SecondTask, 1)
            player:setStorageValue(Storage.Quest.Crandoria.QuestTimers.Frigard, os.time() + 30 * 60)
            npcHandler:setTopic(playerId, 0)
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Entao o que voce esta fazendo aqui? Nao desperdice meu tempo e va procurar a Dwarven Armor!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. Voce parece jovem e forte o suficiente para ajudar um velho em uma {missao}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
