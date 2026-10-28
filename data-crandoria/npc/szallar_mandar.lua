local internalNpcName = "S'Zallar M'Andar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000 -- TODO
-- npcConfig.walkRadius = 2 -- TODO

npcConfig.outfit = {
	lookType = 115,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.speechBubble = 1

npcConfig.light = {
	level = 0,
	color = 0,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	-- TODO: Add voices
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

	local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
	local level = player:getLevel()

    if MsgContains(message, "missao") or MsgContains(message, "mission") then
		if level < 450 then
			npcHandler:say("<HISSS> Voce ainda esta fraco. Volte apos o nivel 450. <HISSS>", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if storage < 1 then
				npcHandler:say("<HISSS> Sou um estudiodo de forcas magicas que se manifestam no mundo dos vivos e dos mortos. \z
				Recentemente detectei um poder maligno intenso emanado de varios pontos do Novo Continente e temo ser obra do Bone Overlord. \z
				Agora estou buscando por aqueles que possuem coragem e forca para derrotar essa criatura e seus seguidores. Acha que da conta dessa missao? <HISSS>", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif storage == 1 then
				npcHandler:say("<HISSS> Encontre o espirito ancestral dos dragoes em Dracantus. Use a caveira para te guiar ate ele. <HISSS>", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage > 1 and storage < 13 then
				npcHandler:say("<HISSS> Voce deve ser guiado pelo dragao ancestral, em Dracantus, para derrotar o Bone Overlord. <HISSS>", npc, creature)
				npcHandler:setTopic(playerId, 0)
			elseif storage == 13 then
				if player:getFreeBackpackSlots() < 2 then
					npcHandler:say("<HISSS> Libere um pouco de espaco em seu inventario... <HISSS>", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("<HISSS> Voce conseguiu! Derrotou o Bone Overlord e trouxe equilibrio entre as forcas do bem e do mal no Novo Continente. Mas saiba que ele ira voltar... \z
					De qualquer forma ficamos gratos com a sua ajuda. Muitos nem saberao da sua conquista, mas toros serao recompensados por ela. E para voce, entrego tambem um humilde recompensa material. \z
					Sei que nao parece muito, mas pode te ajudar em sua jornada. <HISSS>", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 14)
					player:addExperience(25000000, true)
					local bag = player:addItem(25780, 1)
					if bag then
						bag:addItem(14112, 1)
						bag:addItem(26186, 1)
						bag:addItem(51589, 1)
					end
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
	elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
		if npcHandler:getTopic(playerId) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso, 1)
			player:addItem(51976, 1)
			npcHandler:say("Voce parece ter hesitado um pouco... <HISSS> mas tudo bem. Para encontrar o Bone Overlord precisaremos da ajuda do espirito ancestral dos dragoes. \z
			Esse espirito pode ser encontrado em algum lugar na ilha de Dracantus. Aqui, segura esta caveira de dragao. Use-a e ela te guiara ate ele. \z
			Eu ja me comuniquei com o espirito ancestral, ele sabera como te guiar a partir de entao. <HISSS>", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, sangue quente. O que o traz aqui?") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_FAREWELL, "Que os ancioesss te guiem.") -- TODO: Confirmar
npcHandler:setMessage(MESSAGE_WALKAWAY, "Que os ancioesss te guiem.") -- TODO: Confirmar
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
