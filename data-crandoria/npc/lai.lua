local internalNpcName = "Lai"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1825,
	lookHead = 3,
	lookBody = 1,
	lookLegs = 1,
	lookFeet = 132,
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

	local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)
	local storageEssences = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences)
	local bossStorage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline)

	local crystal1 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal1)
	local crystal2 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal2)
	local crystal3 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal3)
	local crystal4 = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Crystal4)

	local totalNumber = math.max(0, storageEssences)

	if MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "essen") then
		if storage < 1 then
			npcHandler:say("Estou investigando um mal que assombra esta ilha. Preciso que obtenha essencias dos demonios (Demonic Core Essences). Talvez eu consiga mitigar a neblina densa de efeitos negativos que cerca esse lugar. \z
			Vamos comecar com poucas. Digamos... 100 delas! Traga-as para mim e faremos um teste.", npc, creature)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 1)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences, 0)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 1 then
			if storageEssences < 100 then
				npcHandler:say("Voce trouxe as 100 essencias?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			end
		elseif storage == 2 then
			npcHandler:say("Ha 4 cristais nas 4 torres desta fortaleza. Ative todos e retorne ate mim. Vamos nos preparar para entrar nas profundezas deste lugar.", npc, creature)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 3)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 3 then
			if crystal1 >= 1 and crystal2 >= 1 and crystal3 >= 1 and crystal4 >= 1 then
				npcHandler:say("Muito bem, vejo que voce ativou todos os cristais da superficie. Agora vamos iniciar as exploracoes do subsolo para ativar um ultimo cristal. So ha um problema: \z
				Eu nao sei onde ele esta. Mas eu soube que ha um ser preso no subsolo que explorou boa parte do local. Um humano, como voce. Encontre-o e liberte-o. Ele nos ajudara.", npc, creature)
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 4)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce deve ativar os 4 cristais.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif storage == 4 then
			npcHandler:say("Encontre o ser que esta perdido no primeiro andar do subsolo e ajude-o. Va, rapido!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 5 then
			npcHandler:say("Muito bem, parece que voce conseguiu ajudar o humano chamado Ortelio. Eu me encontrei com ele na saida e ele nos deu algumas pistas. \z
			De acordo com ele, alguns guardas conversavam uma noite sobre um cristal super protegido no segundo andar do subsolo. Acredito que voce possa comecar por ai. \z
			Encontre o cristal e ative-o.", npc, creature)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 6)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 6 then
			npcHandler:say("Ative o cristal passando pelo teleport no segundo nivel do subsolo.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 7 then
			npcHandler:say("Voce conseguiu. Agora vamos ao seu ultimo desafio, que tambem pode ser apenas o inicio de outros... \z
			O assombroso Arbaziloth esta dominando o subsolo com seus poderes sombrios. Preciso pedir que voce o derrote. Se conseguir te darei uma recompensa. Ah! \z
			Ha um poderoso ferreiro vivendo no local. Nao sei de que lado ele esta nessa historia, mas seja cuidadoso!", npc, creature)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 8)
			npcHandler:setTopic(playerId, 0)
		elseif storage == 9 then
			player:addOutfit(1809)
			player:addOutfit(1808)
			player:addExperience(30000000, true)
			npcHandler:say("Incrivel! Voce realmente derrotou o poderoso Arbaziloth. Bom, como combinado, sua recompensa: um novo outfit. Faca bom uso! \z
			Sobre o Forgemaster... descobri que ele faz um teste com os guerreiros que enfrentam Arbaziloth.\z
			Pelo que eu soube, ele deve permanecer vivo durante o combate e, nesse caso, voce devera derrotar Arbaziloth duas vezes! Faca isso 1 vez e podera pegar uma arma como recompensa. \z
			Faca isso 10 vezes e o Forgemaster podera melhorar sua arma!", npc, creature)
			local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep + 5)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce concluiu o Ritual.")
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 10)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
		if player:getItemCount(49909) >= 100 then
			player:removeItem(49909, 100)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences, 100)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 2)
			npcHandler:say("Excelente. Vamos testar... bom, parece que consegui reduzir um pouco os danos causados pela neblina, mas ainda nao foi o suficiente... Voce pode utilizar novas essencias por conta propria para reduzir ainda mais os danos da neblina. \z
			Talvez agora seja hora de uma nova {missao}.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end

end

npcHandler:setMessage(MESSAGE_GREET, "Saudacoes. Nao esqueca da sua {missao} no mundo.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)

-- local internalNpcName = "Lai"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1825,
-- 	lookHead = 3,
-- 	lookBody = 1,
-- 	lookLegs = 1,
-- 	lookFeet = 132,
-- 	lookAddons = 3
-- }

-- npcConfig.flags = {
-- 	floorchange = false
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

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)
-- 	local storageEssences = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences)

-- 	if MsgContains(message, "missao") or MsgContains(message, "mission") then
-- 		if storage < 1 then
-- 			npcHandler:say("Estou investigando um mal que assombra esta ilha. Preciso que obtenha essencias dos demonios (Demonic Core Essences). Talvez eu consiga mitigar a neblina densa de efeitos negativos que cerca esse lugar. \z
-- 			Vamos comecar com poucas. Digamos... 100 delas! Traga-as para mim e faremos um teste.", npc, creature)
-- 			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog, 1)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif storage == 1 then
-- 			if storageEssences < 1 then
-- 				npcHandler:say("Voce trouxe as 100 essencias?", npc, creature)
-- 				npcHandler:setTopic(playerId, 1)
-- 			elseif storageEssences == 1 then
-- 				npcHandler:say("Voce trouxe as 100 essencias?", npc, creature)
-- 				npcHandler:setTopic(playerId, 2)
-- 			end
-- 		end
-- 	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
-- 		if npcHandler:getTopic(playerId) == 1 then
-- 			if player:removeItem(49909, 100) then
-- 				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences, 1)
-- 				npcHandler:say("Excelente. Vamos testar... bom, parece que consegui reduzir um pouco os danos causados pela neblina, mas ainda nao foi o suficiente... Traga-me mais 100 da proxima vez.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Sinto muito, mas voce nao possui essencias o suficiente.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			if player:removeItem(49909, 100) then
-- 				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Essences, 2)
-- 				npcHandler:say("Excelente. Vamos testar... bom, parece que consegui reduzir um pouco os danos causados pela neblina, mas ainda nao foi o suficiente... Traga-me 400 da proxima vez.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Sinto muito, mas voce nao possui essencias o suficiente.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		end
-- 	end

-- end

-- npcHandler:setMessage(MESSAGE_GREET, "Saudacoes. Nao esqueca da sua {missao} no mundo.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType:addDialogOptions("bye")
-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)