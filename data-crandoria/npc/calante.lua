local internalNpcName = "Calante"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 137,
	lookHead = 115,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 3
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

local function creatureSayCallback(npc, creature, type, message)
    local player = Player(creature)
    local playerId = player:getId()

    if not npcHandler:checkInteraction(npc, creature) then
        return false
    end

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
        if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 67 then
            npcHandler:say("Ah, |PLAYERNAME|! Estive te esperando. Que bom que voce apareceu! Acho que voce sabe que estamos todos com poucas colheitas ultimamente. Eu gostaria de algumas dragonfruits para meu estoque. \z
			Voce pode colhe-las em sua propria fazenda ou obte-las na fazenda comunitaria ao norte da cidade, mas as chances serao pequenas por la... Enfim.. Dragonfruits! Que tal me trazer 5 delas? Poderia me ajudar com isso?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 68 then
			if player:removeItem(11682, 5) then
				player:addItem(11587, 2, true)
				player:addItem(22724, 15, true)
				player:addExperience(5000000, true)
				npcHandler:say("Voce conseguiu!!! Eu sabia! Comandante Crassus so envia os melhores dos melhores para nos ajudar. Aqui esta uma recompensa que com certeza te ajudara muito em algum momento da sua jornada. Ao norte da cidade voce encontrara Christine, a dona da padaria. \z
				Ela precisa da sua ajuda. Procure por ela!", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 69)
			else
				npcHandler:say("Por favor, traga as 5 dragonfruits para mim! Preciso muito delas em meu estoque.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Que otimo! Fico muito feliz que possa ajudar. Estarei esperando ansiosa pelas dragonfruits!", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 68)
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.CountGondariel, 0)
			npcHandler:setTopic(playerId, 0)
		end
    elseif (MsgContains(message, "no") or MsgContains(message, "nao")) and npcHandler:getTopic(playerId) == 1 then
        npcHandler:say("Tudo bem, sem problemas.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    end
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcConfig.currency = 22724

npcConfig.shop = {
	{ name = "tropical marinated tiger", clientId = 29410, buy = 6},
	{ name = "delicatessen salad", clientId = 29411, buy = 6},
	{ name = "carrot pie", clientId = 29409, buy = 6},
	{ name = "veggie casserole", clientId = 9084, buy = 6},
	{ name = "chilli con carniphila", clientId = 29412, buy = 4},
	{ name = "consecrated beef", clientId = 29415, buy = 5},
	{ name = "carrion casserole", clientId = 29414, buy = 3},
	{ name = "svargrond salmon filet", clientId = 29413, buy = 10},
	{ name = "worker shirt", clientId = 32099, buy = 100},
	{ name = "worker legs", clientId = 32097, buy = 100},
	{ name = "worker shoes", clientId = 9017, buy = 100},
	{ name = "worker hat", clientId = 11700, buy = 100},
}


npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante. Diga-me se quiser fazer uma {troca} de algumas das suas Astralis Coins.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser negociar.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

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

npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)