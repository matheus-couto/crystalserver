local internalNpcName = "Suzsh the Hive Queen"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 14049,
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

    local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestHiveQueen.Progresso)
	local cooldown = player:getStorageValue(Storage.Quest.Crandoria.QuestHiveQueen.Timer)

    if MsgContains(message, "mission") or MsgContains(message, "missao") then
		if player:getLevel() < 400 then
			npcHandler:say("Muito fraco... Retorne apos o nivel 400.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		else
			if storage < 1 then
				npcHandler:say("~shhk~ ~chrrk~ Ovos de insetos... ~chhk~ ~chhk~ S-Spidris Elite... swush... swush... 3 Ovos... squik... S-Sim?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif storage == 1 then
				npcHandler:say("~chhk~ ~chhk~ 3 Ovos?...", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif storage >= 2 then
				if cooldown < os.time() then
					npcHandler:say("~shhk~ ~chrrk~ Winterberries... ~chhk~ ~chhk~ 3 Winterberries... swush... swush... 1 B-Bestiary B-Betterment... squik... S-Sim?", npc, creature)
					npcHandler:setTopic(playerId, 3)
				else
					npcHandler:say("~shhk~ ~chrrk~ 5 dias ~swuush~ Winterberries.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			end
		end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") then
        if npcHandler:getTopic(playerId) == 1 then
            npcHandler:say("~swushh~ C-Certo! ~Chhk~ Espero.", npc, creature)
            player:setStorageValue(Storage.Quest.Crandoria.QuestHiveQueen.Progresso, 1)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getItemCount(9156) >= 3 then
				player:removeItem(9156, 3)
				npcHandler:say("~SHHHK~ Confiar agora! ~CHRRK~ ~CHRRK~ Nova {missao}...", npc, creature)
            	player:setStorageValue(Storage.Quest.Crandoria.QuestHiveQueen.Progresso, 2)
				player:addItem(3043, 10)
				player:addExperience(1000000)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("~CHRRK~ Nao ovos! ~CHRRK~", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:getItemCount(12252) >= 3 then
				player:removeItem(12252, 3)
				player:addItem(36728, 1)
				npcHandler:say("~SHHHK~ Confiar agora! ~CHRRK~ ~CHRRK~ Nova {missao}...", npc, creature)
            	player:setStorageValue(Storage.Quest.Crandoria.QuestHiveQueen.Timer, os.time() + 5 * 24 * 60 * 60)
				player:addItem(3043, 10)
				player:addExperience(1000000)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("~CHRRK~ Nao ovos! ~CHRRK~", npc, creature)
                npcHandler:setTopic(playerId, 0)
			end
		end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "~SRHHT~ HUMANO! ~SHHNK~")
npcHandler:setMessage(MESSAGE_FAREWELL, "~SRHHT~")
npcHandler:setMessage(MESSAGE_WALKAWAY, "~SHHNK~")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcConfig.shop = {
-- 	{ itemName = "bottle of water", clientId = 2875, buy = 2, count = 1 },
-- 	{ itemName = "bread", clientId = 3600, buy = 2 },
-- 	{ itemName = "cake", clientId = 6277, buy = 50 },
-- 	{ itemName = "cheese", clientId = 3607, buy = 4 },
-- 	{ itemName = "cookie", clientId = 3598, buy = 2 },
-- 	{ itemName = "egg", clientId = 3606, buy = 2 },
-- 	{ itemName = "fish", clientId = 3578, buy = 5 },
-- 	{ itemName = "green flask of wine", clientId = 2877, buy = 3, count = 2 },
-- 	{ itemName = "ham", clientId = 3582, buy = 6 },
-- 	{ itemName = "meat", clientId = 3577, buy = 3 },
-- 	{ itemName = "roll", clientId = 3601, buy = 2 },
-- 	{ itemName = "salmon", clientId = 3579, buy = 6 },
-- 	{ itemName = "valentine's cake", clientId = 6392, buy = 100 },
-- 	{ itemName = "white mushroom", clientId = 3723, buy = 6 }
-- }

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

npcType:addDialogOptions("bye")
npcType:register(npcConfig)
