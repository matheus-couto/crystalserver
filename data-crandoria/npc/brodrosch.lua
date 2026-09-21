local internalNpcName = "Brodrosch"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 66
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Passage to the deepest places! Unforgettable steamboat ride!'}
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

local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, 'ticket') or MsgContains(message, 'bilhete') then
		if Player(creature):getStorageValue(Storage.WagonTicket) >= os.time() then
			npcHandler:say('Seu bilhete semanal ainda esta valido. Seria um desperdicio de dinheiro comprar um segundo.', npc, creature)
			return true
		end

		npcHandler:say('Voce quer comprar um bilhete semanal para os vagons de minerio? Com ele voce pode viajar livremente e rapidamente por Kazordoon durante uma semana. Apenas 250 moedas de ouro. Fechado?', npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, 'yes') and npcHandler:getTopic(playerId) > 0 then
		local player = Player(creature)
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeMoneyBank(250) then
				npcHandler:say('Voce nao tem dinheiro suficiente.', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.WagonTicket, os.time() + 7 * 24 * 60 * 60)
			npcHandler:say('Aqui esta seu selo. Ele nao pode ser transferido para outra pessoa e durara uma semana a partir de agora. Voce sera avisado ao usar um vagao de minerio quando ele nao for mais valido.', npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, 'no') and npcHandler:getTopic(playerId) > 0 then
		npcHandler:say('Entao nao.', npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

-- Travel
local function addTravelKeyword(keyword, text, cost, discount, destination, condition, action)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = {'Bem, voce pode ser exatamente o heroi que eles precisam la. Para dizer a verdade, algumas das nossas minas de minerio mais confiaveis comecaram a ficar com poucos recursos. ...',
		'E por isso desenvolvemos novas tecnologias de navios a vapor para poder explorar e mapear ainda mais os grandes rios subterraneos. Nossos irmaos estabeleceram uma base em um continente muito, muito distante. ...',
		'Nos chamamos aquele lugar de base distante. Mas como esperamos que um dia se torne uma mina prospera, a maioria de nos comecou a chama-lo de {Farmine}. Os anoes de la realmente precisam de ajuda agora.'
		}
	}, condition, action)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = {text[1]}, cost = cost, discount = discount})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = text[2], cost = cost, discount = discount, destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = text[3], reset = true})
end

addTravelKeyword('anvillux',{'Voce procura uma viagem para Anvillux por |TRAVELCOST|?', 'A todo vapor!', 'Gostariamos de atende-lo em outra ocasiao.'}, 1500, {'postman'}, Position(5447, 4477, 14),
function(player)
	if player:getStorageValue(Storage.Postman.Mission01) == 4 then
		player:setStorageValue(Storage.Postman.Mission01, 5)
	end
end
)

-- addTravelKeyword('gnomprona', {'Voce gostaria de viajar para Gnomprona por |TRAVELCOST|?', 'A todo vapor!', 'Entao nao.'}, 5000, 'postman', Position(5644, 4807, 14))
addTravelKeyword('ilshenar', {'Voce gostaria de viajar para Ilshenar por |TRAVELCOST|?', 'A todo vapor!', 'Entao nao.'}, 5000, 'postman', Position(5369, 5587, 8))
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Voce quer que eu leve voce para {Anvillux} ou para {Ilshenar}?'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo, |PLAYERNAME|! Que a terra proteja voce nos terrenos rochosos. Se precisar de uma {passagem}, posso ajuda-lo.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus entao.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)
