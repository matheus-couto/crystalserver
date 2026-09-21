-- local internalNpcName = "The Gambler"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
--     lookType = 132,  -- Defina o lookType desejado para o Gambler
--     lookHead = 0,   -- Defina o lookHead desejado para o Gambler
--     lookBody = 57,   -- Defina o lookBody desejado para o Gambler
--     lookLegs = 15,   -- Defina o lookLegs desejado para o Gambler
--     lookFeet = 15,   -- Defina o lookFeet desejado para o Gambler
--     lookAddons = 3
-- }

-- npcConfig.flags = {
--     floorchange = false
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

-- -- Lista de itens oferecidos como "itens misteriosos" para o jogador
-- local tradableItems = {
--     {itemId = 35279, itemName = "Durable Exercise Sword"},
--     {itemId = 35280, itemName = "Durable Exercise Axe"},
--     {itemId = 35281, itemName = "Durable Exercise Club"},
--     {itemId = 35282, itemName = "Durable Exercise Bow"},
--     {itemId = 35283, itemName = "Durable Exercise Rod"},
--     {itemId = 35284, itemName = "Durable Exercise Wand"},
--     {itemId = 10385, itemName = "Zaoan Helmet"},
--     {itemId = 35285, itemName = "Lasting Exercise Sword"},
-- 	{itemId = 35286, itemName = "Lasting Exercise Axe"},
-- 	{itemId = 35287, itemName = "Lasting Exercise Club"},
-- 	{itemId = 35288, itemName = "Lasting Exercise Bow"},
-- 	{itemId = 35289, itemName = "Lasting Exercise Rod"},
-- 	{itemId = 35290, itemName = "Lasting Exercise Wand"},
--     {itemId = 3039, itemName = "Red Gem"},
--     {itemId = 3041, itemName = "Blue Gem"},
--     {itemId = 3038, itemName = "Green Gem"},
--     {itemId = 20138, itemName = "Small Stamina Refill"},
--     {itemId = 3024, itemName = "Holy Falcon"},
--     {itemId = 27648, itemName = "Gnome Armor"},
--     {itemId = 9099, itemName = "Black Candle"},
--     {itemId = 9601, itemName = "Demon Backpack"},
--     {itemId = 3057, itemName = "Amulet of Loss"},
--     {itemId = 16244, itemName = "Music Box"},
--     {itemId = 637, itemName = "Casino Ticket"},
--     {itemId = 8153, itemName = "VIP Ticket"},
--     {itemId = 35279, itemName = "Durable Exercise Sword"},
--     {itemId = 35280, itemName = "Durable Exercise Axe"},
--     {itemId = 35281, itemName = "Durable Exercise Club"},
--     {itemId = 35282, itemName = "Durable Exercise Bow"},
--     {itemId = 35283, itemName = "Durable Exercise Rod"},
--     {itemId = 35284, itemName = "Durable Exercise Wand"},
--     {itemId = 10385, itemName = "Zaoan Helmet"},
--     {itemId = 35285, itemName = "Lasting Exercise Sword"},
-- 	{itemId = 35286, itemName = "Lasting Exercise Axe"},
-- 	{itemId = 35287, itemName = "Lasting Exercise Club"},
-- 	{itemId = 35288, itemName = "Lasting Exercise Bow"},
-- 	{itemId = 35289, itemName = "Lasting Exercise Rod"},
-- 	{itemId = 35290, itemName = "Lasting Exercise Wand"},
--     {itemId = 3039, itemName = "Red Gem"},
--     {itemId = 3041, itemName = "Blue Gem"},
--     {itemId = 3038, itemName = "Green Gem"},
--     {itemId = 20138, itemName = "Small Stamina Refill"},
--     {itemId = 3024, itemName = "Holy Falcon"},
--     {itemId = 27648, itemName = "Gnome Armor"},
--     {itemId = 9099, itemName = "Black Candle"},
--     {itemId = 9601, itemName = "Demon Backpack"},
--     {itemId = 3057, itemName = "Amulet of Loss"},
--     {itemId = 16244, itemName = "Music Box"},
--     {itemId = 637, itemName = "Casino Ticket"},
--     {itemId = 8153, itemName = "VIP Ticket"},
--     {itemId = 20139, itemName = "Full Stamina Refill"},
--     {itemId = 22739, itemName = "Cobra You Desire"},
--     {itemId = 36827, itemName = "Lion You Desire"},
--     {itemId = 31633, itemName = "Falcon You Desire"},
--     {itemId = 35279, itemName = "Durable Exercise Sword"},
--     {itemId = 35280, itemName = "Durable Exercise Axe"},
--     {itemId = 35281, itemName = "Durable Exercise Club"},
--     {itemId = 35282, itemName = "Durable Exercise Bow"},
--     {itemId = 35283, itemName = "Durable Exercise Rod"},
--     {itemId = 35284, itemName = "Durable Exercise Wand"},
--     {itemId = 10385, itemName = "Zaoan Helmet"},
--     {itemId = 35285, itemName = "Lasting Exercise Sword"},
-- 	{itemId = 35286, itemName = "Lasting Exercise Axe"},
-- 	{itemId = 35287, itemName = "Lasting Exercise Club"},
-- 	{itemId = 35288, itemName = "Lasting Exercise Bow"},
-- 	{itemId = 35289, itemName = "Lasting Exercise Rod"},
-- 	{itemId = 35290, itemName = "Lasting Exercise Wand"},
--     {itemId = 3039, itemName = "Red Gem"},
--     {itemId = 3041, itemName = "Blue Gem"},
--     {itemId = 3038, itemName = "Green Gem"},
--     {itemId = 20138, itemName = "Small Stamina Refill"},
--     {itemId = 3024, itemName = "Holy Falcon"},
--     {itemId = 27648, itemName = "Gnome Armor"},
--     {itemId = 9099, itemName = "Black Candle"},
--     {itemId = 9601, itemName = "Demon Backpack"},
--     {itemId = 3057, itemName = "Amulet of Loss"},
--     {itemId = 16244, itemName = "Music Box"},
--     {itemId = 637, itemName = "Casino Ticket"},
--     {itemId = 8153, itemName = "VIP Ticket"},
--     {itemId = 20139, itemName = "Full Stamina Refill"},
--     {itemId = 22739, itemName = "Cobra You Desire"},
--     {itemId = 36827, itemName = "Lion You Desire"},
--     {itemId = 31633, itemName = "Falcon You Desire"},
--     {itemId = 34109, itemName = "Bag You Desire"},

--     -- Adicione mais itens à lista conforme necessário
-- }

-- local waitTimeInDays = 3 -- Tempo de espera em dias antes que o jogador possa tentar novamente

-- local function getPlayerLastTradeTime(player)
--     local lastTradeTime = player:getStorageValue(Storage.Quest.Crandoria.TheGambler.Timer)
--     return lastTradeTime
-- end

-- local function setPlayerLastTradeTime(player)
--     local currentTime = os.time()
--     player:setStorageValue(Storage.Quest.Crandoria.TheGambler.Timer, currentTime)
-- end

-- local function getRandomItemToTrade()
--     -- Escolhe um item aleatório da lista de itens trocáveis
--     local randomIndex = math.random(1, #tradableItems)
--     return tradableItems[randomIndex].itemId -- Retorna o ID do item aleatório
-- end


-- local function handleTradeRequest(npc, player)
--     if getPlayerLastTradeTime(player) == 0 or os.time() - getPlayerLastTradeTime(player) >= waitTimeInDays * 24 * 60 * 60 then
--         local randomItem = getRandomItemToTrade()
--         -- player:setStorageValue("Gambler_RandomItem", randomItem) -- Armazena o item escolhido nas informações do jogador
--         npcHandler:say("Do you want to try your luck and trade for a mystery item for 5,000,000 gold coins?", npc, player)
--         npcHandler:setTopic(player:getId(), 1)
--     else
--         npcHandler:say("Come back in " .. waitTimeInDays .. " days to try your luck again.", npc, player)
--     end
-- end

-- local function handleConfirmation(npc, player)
--     local playerGold = player:getMoney()
--     if playerGold >= 5000000 then
--         -- local randomItem = player:getStorageValue("Gambler_RandomItem")
--         local randomItem = getRandomItemToTrade()
--         if randomItem then
--             player:removeMoney(5000000) -- Remove 5,000,000 gold coins
--             -- player:addItem(randomItem) -- Remove o item misterioso do jogador
--             if randomItem == 35279 or randomItem == 35280 or randomItem == 35281 or randomItem == 35282 or randomItem == 35283 or randomItem == 35284 then
--                 player:addItem(randomItem, 1800) -- Remove o item misterioso do jogador
--                 npcHandler:resetNpc(player:getId())
--                 -- randomItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, 1800)
--             elseif randomItem == 35285 or randomItem == 35286 or randomItem == 35287 or randomItem == 35288 or randomItem == 35289 or randomItem == 35290 then 
--                 player:addItem(randomItem, 14400) -- Remove o item misterioso do jogador
--                 npcHandler:resetNpc(player:getId())
--                 -- randomItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, 14400)
--             else
--                 player:addItem(randomItem) -- Remove o item misterioso do jogador
--             end
--             setPlayerLastTradeTime(player) -- Registra o tempo da última troca
--             -- player:setStorageValue("Gambler_RandomItem", 0) -- Limpa as informações do item misterioso
--             npcHandler:say("Here's your mystery item! Good luck!", npc, player)
--             npcHandler:resetNpc(player:getId())
--         else
--             npcHandler:say("I'm sorry, but it seems there was an issue with the trade. Please try again.", npc, player)
--             npcHandler:resetNpc(player:getId())
--         end
--     else
--         npcHandler:say("Sorry, you don't have enough gold coins for the trade.", npc, player)
--         npcHandler:resetNpc(player:getId())
--     end
--     npcHandler:resetNpc(player:getId())
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

--     if MsgContains(message, 'gamble') then
--         handleTradeRequest(npc, player)
--     elseif MsgContains(message, 'yes') and npcHandler:getTopic(player:getId()) == 1 then
--         handleConfirmation(npc, player)
--     elseif MsgContains(message, 'no') and npcHandler:getTopic(player:getId()) == 1 then
--         npcHandler:say("Alright, come back anytime!", npc, player)
--         npcHandler:resetNpc(player:getId())
--     end
--     return false
-- end

-- keywordHandler:addKeyword({"trade"}, StdModule.say,
--     {
--         npcHandler = npcHandler,
--         text = "This is not a market, dear adventurer. \z
--                 But you know... if you have some money with you and you are interested in a {gamble} we can talk. <sigh>"
--     }
-- )

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcConfig.shop = {}

-- npcType:register(npcConfig)
