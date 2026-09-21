local internalNpcName = "Tennessee"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 128,
	lookHead = 33,
	lookBody = 57,
	lookLegs = 51,
	lookFeet = 115,
	lookAddons = 0
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

npcConfig.shop = {
	{ itemName = "lock pick", clientId = 7889, buy = 3000, count = 1 },
}

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
        if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 2 then
            npcHandler:say("Hidrox? Foi ele quem te mandou? Entendo... Entao ele foi pego e agora voce precisa de um lock pick para ajuda-lo... Eu posso te entregar um pelo modesto valor de 1.000 gps. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 1)
        elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 3 then
            npcHandler:say("O que esta esperando? Leve o lock pick e ajude Hidrox a fugir!.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 5 then
            npcHandler:say("Outro lock pick? Claro, claro... Mas este vai te custar 3.000 gps. Voce aceita?", npc, creature)
            npcHandler:setTopic(playerId, 2)
        end
    elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
        if npcHandler:getTopic(playerId) == 1 then
            if player:removeMoneyBank(1000) then
                npcHandler:say("Aqui esta seu lock pick. Por favor, ajude-o a escapar!", npc, creature)
                player:addItem(7889, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 3)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Esta tentando me enganar? Onde esta o dinheiro? E depois dizem que eu sou o criminoso...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif npcHandler:getTopic(playerId) == 2 then
            if player:removeMoneyBank(3000) then
                npcHandler:say("Aqui esta seu lock pick. Por favor, ajude-o a escapar! Se precisar de mais alguns pode me procurar, mas lembre-se do preco!", npc, creature)
                player:addItem(7889, 1, true)
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 6)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Esta tentando me enganar? Onde esta o dinheiro? E depois dizem que eu sou o criminoso...", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("Entao va embora daqui!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


local function onTradeRequest(npc, creature)
    local player = Player(creature)
	local playerId = player:getId()
    
	if Player(creature):getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) < 6 then
		npcHandler:say('Nao vou negociar meus lockpicks com alguem em quem eu nao confio', npc, creature)
		return false
	end

	return true
end




npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

npcHandler:setMessage(MESSAGE_GREET, "O que voce faz aqui?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- npcType registering the npcConfig table
npcType:register(npcConfig)
