local internalNpcName = "Shiraks"
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
	lookHead = 84,
	lookBody = 113,
	lookLegs = 113,
	lookFeet = 35,
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

    if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "acesso") then
        if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) < 2 then
            npcHandler:say("Nao tenho nenhuma missao para um humano qualquer. Por favor, saia de nossa ilha!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 2 then
            npcHandler:say("Hum.. Visanis me contou sobre voce. Entao esta tentando provar seu valor para as Nagas de Baeloria? Voce nao parece alguem que consegue sobreviver por aqui... \z
            Bom, ma se Visanis confia em voce, te darei uma chance. O ultimo humano que tentou nos ajudar acabou dificultando nosso trabalho. Talvez voce possa provar que nem todo humano e inutil! \z
            Ha ha ha ha! Mas ja aviso que nao sera facil. Primeiramente tera que enfrentar as temiveis Ancient Hydras. Esta pronto para a missao?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 3 then
            npcHandler:say("Ainda nao encontrou o cristal? Se nao conseguir enfrentar as Ancient Hydras nao conseguira se sair muito bem em nossa ilha...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 4 then
            npcHandler:say("Se ja estiver com o cristal, leve-o ate a pequena fonte no extremo oeste das montanhas das Ancient Hydras. Use-o para ativar o poder da fonte.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 5 then
            npcHandler:say("Voce conseguiu! Realmente, Visanis estava certa em confiar no seu potencial. Talvez voce possa me ajudar com uma outra tarefa... Nao sera dificil para alguem tao forte. \z
            Abaixo das montanhas das Ancient Hydras vive uma civilizacao de Cannibal Iks. Esses terriveis guerreiros se esconderam e se tornaram cada vez mais agressivos e perigosos. \z
            Na sua proxima missao voce tera que entrar no local e encontrar um item importante. Esta pronto para o desafio?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 6 then
            npcHandler:say("Voce conseguiu o Galho Santo?", npc, creature)
            npcHandler:setTopic(playerId, 3)
        elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 7 then
            npcHandler:say("Sua proxima missao sera com a Comandante Sivyna. Ela esta a sua espera no forte. Passe pelo portao ao lado e atravesse a ponte para acessar o local.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 8)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Entao preste atencao: um humano chamado Ghuror tentou se aliar a nos e estava executando uma importante missao quando desapareceu. Ele carregava nosso Cristal de Luz. \z
            Este artefato serve como um transmissor de energia, que capta energia da terra e redireciona para a nossa Rainha. Sua missao sera simples: Voce deve encontrar Ghuror, ou o que restou dele. \z
            Ele saiu pelo portao leste. Obtenha o cristal, tire-o de Ghuror se for preciso. Em seguida leve o cristal para a fonte localizada a oeste das montanhas das Ancient Hydras. Boa sorte!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 3)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            npcHandler:say("Otimo! Precisamos que voce obtenha um Galho Santo. Esse galho magico pode queimar infinitamente, sendo fonte de luz e calor para qualquer um que o possuir. \z
            Com esse galho, nao precisaremos mais buscar por fontes de calor de madeira e carvao de Astralis. De acordo com nossas informacoes, um Iks poderoso detem o item. \z
            Tenha cuidado no caminho e so retorne quando conseguir o item! Boa sorte.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 6)
            player:addExperience(player:getLevel() * 10000)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(39137) >= 1 then
                player:removeItem(39137, 1)
                npcHandler:say("Incrivel! A chama ate parece estar viva! Estou impressionado. Talvez voce esteja preparado para uma nova {missao}... Me avise quando se sentir preparado. \z
                Por enquanto, aproveite essa recompensa. ", npc, creature)
                player:addExperience(player:getLevel() * 10000)
                player:addItem(26186, 2)
                player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 7)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Esta tentando me enganar? Volte quando tiver o item em maos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end

end


npcHandler:setMessage(MESSAGE_GREET, "O que faz aqui, humano?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)


npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
