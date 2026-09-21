local internalNpcName = "Uzon"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 95,
	lookBody = 4,
	lookLegs = 17,
	lookFeet = 95,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Feel the wind in your hair during one of my carpet rides!'}
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

-- Travel
local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier
local function addTravelKeyword(keyword, text, cost, destination, condition, action)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Never heard about a place like this.'}, condition)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = text, cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Hold on!', cost = cost, discount = 'postman', destination = destination}, nil, action)
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'You shouldn\'t miss the experience.', reset = true})
end

addTravelKeyword('chaos', 'Do you seek a ride to Chaos on Serpentis for 1500 gold coins?', 1500, Position(5069, 4521, 6))
addTravelKeyword('crandoria', 'Do you seek a ride to Crandoria for 1000 gold coins?', 1000, Position(4999, 4955, 5))
addTravelKeyword('magincia', 'Do you seek a ride to Magincia for 1500 gold coins?', 1500, Position(4796, 5235, 5))
addTravelKeyword('icehold', 'Do you seek a ride to Icehold for 1000 gold coins?', 1000, Position(4996, 5391, 5))
addTravelKeyword('anvillux', 'Do you seek a ride to Anvillux for 1000 gold coins?', 1000, Position(5435, 4497, 3))
addTravelKeyword('nautis', 'Do you seek a ride to Nautis for 1000 gold coins?', 1000, Position(5605, 4889, 7))
addTravelKeyword('marapur', 'Do you seek a ride to Marapur for 2000 gold coins?', 2000, Position(5643, 4322, 2))


-- Basic
-- keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "I am known as Uzon Ibn Kalith."})
-- keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am a licensed Darashian carpet pilot. I can bring you to {Crandoria}, {Chaos} on Serpentis, {Nautis}, {Marapur}, {Icehold} or {Magincia}."})
-- keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "I would never transport this one."})
-- keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Some people claim it is hidden somewhere under the endless sands of the devourer desert in Darama."})
-- keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "I have seen almost every place on that continent."})
-- keywordHandler:addKeyword({'continent'}, StdModule.say, {npcHandler = npcHandler, text = "I could retell the tales of my travels for hours. Sadly another flight is scheduled soon."})
-- keywordHandler:addKeyword({'flying'}, StdModule.say, {npcHandler = npcHandler, text = "You can buy flying carpets only in Nivabi."})
-- keywordHandler:addKeyword({'fly'}, StdModule.say, {npcHandler = npcHandler, text = "I transport travellers through the New Continent for a small fee."})
-- keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, text = "I heard too many news to recall them all."})
-- keywordHandler:addKeyword({'rumors'}, StdModule.say, {npcHandler = npcHandler, text = "I heard too many news to recall them all."})
-- keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = "I can fly you to {Anvillux}, {Crandoria}, {Chaos} on Serpentis, {Nautis}, {Marapur}, {Icehold} or {Magincia} if you like. Where do you want to go?"})
-- keywordHandler:addKeyword({'transport'}, StdModule.say, {npcHandler = npcHandler, text = "I can fly you to {Anvillux}, {Crandoria}, {Chaos} on Serpentis, {Nautis}, {Marapur}, {Icehold} or {Magincia} if you like. Where do you want to go?"})
-- keywordHandler:addKeyword({'ride'}, StdModule.say, {npcHandler = npcHandler, text = "I can fly you to {Anvillux}, {Crandoria}, {Chaos} on Serpentis, {Nautis}, {Marapur}, {Icehold} or {Magincia} if you like. Where do you want to go?"})
-- keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = "I can fly you to {Anvillux}, {Crandoria}, {Chaos} on Serpentis, {Nautis}, {Marapur}, {Icehold} or {Magincia} if you like. Where do you want to go?"})
-- keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "It's 3:42 pm right now. The next flight is scheduled soon."})

-- npcHandler:setMessage(MESSAGE_GREET, "My blessings, traveller |PLAYERNAME|.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "I see you around!")

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou conhecido como Uzon Ibn Kalith."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou um piloto licenciado de tapetes de Darashia. Posso te levar para {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Eu jamais transportaria esse individuo."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Algumas pessoas dizem que ela esta escondida em algum lugar nas areias infinitas do deserto devorador em Darama."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ja vi quase todos os lugares desse continente."})
keywordHandler:addKeyword({'continent'}, StdModule.say, {npcHandler = npcHandler, text = "Eu poderia contar as historias das minhas viagens por horas. Infelizmente, outro voo esta programado em breve."})
keywordHandler:addKeyword({'flying'}, StdModule.say, {npcHandler = npcHandler, text = "Voce pode comprar tapetes voadores somente em Nivabi."})
keywordHandler:addKeyword({'fly'}, StdModule.say, {npcHandler = npcHandler, text = "Eu transporto viajantes pelo Novo Continente por uma pequena taxa."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ouvi muitas novidades para lembrar de todas."})
keywordHandler:addKeyword({'rumors'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ouvi muitas novidades para lembrar de todas."})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = "Eu posso te levar para {Anvillux}, {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}, se voce quiser. Para onde deseja ir?"})
keywordHandler:addKeyword({'transport'}, StdModule.say, {npcHandler = npcHandler, text = "Eu posso te levar para {Anvillux}, {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}, se voce quiser. Para onde deseja ir?"})
keywordHandler:addKeyword({'ride'}, StdModule.say, {npcHandler = npcHandler, text = "Eu posso te levar para {Anvillux}, {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}, se voce quiser. Para onde deseja ir?"})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = "Eu posso te levar para {Anvillux}, {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}, se voce quiser. Para onde deseja ir?"})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Sao 3:42 da tarde agora. O proximo voo esta programado em breve."})

npcHandler:setMessage(MESSAGE_GREET, "Minhas bencaos, viajante |PLAYERNAME|. Eu posso te levar para {Anvillux}, {Crandoria}, {Chaos} em Serpentis, {Nautis}, {Marapur}, {Icehold} ou {Magincia}, se voce quiser. Para onde deseja ir?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate logo!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Vejo voce por ai!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
