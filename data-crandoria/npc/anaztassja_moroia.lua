local internalNpcName = "Anaztassja Moroia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 312,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	if not player then
		return false
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) < 1 then
		npcHandler:resetNpc(creature)
		return false
	end

	npcHandler:setMessage(MESSAGE_GREET, "There you are. Your obvious choice how to infiltrate the fortress is telling! However, there is {business} at hand?")

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local player = Player(creature)
	if not player then
		return false
	end

	local level = player:getLevel()

	local storage = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline)
	local arthei = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.ArtheiDoor)
	local boreth = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.BorethDoor)
	local lesartio = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.LersatioDoor)
	local marziel = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.MarzielDoor)
	local zevelon = player:getStorageValue(Storage.Quest.U8_4.BloodBrothers.ZevelonKill)

	local playerId = creature:getId()

	if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if storage < 1 then
			if level >= 200 then
				npcHandler:say("Tenho uma missao de extrema importancia e ofereco uma boa recompensa para aquele que for capaz de cumpri-la. \z
				Mas saiba que esse pode ser um desafio muito grande para mortais fracos. Nao diga que nao avisei. \z
				Voce acha que da conta?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("Sinto muito, mas voce nao parece forte o suficiente para aceitar o desafio que tenho a oferecer. Retorne apos o nivel 200.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 1 then
			if arthei < 1 or boreth < 1 or lesartio < 1 or marziel < 1 then
				npcHandler:say("Derrote cada um dos 4 lordes demonios pelo menos uma vez para remover o controle que Vladrukh possui sobre eles.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Derrotar os quatro irmaos lordes era apenas o inicio, mas voce se saiu bem. Agora voce tem permissao para enfrentar o pior deles: Zevelon. \z
				Passe pela porta ao norte e acesse o portal para chegar a torre de Zevelon. Derrote-o sozinho, assim como os demais.", npc, creature)
				player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 2)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 2 then
			if zevelon >= 1 then
				npcHandler:say("Zevelon esta livre da maldicao de Vladrukh. Obrigada por isso. Como recompensa, a partir de agora te ofereco exercise stashes em troca de Vampire Lord Tokens. \z
				Caso tenha interesse, basta oferecer uma {troca}. Acredito tambem que agora voce esta pronto para seguir com a {missao}.", npc, creature)
				player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 3)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Derrote Zevelon e salve-o da maldicao de Vladrukh.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 3 then
			if level >= 250 then
				npcHandler:say("Tomando o caminho da torre de Boreth, voce encontrara um teleport que leva a area externa do castelo. Por esta passagem voce podera ir ate a fortaleza com o exercito de Vladrukh. \z
				No local voce deve buscar a passagem ate o ultimo nivel do subsolo, onde estarei te esperando para seu proximo desafio. Infelizmente voce ainda nao tem poderes para seguir pelo atalho. \z
				No caminho voce encontrara uma passagem fechada com pedras e um pedestal. Nao sei qual item voce precisara sacrificar para passar, mas a informacao estara na fortaleza com certeza. Boa sorte.", npc, creature)
				player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 4)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Acredito que voce ainda nao seja forte o suficiente para a proxima etapa. Retorne apos o nivel 250.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 4 then
			if player:getPosition().z == 12 then
				npcHandler:say("Voce conseguiu mesmo. Muito bem! Agora chegamos na parte mais dificil: Derrotar Vladrukh! Reuna um time de ate 5 jogadores para essa missao. \z
				Quanto mais pessoas puderem te ajudar, menos chances voce tera de morrer tentando. Para enfrenta-lo, basta entrar no teleport a esquerda e puxar a alavanca. \z
				Retorne ate mim caso consiga vencer a batalha.", npc, creature)
				player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 5)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Me encontre no ultimo andar do subsolo da fortaleza de Vladrukh.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 5 then
			npcHandler:say("Derrote Vladrukh e clame por sua recompensa.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Voce conseguiu! Enfraqueceu Vladrukh e deu uma nova chance para o povo vampiro. Muito obrigada! Como recompensa, te ofereco uma nova montaria: o Gloom Maw. \z
			Espero que nao te traga mais problemas. Boa sorte em sua jornada!", npc, creature)
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 7)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Muito bem, preste atencao. Um orc maldito chamado Vladrukh usou o sangue de uma antiga entidade para se tornar um vampiro. \z
			Agora, com tal poder, ele esta criando um exercito de orcs vampiros para dominar todo ser vivo da superficie, e sim, isso inclui os humanos. Quem diria?! \z
			O problema ainda piora: Com seus poderes ele corrompeu e esta controlando a mente de quatro lordes vampiros do castelo: Boreth, Lersatio, Marziel e Arthei. \z
			Sua primeira missao sera derrotar cada um deles sozinho, acessando seus aposentos pelos teleports nas torres deste castelo. Retorne quando derrotar todos eles. \z
			E tenha cuidado! Em razao dos poderes usados sobre eles, cada um esta um pouco mais forte do que o normal...", npc, creature)
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 1)
			npcHandler:setTopic(playerId, 0)
		end
	end

	npcHandler:resetNpc(creature)

	return true
end

local function onTradeRequest(npc, creature)
	if Player(creature):getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline) < 3 then
		npcHandler:say("Sinto muito, mas nao confio o suficiente em sua forca para oferecer qualquer troca.", npc, creature)
		return false
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Nao tenha medo, pobre mortal. Aproxime-se.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcConfig.currency = 8192

npcConfig.shop = {
	{ itemName = "exercise stash", clientId = 26186, buy = 50 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)

-- npcType registering the npcCo


-- local internalNpcName = "Anaztassja Moroia"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 312,
-- 	lookHead = 0,
-- 	lookBody = 0,
-- 	lookLegs = 0,
-- 	lookFeet = 0,
-- 	lookAddons = 0,
-- }

-- npcConfig.flags = {
-- 	floorchange = false,
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
-- 	npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
-- 	npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
-- 	npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
-- 	npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
-- 	npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
-- 	npcHandler:onCloseChannel(npc, creature)
-- end

-- local function greetCallback(npc, creature)
-- 	local player = Player(creature)
-- 	if not player then
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) < 1 then
-- 		npcHandler:resetNpc(creature)
-- 		return false
-- 	end

-- 	npcHandler:setMessage(MESSAGE_GREET, "There you are. Your obvious choice how to infiltrate the fortress is telling! However, there is {business} at hand?")

-- 	return true
-- end

-- local function creatureSayCallback(npc, creature, type, message)
-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	local player = Player(creature)
-- 	if not player then
-- 		return false
-- 	end

-- 	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) < 1 then
-- 		npcHandler:resetNpc(creature)
-- 		return false
-- 	end

-- 	local playerId = creature:getId()

-- 	if MsgContains(message, "business") then
-- 		if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist) == 1 then
-- 			npcHandler:say({
-- 				"The fortress is protected by several powerful wards, some are even dating back to a time where the Norcferatu were common orcs. ...",
-- 				"And that's our inroad to break them. The ancestor spirits of the Norcferatu will not be happy of what has become of their tribe. By gaining their support, we will be able to breach the protective magic. ...",
-- 				"Find the ancestral cave and find a way to communicate the ancestor spirits! I will put a spell on you that will enable you to see them and interact with them. ...",
-- 				"Then convince them to assist us in stopping Vladrukh.",
-- 			}, npc, creature, 100)
-- 			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.ThroughTheMist, 2)
-- 			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheWrathOfTheAncestorst, 1)
-- 		elseif player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.TheNextStep) == 1 then
-- 			npcHandler:say({
-- 				"You have indeed appeased the spirits of the orcish ancestors. ...",
-- 				"The deeper dungeons of blood tusk keep are warded against unwanted intruders. Only those marked as Vladrukhs kin are allowed to enter. To fool the wards you will have to undergo the baptism of blood. ...",
-- 				"Find Vladruks bloodbath and endure the gruesome bath for long enough, to receive the mark of the vampire. ...",
-- 				"Be warned though, a blind monstrosity will guard the bath. You will either have to be extremely quick or better trick the monster somehow, to enter the chamber.",
-- 			}, npc, creature, 100)
-- 			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.TheNextStep, 2)
-- 			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Bloodbath, 1)
-- 		end
-- 	end

-- 	npcHandler:resetNpc(creature)

-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType:register(npcConfig)
