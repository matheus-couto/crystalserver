local internalNpcName = "Captain Whitepatch"
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
	lookHead = 2,
	lookBody = 67,
	lookLegs = 39,
	lookFeet = 76,
	lookAddons = 1
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Passagens para Astralis, Crandoria, Elvenshire, Hakata, Nivabi, Icehold, Squidspot, Nagaeth, Roshamuul, Valkesh e Warmwind.'}
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
    
    local storage = player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso)
    local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Timer)

    if MsgContains(message, "passage") or MsgContains(message, "destino") or MsgContains(message, "viagem") then
		npcHandler:say("Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??", npc, creature)
        npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "crandoria") then
		npcHandler:say("Posso te levar para Crandoria por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "astralis") then
		npcHandler:say("Posso te levar para Astralis por 1500 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "squidspot") then
		npcHandler:say("Posso te levar para Squidspot por 1500 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 3)
	elseif MsgContains(message, "hakata") then
		npcHandler:say("Posso te levar para Hakata por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, "warmwind") then
		npcHandler:say("Posso te levar para Warmwind por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 5)
	elseif MsgContains(message, "valkesh") then
		npcHandler:say("Posso te levar para Valkesh por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 6)
	elseif MsgContains(message, "elvenshire") then
		npcHandler:say("Posso te levar para Elvenshire por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 7)
	elseif MsgContains(message, "nivabi") then
		npcHandler:say("Posso te levar para Nivabi por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 8)
	elseif MsgContains(message, "nagaeth") then
		npcHandler:say("Posso te levar para Nagaeth por 1500 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 9)
	elseif MsgContains(message, "roshamuul") then
		npcHandler:say("Posso te levar para Roshamuul por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 10)	
	elseif MsgContains(message, "icehold") then
		npcHandler:say("Posso te levar para Roshamuul por 750 gold coins. Podemos partir?", npc, creature)
        npcHandler:setTopic(playerId, 11)	
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(4970, 5073, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(4970, 5073, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(1500) then
					player:teleportTo(Position(4661, 4572, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(4661, 4572, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(1500) then
					player:teleportTo(Position(5333, 4308, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5333, 4308, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5618, 5095, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5618, 5095, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5837, 5479, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5837, 5479, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5286, 4672, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5286, 4672, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(4751, 4823, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(4751, 4823, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5733, 4501, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5733, 4501, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 9 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(1500) then
					player:teleportTo(Position(5942, 4416, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5942, 4416, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 10 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5824, 5240, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5824, 5240, 7))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif npcHandler:getTopic(playerId) == 11 then
			if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) < 10 then
				if player:removeMoneyBank(750) then
					player:teleportTo(Position(5095, 5378, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					npcHandler:setTopic(playerId, 0)	
				else
					npcHandler:say("Voce nao possui dinheiro suficiente.", npc, creature)
					npcHandler:setTopic(playerId, 0)	
				end
			else
				player:teleportTo(Position(5095, 5378, 6))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end
end

-- addTravelKeyword('astralis', 15000, Position(4660, 4574, 6))
-- addTravelKeyword('hakata', 750, Position(5621, 5097, 6))
-- addTravelKeyword('valkesh', 750, Position(5290, 4672, 6))
-- addTravelKeyword('elvenshire', 750, Position(4749, 4824, 6))
-- addTravelKeyword('icehold', 750, Position(5094, 5380, 6))
-- addTravelKeyword('nivabi', 750, Position(5733, 4750, 6))
-- addTravelKeyword('warmwind', 750, Position(5838, 5477, 6))
-- addTravelKeyword('roshamuul', 750, Position(5824, 5242, 7))
-- addTravelKeyword('squidspot', 1500, Position(5336, 4310, 6))
-- addTravelKeyword('nagaeth', 1500, Position(5942, 4415, 6))


-- -- Travel
-- local function addTravelKeyword(keyword, cost, destination, action, condition)
-- 	if condition then
-- 		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
-- 	end

-- 	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
-- 	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
-- 	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
-- end

-- addTravelKeyword('crandoria', 750, Position(4970, 5072, 6),
-- function(player)
-- 	if player:getStorageValue(Storage.Postman.Mission01) == 1 then
-- 		player:setStorageValue(Storage.Postman.Mission01, 2)
-- 	end
-- end)

-- addTravelKeyword('astralis', 15000, Position(4660, 4574, 6))
-- addTravelKeyword('hakata', 750, Position(5621, 5097, 6))
-- addTravelKeyword('valkesh', 750, Position(5290, 4672, 6))
-- addTravelKeyword('elvenshire', 750, Position(4749, 4824, 6))
-- addTravelKeyword('icehold', 750, Position(5094, 5380, 6))
-- addTravelKeyword('nivabi', 750, Position(5733, 4750, 6))
-- addTravelKeyword('warmwind', 750, Position(5838, 5477, 6))
-- addTravelKeyword('roshamuul', 750, Position(5824, 5242, 7))
-- addTravelKeyword('squidspot', 1500, Position(5336, 4310, 6))
-- addTravelKeyword('nagaeth', 1500, Position(5942, 4415, 6))


-- -- Basic
-- keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Captain Whitepatch from the Royal Tibia Line.'})
-- keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
-- keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
-- keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
-- keywordHandler:addKeyword({'line'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
-- keywordHandler:addKeyword({'company'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
-- keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'The Royal Tibia Line connects all seaside towns of Tibia.'})
-- keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = 'We can transport everything you want.'})
-- keywordHandler:addKeyword({'passenger'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to welcome you on board.'})
-- keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})
-- keywordHandler:addKeyword({'passagem'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde deseja ir? Minhas rotas incluem {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}.'})
-- keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = 'Para onde voce gostaria de ir? {Crandoria}, {Astralis}, {Squidspot}, {Hakata}, {Warmwind}, {Valkesh}, {Elvenshire}, {Nivabi}, {Nagaeth}, {Roshamuul} ou {IceHold}??'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem vindo a bordo, |PLAYERNAME|. Posso te levar para varios lugares, basta pedir por uma {passagem}!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus. Recomende meus servicos a alguns de seus amigos.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Ate mais.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("passage", "bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)

