local internalNpcName = "Morax"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = { 
	lookType = 289,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 0,
	lookFeet = 113,
	lookAddons = 1
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

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	-- Mission 3 start
-- 	if MsgContains(message, "missao") or MsgContains(message, "mission") then
-- 		-- if player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) < 1 then
-- 		-- 	if player:getLevel() < 300 then
-- 		-- 		npcHandler:say("Voce nao parece muito forte para executar minhas missoes... Retorne quando atingir nivel 300 ou superior.", npc, creature)
-- 		-- 		npcHandler:setTopic(playerId, 0)
-- 		-- 	else
-- 		-- 		npcHandler:say("Entao voce busca por desafios, certo? Ha! Muito bem, muito bem... antes de te entregar uma missao realmente dificil, quero ver se voce pode ser util. \z
-- 		-- 		Acesse as profundezas de Roshamuul, no lar dos Feversleeps. Nas produndezas voce encontrara diversos Cristais dos Sonhos nas paredes. Utilize uma Chaos Pickaxe para remove-los. \z
-- 		-- 		Mas atencao: Esses cristais sao extremamente sensiveis e podem se partir no processo de extracao. Alem disso demoram para ressurgir. Voce da conta dessa missao?", npc, creature)
-- 		-- 		npcHandler:setTopic(playerId, 1)
-- 		-- 	end
-- 		-- elseif player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) == 1 then
-- 		-- 	npcHandler:say("Voce trouxe os tres Cristais dos Sonhos?", npc, creature)
-- 		-- 	npcHandler:setTopic(playerId, 2)
-- 		-- elseif player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) == 2 then
-- 		-- 	npcHandler:say("Muito bem... voce quer algo dificil, certo? Entao vamos la... Ha um monstro terrivel que surge nas profundezas da Prisao de Roshamuul chamado Gaz'Haragoth. Ele sempre foi o mais temido dos demonios. \z
-- 		-- 	Na verdade, os cristais que te pedi serao usados, de certa forma, para nos proteger desse monstro. Mas vamos ao que interessa... Sua missao sera muito simples: \z
-- 		-- 	Voce devera derrotar Gaz'Haragoth! Nem mais nem menos que isso. Acha que esta preparado?", npc, creature)
-- 		-- 	npcHandler:setTopic(playerId, 3)
-- 		-- elseif player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) == 3 then
-- 		-- 	npcHandler:say("Va e derrote Gaz'Haragoth!", npc, creature)
-- 		-- 	npcHandler:setTopic(playerId, 0)
-- 		-- elseif player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) == 4 then
-- 		-- 	npcHandler:say("Incrivel! Voce conseguiu mesmo. Estou impressionado com sua capacidade. Como recompensa, te entregarei o Dream Warden Outfits. Se quiser obter os {addons}, basta dizer.", npc, creature)
-- 		-- 	player:setStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso, 5)
-- 		-- 	player:addExperience(10000000)
-- 		-- 	player:addOutfit(577, 0)
-- 		-- 	player:addOutfit(578, 0)
-- 		-- 	npcHandler:setTopic(playerId, 0)
-- 		-- end
-- 	elseif MsgContains(message, "addon") then
-- 		if (player:hasOutfit(577) or player:hasOutfit(578)) and player:getStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso) >= 2 then
-- 			npcHandler:say("Deseja obter um dos addons do Dream Warden Outfits? Qual voce deseja obter, o {primeiro} ou o {segundo}?", npc, creature)
-- 			npcHandler:setTopic(playerId, 4)
-- 		else
-- 			npcHandler:say("Voce deve obter o Dream Warden Outfit e finalizar minha {missao} antes de obter os addons.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		end
-- 	elseif MsgContains(message, "primeiro") then
-- 		if npcHandler:getTopic(playerId) == 4 then
-- 			npcHandler:say("Para obter o primeiro addon, preciso que me entregue uma Dream Warden Mask. Voce possui o item?", npc, creature)
-- 			npcHandler:setTopic(playerId, 5)
-- 		end
-- 	elseif MsgContains(message, "segundo") then
-- 		if npcHandler:getTopic(playerId) == 4 then
-- 			npcHandler:say("Para obter o segundo addon, preciso que me entregue uma Dream Warden Claw. Voce possui o item?", npc, creature)
-- 			npcHandler:setTopic(playerId, 6)
-- 		end
-- 	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
-- 		if npcHandler:getTopic(playerId) == 1 then
-- 			npcHandler:say("Ok. Preste atencao: Esses cristais serao usados para fins de protecao para a ilha de Roshamuul. Sao extremamente importantes. Traga-os para mim o quanto antes!", npc, creature)
-- 			player:setStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso, 1)
-- 			npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 2 then
-- 			if player:getItemCount(20047) >= 3 then
-- 				player:removeItem(20047, 3)
-- 				npcHandler:say("Voce conseguiu mesmo! Impressionante! Espero que nao tenha sofrido muito nas 'maos' dos Feversleeps... Voce provou seu valor. Se quiser uma {missao} de verdade, basta me dizer.", npc, creature)
-- 				player:setStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso, 2)
-- 				player:addExperience(1500000)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("E onde estao os cristais?...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		-- elseif npcHandler:getTopic(playerId) == 3 then
-- 		-- 	npcHandler:say("Muito bem! Acredito no seu potencial e gosto da sua confianca, mas escute... Gaz'Haragoth sera um enorme desafio. Aconselho que leve uma equipe. Uma equipe nao... um time! \z
-- 		-- 	Alem disso, nunca sabemos quando ele vai surgir novamente. Ele sempre foi imprevisivel! Mas temos exploradores checando e emitindo avisos sempre que ele for avistado. Fique atendo! Estarei esperando pelo seu retorno.", npc, creature)
-- 		-- 	player:setStorageValue(Storage.Quest.Crandoria.DreamWardenAddon.Progresso, 3)
-- 		-- 	npcHandler:setTopic(playerId, 0)
-- 		elseif npcHandler:getTopic(playerId) == 5 then
-- 			if player:getItemCount(20276) >= 1 then
-- 				player:removeItem(20276, 1)
-- 				player:addOutfitAddon(577, 1)
-- 				player:addOutfitAddon(578, 1)
-- 				npcHandler:say("Muito bem! Aqui esta seu addon.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o item...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 6 then
-- 			if player:getItemCount(20275) >= 1 then
-- 				player:removeItem(20275, 1)
-- 				player:addOutfitAddon(577, 2)
-- 				player:addOutfitAddon(578, 2)
-- 				npcHandler:say("Muito bem! Aqui esta seu addon.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Voce nao possui o item...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		end
-- 	end
-- 	return true
-- end

npcHandler:setMessage(MESSAGE_GREET, "...")
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus.') -- Need revision

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
