local internalNpcName = "Smuggler Rose"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 155,
	lookHead = 89,
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
    local money = player:getMoney() + player:getBankBalance()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "fugir") then
        if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.House) ~= 1 then
            if player:getLevel() < 300 then
                npcHandler:say("Olha so pra voce! Voce parece nao saber nem porque veio parar aqui. Nao se preocupe, para novatos como voce eu faco um preco especial. Te ajudo a fugir daqui por 1.000.000 gold coins. Negocio fechado?", npc, creature)
                npcHandler:setTopic(playerId, 1)
            elseif player:getLevel() >= 300 and player:getLevel() < 500 then
                npcHandler:say("Voce parece uma pessoa quase importante. Talvez alguem perceba sua falta aqui dentro e isso acaba sendo um risco para mim. Para te tirar daqui eu vou querer 2.000.000 gold coins. Fechado?", npc, creature)
                npcHandler:setTopic(playerId, 2)
            elseif player:getLevel() >= 500 and player:getLevel() < 800 then
                npcHandler:say("Pela sua experiencia imagino que muitos gostaram de te ver atras das grades. Para correr o risco de te tirar daqui voce tera que pagar 5.000.000 gold coins. Parece justo para voce?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            elseif player:getLevel() >= 800 then
                npcHandler:say("Voce parece experiente ate demais para ter vindo parar aqui. Colocar meu nome em risco para te tirar daqui nao sera nada facil, mas posso dar um jeito em troca de 1.000 Tibia Coins. Temos um acordo?", npc, creature)
                npcHandler:setTopic(playerId, 4)
            end
        else
            npcHandler:say("Ei, eu conheco voce! Voce mora em uma daquelas cabanas amaldicoadas... Piratas nao sao grandes sabios, mas somos espertos o suficiente para nao fazer negocio com esse tipo de alma perdida. Sinto muito, mas nao posso te ajduar.", npc, creature)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if money >= 1000000 then
                npcHandler:say("Rapido! Nao temos tempo a perder! Te deixarei na praia dos piratas, onde consigo navegar com seguranca.", npc, creature)
                player:removeMoney(1000000)
                player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time())
                player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
                    player:teleportTo(Position(4580, 5451, 7))
                else
                    player:teleportTo(Position(5062, 5206, 7))
                end
            else
                npcHandler:say("Voce nao tem dinheiro? Entao nos nao temos mais nada sobre o que conversar!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
        if npcHandler:getTopic(playerId) == 2 then
            if money >= 2000000 then
                npcHandler:say("Otimo. Agora cubra o rosto e me siga! Voce ficara na praia dos piratas.", npc, creature)
                player:removeMoney(2000000)
                player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time())
                player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
                    player:teleportTo(Position(4580, 5451, 7))
                else
                    player:teleportTo(Position(5062, 5206, 7))
                end
            else
                npcHandler:say("Voce nao tem dinheiro? Entao nos nao temos mais nada sobre o que conversar!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
        if npcHandler:getTopic(playerId) == 3 then
            if money >= 5000000 then
                npcHandler:say("Vamos depressa! Te deixarei na praia dos piradas e de la voce ira se virar. Tenha cuidado!", npc, creature)
                player:removeMoney(5000000)
                player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time())
                player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
                    player:teleportTo(Position(4580, 5451, 7))
                else
                    player:teleportTo(Position(5062, 5206, 7))
                end
            else
                npcHandler:say("Voce nao tem dinheiro? Entao nos nao temos mais nada sobre o que conversar!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
        if npcHandler:getTopic(playerId) == 4 then
            if player:getTransferableCoins() >= 1000 then
                npcHandler:say("Otimo, agora venha logo! Te transportar vai ser algo arriscado. Vou te deixar na praia dos piratas.", npc, creature)
                player:removeTransferableCoins(1000)
                player:setStorageValue(Storage.Quest.Crandoria.Prison.Timer, os.time())
                player:setStorageValue(Storage.Quest.Crandoria.Prison.QuestionIndex, 0)
                if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) >= 1 then
                    player:teleportTo(Position(4580, 5451, 7))
                else
                    player:teleportTo(Position(5062, 5206, 7))
                end
            else
                npcHandler:say("Voce nao tem dinheiro? Entao nos nao temos mais nada sobre o que conversar!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "no") or MsgContains(message, "nao") then
        npcHandler:say("Aproveite o tempo na prisao!", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Voce tem suas escolhas, camarada... Ficar preso como um animal nao parece o que voce deseja. Me diga se preferir {fugir} daqui.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais. Me avise se mudar de ideia.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Boa sorte.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
