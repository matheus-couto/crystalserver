-- local internalNpcName = "Colbern"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 134,
-- 	lookHead = 114,
-- 	lookBody = 3,
-- 	lookLegs = 0,
-- 	lookFeet = 117,
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

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
-- npcConfig.currency = 27461

-- npcConfig.shop = {
-- 	{ name = "roasted dragon wings", clientId = 9081, buy = 1},
-- 	{ name = "veggie casserole", clientId = 9084, buy = 1},
-- 	{ name = "lemon cupcake", clientId = 28486, buy = 1},
-- 	{ name = "tropical fried terrorbird", clientId = 9082, buy = 1},
-- 	{ name = "svargrond salmon filet", clientId = 29413, buy = 1},
-- 	{ name = "northern fishburger", clientId = 9088, buy = 1},
-- 	{ name = "demonic candy ball", clientId = 11587, buy = 2},
-- 	{ name = "durable exercise sword", clientId = 35279, buy = 2 },
-- 	{ name = "durable exercise club", clientId = 35281, buy = 2 },
-- 	{ name = "durable exercise axe", clientId = 35280, buy = 2 },
-- 	{ name = "durable exercise bow", clientId = 35282, buy = 2 },
-- 	{ name = "durable exercise rod", clientId = 35283, buy = 2 },
-- 	{ name = "durable exercise wand", clientId = 35284, buy = 2 },
-- 	{ name = "experience boost potion", clientId = 11372, buy = 3},
-- }

-- npcHandler:setMessage(MESSAGE_GREET, "Bem vindo ao Porto de Exportacoes de Astralis. Ofereco itens especiais em {troca} de vinho. Diga-me se quiser negociar.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)


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

-- npcType:register(npcConfig)