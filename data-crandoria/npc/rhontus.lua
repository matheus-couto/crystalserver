local internalNpcName = "Rhontus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 114,
	lookFeet = 26,
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

    local timeLeft = math.floor((player:getStorageValue(Storage.Quest.Crandoria.Viridia.Zidrael.TimerGeral) - os.time()) / 60)

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
        local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
        local monk = player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK
        local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
        local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus) < 1 then
            if knight or monk then
                if player:getLevel() < 40 then 
                    npcHandler:say("Voce ainda nao tem forcas para essa missao... Retorne quando possuir nivel 40 ou superior.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Me chamo Rhontus e sou um dos primeiros guerreiros de Viridia. Sou responsavel por vigiar a cidade de cima das torres e defende-la caso seja necessario. \z
                    Estou buscando por um bravo Knight ou Guardian que possa me ajudar coletando para mim alguns itens. Em troca, como recompensa, ofereco uma nova arma de combate a curta distancia. \z
                    O que acha da proposta? Esta interessado nessa a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 1)
                end
            else
                npcHandler:say("Sinto muito, mas preciso da ajuda de um Knight ou Guardian para a minha missao.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus) == 1 then
            npcHandler:say("Como eu te disse, preciso de 5 flask of embalming fluid, 5 ape fur, 5 rope belts e 1 white piece of cloth. Voce trouxe todos os itens necessarios?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        else
            npcHandler:say("Voce ja fez o suficiente. Nao tenho mais missoes para voce no momento.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "cranial basher") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                
                player:removeItem(11466, 5)
                player:removeItem(5883, 5)
                player:removeItem(11492, 5)
                player:removeItem(5909, 1)
                player:addItem(7415, 1)
                npcHandler:say("Muito obrigado. Aqui esta sua nova arma, faca bom proveito e tenha cuidado!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "heroic axe") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(11466) >= 5 and player:getItemCount(5883) >= 5 and player:getItemCount(11492) >= 5 and player:getItemCount(5909) >= 1 then
                player:removeItem(11466, 5)
                player:removeItem(5883, 5)
                player:removeItem(11492, 5)
                player:removeItem(5909, 1)
                player:addItem(7389, 1)
                npcHandler:say("Muito obrigado. Aqui esta sua nova arma, faca bom proveito e tenha cuidado!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "mystic blade") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(11466) >= 5 and player:getItemCount(5883) >= 5 and player:getItemCount(11492) >= 5 and player:getItemCount(5909) >= 1 then
                player:removeItem(11466, 5)
                player:removeItem(5883, 5)
                player:removeItem(11492, 5)
                player:removeItem(5909, 1)
                player:addItem(7384, 1)
                npcHandler:say("Muito obrigado. Aqui esta sua nova arma, faca bom proveito e tenha cuidado!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "nunchaku") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(11466) >= 5 and player:getItemCount(5883) >= 5 and player:getItemCount(11492) >= 5 and player:getItemCount(5909) >= 1 then
                player:removeItem(11466, 5)
                player:removeItem(5883, 5)
                player:removeItem(11492, 5)
                player:removeItem(5909, 1)
                player:addItem(50182, 1)
                npcHandler:say("Muito obrigado. Aqui esta um Nunchaku. Use-o para transformar suas spears comuns em Glooth Spears!", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem... Preciso de materiais para manter as tochas da cidade acesas. Por favor, traga-me: 5 flask of embalming fluid, 5 ape fur, 5 rope belts e 1 white piece of cloth. \z
            Traga todos os itens e te concederei uma nova {arma} a sua escolha. Estarei esperando aqui, por favor nao demore!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Rhontus, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(11466) >= 5 and player:getItemCount(5883) >= 5 and player:getItemCount(11492) >= 5 and player:getItemCount(5909) >= 1 then
                npcHandler:say("Excelente! Voce podera escolher uma entre cinco opcoes: {cranial basher}, {heroic axe}, {mystic blade} ou um {nunchaku} (monks). \z
                Qual dos itens voce deseja?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Ola. O que faz em minha torre?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
