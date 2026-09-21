local internalNpcName = "Panthos"
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
	lookBody = 114,
	lookLegs = 94,
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

        if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Panthos) < 1 then
            if knight or monk then
                if player:getLevel() < 60 then
                    npcHandler:say("Voce esta muito fraco, jovem guerreiro... Retorne quando possuir nivel 60 ou superior.", npc, creature)
                    npcHandler:setTopic(playerId, 0)
                else
                    npcHandler:say("Eu sou Panthos, o maior guerreiro que ja pisou em Viridia! Sou colecionador de armas e posso te fornecer uma nova arma se me ajudar com uma missao. \z
                    Nao ha segredo: sua missao sera obter alguns materiais que eu nao tenho paciencia para conseguir. Se me entregar todos os materiais, te darei a sua nova arma. \z
                    O que acha da proposta? Esta preparado para a missao?", npc, creature)
                    npcHandler:setTopic(playerId, 1)
                end
            elseif paladin then
                npcHandler:say("Ha! Um paladin? Sinto muito, mas nao converso com quem nao tem a coragem necessaria para eliminar um inimigo olhando em seus olhos.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Magos... como alguem consegue dormir a noite sabendo que dedica sua vida a coisas tao misteriosas? Nao tenho assuntos a tratar com magos, va embora!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif player:getStorageValue(Storage.Quest.Crandoria.Viridia.Panthos) == 1 then
            npcHandler:say("Como eu te disse, preciso de 10 minotaur leather, 3 red pieces of cloth, 5 green dragon scales, 5 vampire teeth, 3 yellow pieces of cloth e 1 spider silk. Voce trouxe todos os itens necessarios?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        else
            npcHandler:say("Voce ja fez o suficiente. Nao tenho mais missoes para voce no momento.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "blessed sceptre") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                player:removeItem(5878, 10)
                player:removeItem(5911, 3)
                player:removeItem(5920, 5)
                player:removeItem(9685, 5)
                player:removeItem(5914, 3)
                player:removeItem(5879, 1)
                player:addItem(7429, 1)
                npcHandler:say("Otimo! Essa foi uma troca justa. Aqui esta sua nova arma, faca bom proveito.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Panthos, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "royal axe") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                player:removeItem(5878, 10)
                player:removeItem(5911, 3)
                player:removeItem(5920, 5)
                player:removeItem(9685, 5)
                player:removeItem(5914, 3)
                player:removeItem(5879, 1)
                player:addItem(7434, 1)
                npcHandler:say("Otimo! Essa foi uma troca justa. Aqui esta sua nova arma, faca bom proveito.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Panthos, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "the justice seeker") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                player:removeItem(5878, 10)
                player:removeItem(5911, 3)
                player:removeItem(5920, 5)
                player:removeItem(9685, 5)
                player:removeItem(5914, 3)
                player:removeItem(5879, 1)
                player:addItem(7390, 1)
                npcHandler:say("Otimo! Essa foi uma troca justa. Aqui esta sua nova arma, faca bom proveito.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Panthos, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "sai") then
        if npcHandler:getTopic(playerId) == 3 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                player:removeItem(5878, 10)
                player:removeItem(5911, 3)
                player:removeItem(5920, 5)
                player:removeItem(9685, 5)
                player:removeItem(5914, 3)
                player:removeItem(5879, 1)
                player:addItem(50183, 1)
                npcHandler:say("Otimo! Essa foi uma troca justa. Aqui esta sua nova arma, faca bom proveito.", npc, creature)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Panthos, 2)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Muito bem... Aqui esta a lista de materiais que preciso: 10 minotaur leather, 3 red pieces of cloth, 5 green dragon scales, 5 vampire teeth, 3 yellow pieces of cloth e 1 spider silk. \z
            Traga todos os itens e te concederei uma nova {arma} a sua escolha. Estarei esperando aqui, por favor nao demore!", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.Viridia.Panthos, 1)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:getItemCount(5878) >= 10 and player:getItemCount(5911) >= 3 and player:getItemCount(5920) >= 5 and player:getItemCount(9685) >= 5 and player:getItemCount(5914) >= 3 and player:getItemCount(5879) >= 1 then
                npcHandler:say("Excelente! Voce podera escolher uma entre quatro opcoes de armas: {blessed sceptre}, {royal axe}, {the justice seeker} ou {sai} (monks). Qual delas voce deseja?", npc, creature)
                npcHandler:setTopic(playerId, 3)
            else
                npcHandler:say("Voce nao parece estar com todos os itens... Retorne quando tiver tudo consigo.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "O que faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
