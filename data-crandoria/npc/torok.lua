local internalNpcName = "Torok"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 0,
	lookBody = 108,
	lookLegs = 37,
	lookFeet = 11,
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

    if MsgContains(message, "javali") or MsgContains(message, "boar") or MsgContains(message, "mount") or MsgContains(message, "montaria") then
        if player:getLevel() >= 600 then
            npcHandler:say({'Os meus javalis sao rapidos, MUITO rapidos... Crio javalis desde a epoca em abandonei Kazordoon para me tornar fazendeiro. Esses animais sao tudo para mim, jovem viajante. ...',
            'Cof, cof... Bom, nos ultimos anos desenvolvi uma forma de adestra-los para que eles nos deixem montar-los. Para isso eu sempre utilizei um chifre de cacador que, se assoprado da maneira certa mantem as bestas calmas e doceis. Esses animais sao as melhores montarias que voce poderia desejar. ...',
            'Sao pequenos e velozes, passam por qualquer lugar! Mas eles so aceitam ser montados pela propria pessoa que o domou. Voce aceita o desafio?'}, npc, creature)
            npcHandler:setTopic(playerId, 1)
        else
            npcHandler:say("O que e isso? O que uma pessoa tao jovem e inexperiente esta fazendo aqui? Saia da minha casa, crianca. Volte quando tiver pelo menos nivel 600, voce ainda nao esta aos pes dos meus javalis!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Confesso que voce tem coragem! Ha ha ha ha ha... Tudo bem, jovem. Vou permitir que voce tente domar um de meus javalis, mas para isso voce precisa fazer uma contribuicao de, digamos... 3.000.000 de moedas de ouro. \z
            Esse valor servira para cobrir o custo da producao do meu chifre de cacador especial e, obviamente, te darei um para que voce possa usa-lo para domar uma das criaturas. O que voce acha, jovem? Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getMoney() >= 3000000 then
                player:removeMoneyBank(3000000)
                player:addItem(12260, 1)
                npcHandler:say("Otimo! Aqui esta, fique a vontade para entrar em meu estabulo e tentar domar um dos javalis. Mas tome cuidado! Suas chances serao doma-lo ou enfurece-lo a ponto dele quebrar seu item! Ha ha ha ha...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Esta tentando me passar para tras? Volte quando tiver o dinheiro e quiser fazer negocios!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "nao") or MsgContains(message, "no") then
        if npcHandler:getTopic(playerId) ~= 0 then
            npcHandler:say("Entao nao me faca perder tempo!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que voce esta fazendo aqui? Saia da minha ilha a nao ser que esteja interessado em um {javali}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Claro, claro... Adeus!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "E nao volte mais!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("javali", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
