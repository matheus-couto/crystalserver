local internalNpcName = "Hidden Nah'Bob"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 80
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

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end


	if MsgContains(message, 'cookie') then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 31
				and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Djinn) ~= 1 then
			npcHandler:say('You brought cookies! How nice of you! Can I have one?', npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, 'yes') then
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeItem(130, 1) then
				npcHandler:say('You have no cookie that I\'d like.', npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Djinn, 1)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement('Allow Cookies?')
			end

			npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say('You see, good deeds like this will ... YOU ... YOU SPAWN OF EVIL! I WILL MAKE SURE THE MASTER LEARNS ABOUT THIS!', npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		end
	elseif MsgContains(message, 'no') then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say('I see.', npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

-- local function onTradeRequest(npc, creature)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission03) ~= 3 then
-- 		npcHandler:say('I\'m sorry, human. But you need Gabel\'s permission to trade with me.', npc, creature)
-- 		return false
-- 	end

-- 	return true
-- end

npcHandler:setMessage(MESSAGE_GREET, "<Sighs> Another {customer}! I've only just sat down! What is it, |PLAYERNAME|?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye now, Neutrala |PLAYERNAME|. Visit old Bob again one day!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye then.")
npcHandler:setMessage(MESSAGE_SENDTRADE, 'At your service, just browse through my wares.')

npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "angelic axe", clientId = 7436, sell = 4000 },
	{ itemName = "blue robe", clientId = 3567, sell = 8000 },
	{ itemName = "bonelord shield", clientId = 3418, buy = 7000, sell = 960 },
	{ itemName = "boots of haste", clientId = 3079, sell = 24000 },
	{ itemName = "broadsword", clientId = 3301, sell = 400 },
	{ itemName = "butcher's axe", clientId = 7412, sell = 14400 },
	{ itemName = "crown armor", clientId = 3381, sell = 9600 },
	{ itemName = "crown helmet", clientId = 3385, sell = 2000 },
	{ itemName = "crown legs", clientId = 3382, sell = 9600 },
	{ itemName = "crown shield", clientId = 3419, sell = 6400 },
	{ itemName = "crusader helmet", clientId = 3391, sell = 4800 },
	{ itemName = "dragon lance", clientId = 3302, sell = 7200 },
	{ itemName = "dragon shield", clientId = 3416, sell = 3200 },
	{ itemName = "fire axe", clientId = 3320, sell = 6400 },
	{ itemName = "fire sword", clientId = 3280, sell = 3200 },
	{ itemName = "glorious axe", clientId = 7454, sell = 2400 },
	{ itemName = "guardian shield", clientId = 3415, sell = 1600 },
	{ itemName = "ice rapier", clientId = 3284, sell = 800 },
	{ itemName = "noble armor", clientId = 3380, buy = 8000, sell = 720 },
	{ itemName = "obsidian lance", clientId = 3313, buy = 3000, sell = 400 },
	{ itemName = "phoenix shield", clientId = 3439, sell = 12800 },
	{ itemName = "queen's sceptre", clientId = 7410, sell = 16000 },
	{ itemName = "royal helmet", clientId = 3392, sell = 24000 },
	{ itemName = "shadow sceptre", clientId = 7451, sell = 8000 },
	{ itemName = "spike sword", clientId = 3271, buy = 8000, sell = 800 },
	{ itemName = "thaian sword", clientId = 7391, sell = 12800 },
	{ itemName = "war hammer", clientId = 3279, buy = 10000, sell = 960 }
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:addDialogOptions("trade", "bye")
npcType:register(npcConfig)
