local internalNpcName = "Jack the Rabbit"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 262,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
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

    if MsgContains(message, "boneca") or MsgContains(message, "doll") or MsgContains(message, "mission") or MsgContains(message, "missao") then 
        if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho) == 1 then
            npcHandler:say({"Entao voce busca pela boneca daquela menina... Eu peguei a boneca numa tentativa de subornar a Rainha de Copas com algum objeto do mundo externo. Ela sempre foi fascinada por essas coisas. ...",
            "Estou tentando de tudo para reconquistar Thaumasia para seus habitantes, mas a Rainha parece nao estar interessada em ceder de forma alguma. Enquanto nao conseguimos reconquistar nossas terras, tenho tentado recuperar pelo menos um pouco da nossa dignidade. ...",
            "Eu soube da sua vitoria sobre ela, recenemente. Apesar de momentanea ja traz um bom alivio para todos. Como recompensa, te darei a boneca e te deixarei escolher um entre dois itens: Posso te oferecer uma {receita} de transmutacao ou uma {luminescent heart potion}. O que voce prefere?"}, npc, creature)
            npcHandler:setTopic(playerId, 1)
    elseif MsgContains(message, "receita") then
        if npcHandler:getTopic(playerId) == 1 then
            player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho, 2)
            player:addItem(25981, 1, true)
            player:addItem(24873, 1, true)
            player:addExperience(player:getLevel() * 10000, true)
            npcHandler:say({"Aqui esta, como prometido. A boneca e sua receita. Nao temos mais magos em Thaumasia, entao essa receita ja nao sera mais util para nos. Mas tenho certeza que voce encontrara boa utilidade para ela! ...",
            "Alem disso, lembre-se que estou buscando por tudo que nos foi roubado. Entao eu comprarei diversos itens voce possa vir a obter desses terriveis monstros. Basta vir ate mim e dizer {trade}."}, npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    elseif MsgContains(message, "luminescent heart potion") then
            player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho, 2)
            player:addItem(33892, 1, true)
            player:addItem(25981, 1, true)
            player:addExperience(player:getLevel() * 10000, true)
            npcHandler:say("Aqui esta, como prometido. A boneca e a luminescent heart potion. Boa sorte e sinta-se livre para visitar Thaumasia sempre que quiser!", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho) == 2 then
            npcHandler:say("Voce nos ajudou muito. Agora pode andar livremente por Thaumasia e desafiar os terriveis monstros que vivem em nossas terras.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end

local function onTradeRequest(npc, creature)
	if Player(creature):getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Coelho) < 2 then
		npcHandler:say('Que tal conseguir a {boneca} daquela menina de volta antes de pensar em fazer negocios?', npc, creature)
		return false
	end

	return true
end

npcConfig.shop = {
	{ itemName = "transmutation recipe", clientId = 24873, sell = 100000000 },
}

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. O que faz por essas terras?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
