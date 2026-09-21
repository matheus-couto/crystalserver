local internalNpcName = "Aldina"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 610,
	lookHead = 76,
	lookBody = 55,
	lookLegs = 49,
	lookFeet = 95,
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

	if MsgContains(message, "armor") or MsgContains(message, "armadura") or MsgContains(message, "addon") or MsgContains(message, "missao") or MsgContains(message, "mission") or MsgContains(message, "vest") then
		if player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 6 then
			npcHandler:say("Oi? Me desculpe, mal pude te ouvir com tanto barulho de martelos batendo aqui e ali... Anvillux nunca para, por isso gosto tanto dessa cidade. \z
			Essas roupas? Eu uso elas ha muitos anos... desde Oramond. Por que a pergunta? Esta interessado em adquirir os addons para o Glooth Engineer Outfit?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 7 then
			npcHandler:say("Se quiser seu novo addon preciso que me traga 2 Huge Chunk of Crude Irons, 20 Gear Wheels e 5 Giant Shimmering Pearls. Voce esta com os itens?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 8 then
			npcHandler:say("Ainda em busca de melhorar seu Glooth Engineer Outfit? Escute, tenho uma tarefa para voce. Nao sera nada dificil ou muito elaborado, mas voce tera que ter muita atencao. \z
			Preciso de alguem que possa atender a algumas demandas de reparos pelo Novo Continente. Mas preciso que os clientes sejam atendidos na ordem correta. \z
			Voce acha que da conta dessa missao?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) >= 9 and player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) < 12 then
			npcHandler:say("Termine todos os reparos e depois retorne ate mim.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 12 then
			npcHandler:say("Muito bem! Voce finalizou mesmo todos os reparos. Mas nao pense que terminou... Deixei a missao mais desafiadora para o final! Esta preparado?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 13 then
			npcHandler:say("Voce trouxe a Divine Plate?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 7)
			npcHandler:say("Certo... Eu posso te ajudar com isso, mas antes voce tera que me ajudar com alguns materiais. Meus dias de luta acabaram e preciso de um braco forte para me ajudar. \z
			Preciso de 2 Huge Chunk of Crude Irons, 20 Gear Wheels e 5 Giant Shimmering Pearls. Traga todos os itens e te darei um novo addon para suas vestes.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(5892) >= 2 and player:getItemCount(8775) >= 20 and player:getItemCount(282) >= 5 then
				player:removeItem(5892, 1)
				player:removeItem(5892, 1)
				player:removeItem(8775, 20)
				player:removeItem(282, 5)
				player:addOutfitAddon(610, 1)
				player:addOutfitAddon(618, 1)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				npcHandler:say("Voce trouxe mesmo os itens. Excelente! Aqui, como combinado, vou melhorar um pouco seu Glooth Engineer Outfit.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 8)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Voce nao possui todos os itens. Preciso de 2 Huge Chunk of Crude Irons, 20 Gear Wheels e 5 Giant Shimmering Pearls.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 9)
			npcHandler:say("Muito bem, entao preste atencao: Primeiro preciso que voce repare a alavanca do portao das torres de guarda de Nagaeth. Esta emperrada e precisa de oleo. Depois, va ate Chaos. \z
			Em chaos preciso que voce conserte um dos postes da cidade que esta queimado. Utilize a parte de traz de um martelo para abrir a luminaria. \z
			Por ultimo, leve um martelo e 2 troncos de madeira (Firewood)) e corrija as rachaduras no pequeno pier de Astralis. Aguarderei por voce aqui.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 13)
			npcHandler:say("Escute... Estou fazendo um reparo de uma armadura para o Rei Tibianus, mas o maldito sempre foi enorme! Eu preciso derreter uma armadura para tentar 'aumentar' a armadura dele... \z
			Para isso precisarei de outra armadura novinha em folha. A armadura em questao se chama Divine Plate. Traga-me a armadura e eu te darei a segunda parte de seu Outfit.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:removeItem(8057, 1) then
				npcHandler:say("Incrivel! Esta em otimo estado. Com certeza vai funcionar perfeitamente. Aqui, como combinado, seu Glooth Engineer Outfit esta completo! E estou te dando mais uma singela recompensa tambem...", npc, creature)
				player:addOutfitAddon(610, 2)
				player:addOutfitAddon(618, 2)
				local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
				player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				player:addItem(26186, 1)
				player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 14)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("E onde esta a armadura? Nao tente me passar para tras...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)


-- local internalNpcName = "Barazbaz"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 132,
-- 	lookHead = 76,
-- 	lookBody = 55,
-- 	lookLegs = 49,
-- 	lookFeet = 95,
-- 	lookAddons = 0
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

-- 	if MsgContains(message, "ritual") and player:getStorageValue(Storage.DarkTrails.Mission06) == 1 then
-- 		npcHandler:say({
-- 			"Ancient structures in the sewers you say? Well, our city has had a certain bloody past, even before it has \z
-- 				been city at all. But to investigate the archives for what you may have found is a time-consuming process. ...",
-- 			"Usually, I'm too much bound to my duties to the city to sacrifice time for such an endeavour. ...",
-- 			"But on the other hand, just now is the time of an important decision of the magistrate concerning the funding of the archives. It is a matter easily overlooked by our good citizens. ...",
-- 			"If you'd be so kind to place just one of your votes for the funding of the archives, I would be inclined to take the time for your investigation in turn. ...",
-- 			"Just go to Marvin in the magistrate and vote for a greater funding of the archives. Afterwards, I might be able to present you with some first results of my investigations on your behalf."
-- 		}, npc, creature, 10)
-- 		player:setStorageValue(Storage.DarkTrails.Mission07, 1)
-- 	elseif MsgContains(message, "abandoned sewers") and player:getStorageValue(Storage.DarkTrails.Mission08) == 1 then
-- 		npcHandler:say({
-- 			"Excellent! Concerning the ancient ruins that you have found, well, if you are not familiar with the city's history, feel free to browse a few books here. I will only refer to some basics here, so I don't waste your time. ...",
-- 			"The first humans that lived here and that we have any records of lived in slavery of an ancient evil. ...",
-- 			"The nature of this evil is up to debate, but there are hints that this evil predated the settlement of men and that it perhaps was part of a more ancient civilisation or caused the downfall of the latter. ...",
-- 			"After that evil had been overcome, much was sealed away. Some say that only forbidden knowledge had been sealed, but others like me were always worried that more had been hidden. ...",
-- 			"Something like the ruins you have found. What you have seen there hints to a new incident, though. As if someone or something was searching for something. In the past, when those ruins were buried, people were primitive and superstitious. ...",
-- 			"Today, we have advanced far more and could have the ruins investigated in a far more efficient way. And that is what I would just recommend you to do: get a necrometer from magistrate Jondrin upstairs and investigate the ruins thoroughly."
-- 		}, npc, creature, 10)
-- 		player:setStorageValue(Storage.DarkTrails.Mission09, 1)
-- 	elseif(MsgContains(message, "notebook")) and (player:getStorageValue(Storage.DarkTrails.Mission11) == 1 and getPlayerItemCount(creature, 11450) == 1) then
-- 		npcHandler:say({
-- 			" I know that handwriting you describe! It belongs to a traveller from far away. Magistrate Sholley introduced him 	to me and she was quite excited to learn more about our city's past. ...",
-- 			"I should have thought of him right in the beginning when I heard the stuff you mentioned. But I haven't seen him for a while. You should ask Sholley about her friend to learn about his whereabouts."
-- 		}, npc, creature, 10)
-- 		player:setStorageValue(Storage.DarkTrails.Mission12, 1)
-- 		doPlayerRemoveItem(creature,11450, 1)
-- 	else
-- 		npcHandler:say("You need to kill the {The Ravager}, click on statue and then come here say {ritual}, {abandoned sewers}, {notebook} and after this find Roswitha and talk with she.", npc, creature)
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
