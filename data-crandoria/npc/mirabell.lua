local internalNpcName = "Mirabell"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 96,
	lookBody = 12,
	lookLegs = 87,
	lookFeet = 77,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'The Horn of Plenty is always open for tired adventurers.'}
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


	if MsgContains(message, 'pies') or MsgContains(message, 'torta') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBuying) == -1 then
			npcHandler:say('Ah, entao voce ouviu sobre minhas tortas excelentes! Infelizmente estou sem farinha (flour). Traga-me duas porcoes de farinha e eu farei as tortas para voce.', npc, creature)
			return true
		end
		npcHandler:say('Por 12 tortas serao 240 gold coins. Vai querer comprar?', npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, 'flour') then
		npcHandler:say('Voce trouxe a farinha (flour) necessaria para fazer as tortas?', npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "ginger floyd") then
		if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) == 2 then
			npcHandler:say('Tem certeza que quer encontrar aquele nomade sem graca? He he he... Sim ele passou por aqui ha alguns dias. Mas nao sei para onde foi. \z
			Ele estava com arranhoes de lutas que teve contra as criaturas da selva de Jagunda. Acredito que, independente de onde tenha ido, nao deve ter passado pela selva.', npc, creature)
			npcHandler:setTopic(playerId, 1)
			player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso, 3)
		end
	elseif MsgContains(message, 'yes') then
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeItem(3603, 24) then
				npcHandler:say('Voce deve ter confundido a poeira nos seus bolsos com farinha (flour). Voce certamente nao possui farinha suficiente para 12 tortas.', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBuying, player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBuying) + 1)
			npcHandler:say('Excelente! Agora posso fazer as tortas. Farei um bom preco por elas para voce.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if not player:removeMoneyBank(240) then
				npcHandler:say('Voce nao possui dinheiro o suficiente...', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:addItem(119, 1)
			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBuying, player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBuying) - 1)
			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.PieBoxTimer, os.time() + 1200) -- 20 minutes to deliver
			npcHandler:say({
				'Aqui estao. Espere! Algo que voce precisa saber: Elas nao vao durar muito ao sol, entao e melhor leva-las ao destino o mais rapido possível...',
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, 'no') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say('Sem farinha nao posso fazer nada. Sinto muito.', npc, creature)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say('Que tipo de bobo voce e?', npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end

	return true
end

keywordHandler:addKeyword({'drink'}, StdModule.say, {npcHandler = npcHandler, text = 'I can offer you beer, wine, lemonade and water. If you\'d like to see my offers, ask me for a {trade}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you looking for food? I have bread, cheese, ham, and meat. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the Horn of Plenty, |PLAYERNAME|. Sit down, have a {drink} or some {food}! Or maybe you came here for one of my famous {pies}, is that it?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Come back soon, traveller.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon, traveller.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look at my tasty offers.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 4 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "mug of beer", clientId = 2880, buy = 2, count = 3 },
	{ itemName = "mug of lemonade", clientId = 2880, buy = 2, count = 12 },
	{ itemName = "mug of water", clientId = 2880, buy = 1, count = 1 },
	{ itemName = "mug of wine", clientId = 2880, buy = 3, count = 2 }
}
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

npcType:addDialogOptions("bye")

npcType:register(npcConfig)
