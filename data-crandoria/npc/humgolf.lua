-- local internalNpcName = "Humgolf"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 160,
-- 	lookHead = 0,
-- 	lookBody = 127,
-- 	lookLegs = 97,
-- 	lookFeet = 114,
--     	lookAddons = 3,
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

-- local chance = math.random(1, 10)

-- local chancePeas = math.random(5000, 10000)
-- local chanceAubergine = math.random(10000, 16000)
-- local chanceDragonfruit = math.random(35000, 80000)
-- local chanceEldritch = math.random(100000, 300000)
-- local chanceWood = math.random(100000, 200000)
-- local chanceSpectral = math.random(40000000, 50000000)
-- local chanceGlass = math.random(5000, 10000)
-- local chanceCobalt = math.random(75000, 100000)

-- local chanceFreshFruits = math.random(5000, 10000)
-- local chancePineapple = math.random(10000, 16000)
-- local chanceDragonfruit = math.random(25000, 40000)
-- local chanceSpectral = math.random(25000000, 35000000)


-- local function onTradeRequest(npc, creature)
-- 	if Player(creature):getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso) < 13 then
-- 		npcHandler:say('Apenas membros da Sociedade de Astralis podem negociar itens aqui.', npc, creature)
-- 		return false
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)

-- if chance == 1 then
-- 	npcConfig.shop = {
-- 		{ itemName = "peas", clientId = 11683, buy = chancePeas },
-- 	}
-- elseif chance == 2 then
-- 	npcConfig.shop = {
-- 		{ itemName = "aubergine", clientId = 11460, buy = chanceAubergine },
-- 	}	
-- elseif chance == 3 then
-- 	npcConfig.shop = {
-- 		{ itemName = "dragonfruit", clientId = 11682, buy = chanceDragonfruit },
-- 	}	
-- elseif chance == 4 then
-- 	npcConfig.shop = {
-- 		{ itemName = "eldritch fragment", clientId = 4061, buy = chanceEldritch },
-- 	}	
-- elseif chance == 5 then
-- 	npcConfig.shop = {
-- 		{ itemName = "pieces of wood", clientId = 32002, buy = chanceWood },
-- 	}
-- elseif chance == 6 then
-- 	npcConfig.shop = {
-- 		{ itemName = "spectral gem", clientId = 39039, buy = chanceSpectral },
-- 	}
-- elseif chance == 7 then
-- 	npcConfig.shop = {
-- 		{ itemName = "blue glass plate", clientId = 29345, buy = chanceGlass },
-- 	}
-- elseif chance == 8 then
-- 	npcConfig.shop = {
-- 		{ itemName = "green glass plate", clientId = 29346, buy = chanceGlass },
-- 	}
-- elseif chance == 9 then
-- 	npcConfig.shop = {
-- 		{ itemName = "violet glass plate", clientId = 29347, buy = chanceGlass },
-- 	}
-- elseif chance == 10 then
-- 	npcConfig.shop = {
-- 		{ itemName = "chanceCobalt", clientId = 39037, buy = chanceCobalt },
-- 	}
-- end



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

-- npcHandler:setMessage(MESSAGE_GREET, '|PLAYERNAME|, bem vindo! Por favor, de uma olhada na oferta do dia.')
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
