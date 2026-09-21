-- ATUALIZAR --
local internalNpcName = "The Former Queen"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 331
}

npcConfig.flags = {
	floorchange = false
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

local TRADE_STORAGE = Storage.Quest.Crandoria.TradeSpecialNPC.Trade
local TRADE_COOLDOWN_HOURS = 168

local function isTradeCooldownOver(player)
    local lastTradeTime = player:getStorageValue(TRADE_STORAGE)
    if lastTradeTime == -1 then
        return true -- O jogador nunca fez a troca antes, então está livre para a primeira troca.
    end

    local currentTime = os.time()
    local timeSinceLastTrade = currentTime - lastTradeTime
    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
        return timeSinceLastTrade >= TRADE_COOLDOWN_HOURS * 3600
    else
        return timeSinceLastTrade >= TRADE_COOLDOWN_HOURS * 3600 * 1.42
    end
end

local function performTrade(player)
    if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
        player:addTibiaCoins(25)
        player:addExperience(-((500000 * player:getLevel()) + ((player:getLevel() - 1000) * 8500000)))
        player:setStorageValue(TRADE_STORAGE, os.time())
    else
        player:addTibiaCoins(25)
        player:addExperience(-((500000 * player:getLevel()) + ((player:getLevel() - 1000) * 8500000)))
        player:setStorageValue(TRADE_STORAGE, os.time())
    end
end

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

	if MsgContains(message, 'experiencia') and npcHandler:getTopic(playerId) == 0 then
        if player:getLevel() < 1000 then
            npcHandler:say('Desculpe, mas voce nao possui nivel suficiente para me fornecer experiencia suficiente sobre suas aventuras. Volte quando tiver nivel 1000.', npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif not isTradeCooldownOver(player) then
            if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Citizen) < 1 then
                npcHandler:say('Desculpe, mas voce me forneceu boas experiencias de batalha recentemente. Voce deve esperar 7 dias apos cada visita ao meu castelo para que possamos negociar novamente.', npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say('Desculpe, mas voce me forneceu boas experiencias de batalha recentemente. Voce deve esperar 10 dias apos cada visita ao meu castelo para que possamos negociar novamente.', npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        else
            npcHandler:say('Tem certeza que deseja trocar parte da sua experiencia por 10 Tibia Coins?', npc, creature)
            npcHandler:setTopic(playerId, 1)
        end
    elseif (MsgContains(message, 'yes') or MsgContains(message, 'sim')) and npcHandler:getTopic(playerId) == 1 then
        performTrade(player)
        npcHandler:say('Que experiencia de batalha maravilhosa! Aqui esta suas moedas. Volte quando tiver mais experiencia que valha a pena o meu dinheiro.', npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
    return true
end

keywordHandler:addKeyword({'missao'}, StdModule.say, {npcHandler = npcHandler, text = "I have no mission to give you today, but I can offer you an fair trade if you have enough {experience}."})
keywordHandler:addKeyword({'troca'}, StdModule.say, {npcHandler = npcHandler, text = "Como sou uma rainha aposentada e extremamente rica, eu nao busco por ouro e riquezas, mas sim por experiencia de batalha. Se voce tiver a {experiencia} que eu busco posso te oferecer 10 Tibia Coins em troca..."})


npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|! Gostaria de fazer uma {troca} especial hoje?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
