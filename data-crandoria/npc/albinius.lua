local internalNpcName = "Albinius"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 634,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 86,
	lookFeet = 60,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.shop = {
	{ itemName = "heavy old tome", clientId = 23986, sell = 30 }
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

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

local talkState = {}
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "I am Albinius, a worshipper of the {Astral Shapers}."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Precisely time."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I find ways to unveil the secrets of the stars. Judging by this question, I doubt you follow my weekly publications concerning this research."})

local runes = {
	{runeid = 24954},
	{runeid = 24955},
	{runeid = 24956},
	{runeid = 24957},
	{runeid = 24958},
	{runeid = 24959}
}


local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 5 then
			npcHandler:say("Kame te enviou? Hehehehe... Aquele velho teimoso. Eu falei que cuidaria do problema! Nao precisava enviar uma jovem alma como a sua. O que ele estava pensando? \z
			Bom, mas vejo que voce pode superar minhas expectativas, afinal de contas voce encontrou meu esconderijo dentro da prisao. Entao talvez voce tambem consiga me ajudar com meu {problema}...", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 6 then
			npcHandler:say("Obtenha pelo menos uma {pocao} e lute contra Izildor. Se conseguir derrota-lo retorne ate mim e te darei uma boa recompensa pela ajuda, jovem |PLAYERNAME|.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) == 7 then
			npcHandler:say("Ele... Desapareceu? Isso realmente parece muito estranho. Acredito que ele tenha enganado voces e utilizado algum feitico para escapar. Veremos se ele aparece novamente... \z
			De qualquer forma te agradeco muito pela ajuda. Retorne a superficie e diga a Kame que em breve estarei de volta.", npc, creature)
			player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 8)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "problem") or MsgContains(message, "problema") then
		npcHandler:say("Um dos antigos prisioneiros deste lugar esta vivendo isolado aqui. Ele se chama Izildor e ja fez parte da Sociedade dos Magos um dia, mas se corrompeu em busca de poder e foi mandado para ca com a ajuda de Zoltan, Kame e eu. \z
		Apos a prisao ser tomada por demonios e inspirado pelo conhecido Doctor Marrow, Izildor iniciou alguns experimentos para tentar se tornar um monstro por conta propria, mas tudo saiu do controle. Desci ate aqui para tentar encontrar uma forma de dete-lo. \z
		Nas minhas buscas descobri registros de uma pocao que pode neutralizar os poderes do monstro no qual Izildor esta se tornando, mas parece ser apenas temporaria. Primeiro preciso que voce me traga ingredientes para fazer a pocao. Voce aceita a missao?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "pocao") or MsgContains(message, "potion") then
		if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) >= 6 then
			npcHandler:say("Para produzir uma pocao preciso de 1 dragonfruit, 5 strange mushrooms e 3 holy orchids. Voce possui todos os itens?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, 'astral shaper rune') then
		if player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access) >= 1 then
			npcHandler:say("Entao voce ouviu falar da Astral Shaper Rune... E voce por acaso possui as 6 pecas necessarias para produzi-la?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("Sinto muito, mas so posso compartilhar informacoes sobre essa runa com os aliados da Sociedade dos Magos. Fale com Baltazar, no deserto de Valkesh, para fazer parte da sociedade.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Estupendo! Para cada pocao precisarei de 1 dragonfruit, 5 strange mushrooms e 3 holy orchids. Mas escute bem: A pocao nao tem duracao fixa, pode durar 10 minutos ou apenas 10 segundos. Por isso aconselho levar mais de uma para desafiar Izildor. \z
			Quando utilizar a pocao sobre sua forma de monstro, ele se transformara em humano novamente e nesse momento ficara vulneravel. Quando possuir todos os itens, basta retornar ate mim e me pedir por uma {pocao}.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.OldKame.Progresso, 6)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(11682) >= 1 and player:getItemCount(31982) >= 5 and player:getItemCount(5922) >= 3 then
				player:removeItem(11682, 1)
				player:removeItem(31982, 5)
				player:removeItem(5922, 3)
				player:addItem(21803, 1)
				npcHandler:say("Muito bem. Aqui esta sua pocao. Faca Izildor toma-la ou jogue sobre ele para neutralizar seus poderes por um tempo.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui todos os itens.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(24954) >= 1 and player:getItemCount(24955) >= 1 and player:getItemCount(24956) >= 1 and player:getItemCount(24957) >= 1 and player:getItemCount(24958) >= 1 and player:getItemCount(24959) >= 1 then
				npcHandler:say("Um, dois, tres... Seis! Certo, tudo aqui. Aqui esta sua Astral Shaper Rune. Utilize-a com sabedoria.", npc, creature)
				player:removeItem(24954, 1)
				player:removeItem(24955, 1)
				player:removeItem(24956, 1)
				player:removeItem(24957, 1)
				player:removeItem(24958, 1)
				player:removeItem(24959, 1)
				player:addItem(24960, 1)
				npcHandler:setTopic(playerId, 0)
			else
				pcHandler:say("Voce nao possui todos os fragmentos com voce.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Saudacoes, jovem. O que busca por aqui?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")

npcType:register(npcConfig)



-- local internalNpcName = "Albinius"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 634,
-- 	lookHead = 0,
-- 	lookBody = 19,
-- 	lookLegs = 86,
-- 	lookFeet = 60,
-- 	lookAddons = 0
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

-- npcConfig.shop = {
-- 	{ itemName = "heavy old tome", clientId = 23986, sell = 30 }
-- }
-- -- On buy npc shop message
-- npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
-- 	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
-- end
-- -- On sell npc shop message
-- npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
-- 	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
-- end
-- -- On check npc shop message (look item)
-- npcType.onCheckItem = function(npc, player, clientId, subType)
-- end

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- local talkState = {}
-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "I am Albinius, a worshipper of the {Astral Shapers}."})
-- keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Precisely time."})
-- keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I find ways to unveil the secrets of the stars. Judging by this question, I doubt you follow my weekly publications concerning this research."})

-- local runes = {
-- 	{runeid = 24954},
-- 	{runeid = 24955},
-- 	{runeid = 24956},
-- 	{runeid = 24957},
-- 	{runeid = 24958},
-- 	{runeid = 24959}
-- }

-- local function getTable()
-- 	local itemsList = {
-- 		{name = "heavy old tome", id = 23986, sell = 30}
-- 	}
-- 	return itemsList
-- end

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	-- if MsgContains(message, "shapers") then
-- 	-- 	npcHandler:say({
-- 	-- 		"The {Shapers} were an advanced civilisation, well versed in art, construction, language and exploration of our world in their time. ...",
-- 	-- 		"The foundations of this {temple} are testament to their genius and advanced understanding of complex problems. They were master craftsmen and excelled in magic."
-- 	-- 	}, npc, creature)
-- 	-- end

-- 	-- if MsgContains(message, 'temple') then
-- 	-- 	npcHandler:say({
-- 	-- 		"The temple has been restored to its former glory, yet we strife to live and praise in the {Shaper} ways. Do you still need me to take some old {tomes} from you my child?"
-- 	-- 	}, npc, creature)
-- 	-- 	npcHandler:setTopic(playerId, 1)
-- 	-- end
-- 	if MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
-- 		if (player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1) then
-- 			npcHandler:say('You already offered enough tomes for us to study and rebuild this temple. Thank you, my child.', npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		else
-- 			if (player:getItemCount(23986) >= 5) then
-- 				player:removeItem(23986, 5)
-- 				npcHandler:say('Thank you very much for your contribution, child. Your first step in the ways of the {Shapers} has been taken.', npc, creature)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes, 1)
-- 			else
-- 				npcHandler:say('You need 5 heavy old tome.', npc, creature)
-- 			end
-- 		end
-- 	elseif  MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
-- 		npcHandler:say('I understand. Return to me if you change your mind, my child.', npc, creature)
-- 		npcHandler:removeInteraction(npc, creature)
-- 	end

-- 	-- if MsgContains(message, 'tomes') and player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) < 1 then
-- 	-- 	npcHandler:say({
-- 	-- 		"If you have some old shaper tomes I would {buy} them."
-- 	-- 	}, npc, creature)
-- 	-- 	npcHandler:setTopic(playerId, 7)
-- 	-- end

-- 	if MsgContains(message, 'buy') then
-- 		npcHandler:say("I'm sorry, I don't buy anything. My main concern right now is the bulding of this temple.", npc, creature)
-- 		npc:openShopWindow(creature)
-- 	end

-- 	--- ##Astral Shaper Rune##
-- 	if MsgContains(message, 'astral shaper rune') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled) >= 1 then
-- 			npcHandler:say('Do you wish to merge your rune parts into an astral shaper rune?', npc, creature)
-- 			npcHandler:setTopic(playerId, 8)
-- 		else
-- 			npcHandler:say("I'm sorry but you lack the needed rune parts.", npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 8 then
-- 		local haveParts = false
-- 		for k = 1, #runes do
-- 			if player:removeItem(runes[k].runeid, 1) then
-- 				haveParts = true
-- 			end
-- 		end
-- 		if haveParts then
-- 			npcHandler:say('As you wish.', npc, creature)
-- 			player:addItem(24960, 1)
-- 			npcHandler:removeInteraction(npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 8 then
-- 		npcHandler:say('ok.', npc, creature)
-- 		npcHandler:removeInteraction(npc, creature)
-- 	end

-- 	--- ####PORTALS###
-- 	-- Ice Portal
-- 	if MsgContains(message, 'ice portal') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1 then
-- 			npcHandler:say({
-- 				"You may pass this portal if you have 50 fish as offering. Do you have the fish with you?"
-- 			}, npc, creature)
-- 			npcHandler:setTopic(playerId, 2)
-- 		else
-- 			npcHandler:say('Sorry, first you need to bring my Heavy Old Tomes.', npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 2 then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessIce) < 1 and player:getItemCount(3578) >= 50 then
-- 			player:removeItem(3578, 50)
-- 			npcHandler:say('Thank you for your offering. You may pass the Portal to the Powers of Ice now.', npc, creature)
-- 			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessIce, 1)
-- 		else
-- 			npcHandler:say("I'm sorry, you don't have enough fish. Return if you can offer fifty of them.", npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 2 then
-- 		npcHandler:say("In this case I'm sorry, you may not pass this portal.", npc, creature)
-- 	end

-- 	-- Holy Portal
-- 	if MsgContains(message, 'holy portal') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1 then
-- 			npcHandler:say({
-- 				"You may pass this portal if you have 50 incantation notes as offering. Do you have the incantation notes with you?"
-- 			}, npc, creature)
-- 			npcHandler:setTopic(playerId, 3)
-- 		else
-- 			npcHandler:say('Sorry, first you need to bring my Heavy Old Tomes.', npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 3 then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessGolden) < 1 and player:getItemCount(18929) >= 50 then
-- 			player:removeItem(18929, 50)
-- 			npcHandler:say('Thank you for your offering. You may pass the Portal to the Powers of Holy now.', npc, creature)
-- 			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessGolden, 1)
-- 		else
-- 			npcHandler:say("I'm sorry, you don't have enough incantation notes. Return if you can offer fifty of them.", npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 3 then
-- 		npcHandler:say("In this case I'm sorry, you may not pass this portal.", npc, creature)
-- 	end

-- 	-- Energy Portal
-- 	if MsgContains(message, 'energy portal') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1 then
-- 			npcHandler:say({
-- 				"You may pass this portal if you have 50 marsh stalker feathers as offering. Do you have the marsh stalker feathers with you?"
-- 			}, npc, creature)
-- 			npcHandler:setTopic(playerId, 4)
-- 		else
-- 			npcHandler:say('Sorry, first you need to bring my Heavy Old Tomes.', npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 4 then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessViolet) < 1 and player:getItemCount(17462) >= 50 then
-- 			player:removeItem(17462, 50)
-- 			npcHandler:say('Thank you for your offering. You may pass the Portal to the Powers of Energy now.', npc, creature)
-- 			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessViolet, 1)
-- 		else
-- 			npcHandler:say("I'm sorry, you don't have enough marsh stalker feathers. Return if you can offer fifty of them.", npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 4 then
-- 		npcHandler:say("In this case I'm sorry, you may not pass this portal.", npc, creature)
-- 	end

-- 	-- Earth Portal
-- 	if MsgContains(message, 'earth portal') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1 then
-- 			npcHandler:say({
-- 				"You may pass this portal if you have 50 acorns as offering. Do you have the acorns with you?"
-- 			}, npc, creature)
-- 			npcHandler:setTopic(playerId, 5)
-- 		else
-- 			npcHandler:say('Sorry, first you need to bring my Heavy Old Tomes.', npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 5 then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessEarth) < 1 and player:getItemCount(10296) >= 50 then
-- 			player:removeItem(10296, 50)
-- 			npcHandler:say('Thank you for your offering. You may pass the Portal to the Powers of Earth now.', npc, creature)
-- 			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessEarth, 1)
-- 		else
-- 			npcHandler:say("I'm sorry, you don't have enough acorns. Return if you can offer fifty of them.", npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 5 then
-- 		npcHandler:say("In this case I'm sorry, you may not pass this portal.", npc, creature)
-- 	end

-- 	-- Death Portal
-- 	if MsgContains(message, 'death portal') then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes) == 1 then
-- 			npcHandler:say({
-- 				"You may pass this portal if you have 50 pelvis bones as offering. Do you have the pelvis bones with you?"
-- 			}, npc, creature)
-- 			npcHandler:setTopic(playerId, 6)
-- 		else
-- 			npcHandler:say('Sorry, first you need to bring my Heavy Old Tomes.', npc, creature)
-- 		end
-- 	end

-- 	if MsgContains(message, 'yes') and npcHandler:getTopic(playerId) == 6 then
-- 		if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessDeath) < 1 and player:getItemCount(11481) >= 50 then
-- 			player:removeItem(11481, 50)
-- 			npcHandler:say('Thank you for your offering. You may pass the Portal to the Powers of Death now.', npc, creature)
-- 			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessDeath, 1)
-- 		else
-- 			npcHandler:say("I'm sorry, you don't have enough pelvis bones. Return if you can offer fifty of them.", npc, creature)
-- 		end
-- 	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) == 6 then
-- 		npcHandler:say("In this case I'm sorry, you may not pass this portal.", npc, creature)
-- 	end
-- 	return true
-- end

-- npcHandler:setMessage(MESSAGE_GREET, "Greetings, pilgrim. Welcome to the halls of hope. We are the keepers of this {temple} and welcome everyone willing to contribute.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Oh... farewell, child.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType:register(npcConfig)
