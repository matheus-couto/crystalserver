local internalNpcName = "Hindrael"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2
npcConfig.walkRadius = 4

npcConfig.outfit = {
	lookType = 159,
	lookHead = 22,
	lookBody = 49,
	lookLegs = 109,
	lookFeet = 76,
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso)

    if MsgContains(message, "segredo") or MsgContains(message, "missao") or MsgContains(message, "mission") then
        if storage == 1 then
            npcHandler:say("Quando os elfos iniciaram a exploracao do Novo Continente, tres pontos seguros foram marcados com magia em diferentes regioes. \z
            O objetivo disso era fornecer uma passagem segura para locais perigosos, ja que preferimos sempre evitar conflitos desnecessarios. \z
            As passagens sao feitas por meio de tres teleports so de ida, saindo de Elvenshire, direto para o local. Gostaria de aprender como utilizar os teleports?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif storage == 2 then
            npcHandler:say("Entregue as runas para Howard Rootberg, por favor.", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif storage == 3 then
            npcHandler:say("Tudo entregue? Perfeito! Howard dedica sua vida a uma causa nobre defendendo Astralis e estudando as criaturas da regiao. A ajuda foi merecida. \z
            Sobre os teleports, aqui esta! (Flshh!!) Agora voce possui a permissao necessaria para utilizar os teleports. As plataformas para utiliza-los esta no norte da cidade. \z
            Mas preste atencao: Os teleports te levarao para locais perigosos e serao so de ida! Tenha isso em mente e boa sorte!", npc, creature)
            player:addExperience(250000)
            player:setStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso, 4)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "vinho") or MsgContains(message, "wine") then
        if storage < 1 then
            npcHandler:say("O que? Que vinho? Quem te falou sobre o vinho? Ehr... Digo... Do que voce esta falando? Voce... por acaso... Tem vinho de Astralis?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            if player:getItemCount(27461) >= 1 then
                player:removeItem(27461, 1)
                npcHandler:say("Que maravilha! Ca entre nos, nao sei se voce notou mas eu sou um amante de vinhos... E o vinho produzido em Astralis sempre foi o melhor! \z
                Escute... sei que nao nos conhecemos, mas fale comigo se quiser aprender um {segredo} de Elvenshire.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso, 1)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Eu nao vejo nenhum vinho de Astralis.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getFreeBackpackSlots() >= 1 and player:getFreeCapacity() >= 200 then
                npcHandler:say("Os locais marcados foram: a entrada do Depot de Roshamuul, o topo da montanha de Frost Dragons, nas Ice Lands e a entrada de uma das cavernas de Hydras na selva de Jagunda.\z
                Para utilizar os teleports voce precisa receber um encantamento que, nao por coincidencia, apenas eu sei como fazer. Se quiser recebe-lo, tera que me dar uma ajuda muito simples:\z
                Tome esta sacola. Voce deve entregar tudo a Howard Rootberg. Ele vive em sua cabana nas montanhas a noroeste de Astralis. Diga 'runas' e ele sabera do que se trata.", npc, creature)
                local container = player:addItem(2853, 1)
                if container then
                    container:addItem(3161, 25)
                    container:addItem(3202, 25)
                    container:addItem(3191, 25)
                end
                player:setStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce precisara de pelo menos um espaco na mochila e 200 de cap para essa {missao}.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "nao") or MsgContains(message, "no")) then
        npcHandler:say("Tudo bem...", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola, aventureiro. O que faz na cidade dos elfos?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
