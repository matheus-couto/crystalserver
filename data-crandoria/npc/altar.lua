local internalNpcName = "Altar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 43845,
}

npcConfig.flags = {
	floorchange = false,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	message = message:lower()
	if MsgContains(message, "kneel") then
		npcHandler:say("Prepare your offer and cling to the sanctitity of this place.", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "offer") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Five tainted hearts and five darklight hearts drowned in a worldly wealth of 50000000 gold pieces for the righteous. Are you prepared?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		npcHandler:setTopic(playerId, 0)
		if player:getItemCount(43855) < 5 or player:getItemCount(43854) < 5 then
			npcHandler:say("Sorry, you don't have all items.", npc, creature)
			return true
		end

		if not player:removeMoneyBank(50000000) then
			npcHandler:say("Sorry, you don't have enough gold.", npc, creature)
			return true
		end

		if player:removeItem(43855, 5) and player:removeItem(43854, 5) then
			player:addItem(BAG_YOU_COVET, 1)
			npcHandler:say("Your sacrifice has been accepted, mortal. Embrace your reward!", npc, creature)
		end
	elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:setTopic(playerId, 0)
		npcHandler:say("Ok then not.", npc, creature)
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Kneel before the all-devouring power of blooded decay.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)


-- local internalNpcName = "Altar"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 0
-- npcConfig.walkRadius = 0

-- npcConfig.outfit = {
-- 	lookTypeEx = 43845,
-- }

-- local keywordHandler = KeywordHandler:new()
-- local npcHandler = NpcHandler:new(keywordHandler)

-- npcType.onThink = function(npc, interval)
--     npcHandler:onThink(npc, interval)
-- end

-- npcType.onAppear = function(npc, creature)
--     npcHandler:onAppear(npc, creature)
-- end

-- npcType.onDisappear = function(npc, creature)
--     npcHandler:onDisappear(npc, creature)
-- end

-- npcType.onMove = function(npc, creature, fromPosition, toPosition)
--     npcHandler:onMove(npc, creature, fromPosition, toPosition)
-- end

-- npcType.onSay = function(npc, creature, type, message)
--     npcHandler:onSay(npc, creature, type, message)
-- end

-- npcType.onCloseChannel = function(npc, creature)
--     npcHandler:onCloseChannel(npc, creature)
-- end

-- local function creatureSayCallback(npc, creature, type, message)
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end

--     if MsgContains(message, "offer") or MsgContains(message, "oferta") then
--         npcHandler:say("5 tainted hearts e 5 darklight hearts mergulhados em uma riqueza de 50.000.000 moedas de ouro. Voce esta preparado?", npc, creature)
--         npcHandler:setTopic(playerId, 1)
--     elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
--         if npcHandler:getTopic(playerId) == 1 then
--             if player:getItemCount(43854) < 5
--             or player:getItemCount(43855) < 5
--             or player:getMoney() + player:getBankBalance() < 50000000 then
--                 npcHandler:say("Voce acha que pode enganar Altar?", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             else
--                 player:removeItem(43854, 5)
--                 player:removeItem(43855, 5)
--                 player:removeMoneyBank(50000000)
--                 player:addItem(43895, 1, true)
--                 npcHandler:say("Aqui esta, mortal. Sua recompensa.", npc, creature)
--                 npcHandler:setTopic(playerId, 0)
--             end
--         end
--     elseif MsgContains(message, "no") or MsgContains(message, "nao") then
--         if npcHandler:getTopic(playerId) == 1 then
--             npcHandler:say("Entao o que faz aqui, mortal insolente?", npc, creature)
--         elseif npcHandler:getTopic(playerId) == 2 then
--             npcHandler:say("Entao o que faz aqui, mortal insolente?", npc, creature)
--         end
--         npcHandler:setTopic(playerId, 0)
--         return true
--     end
-- end

-- keywordHandler:addKeyword({"curvar"}, StdModule.say,
-- {
--     npcHandler = npcHandler,
--     text = "Prepare sua {oferta} e agarre-se a santidade deste local!"
-- }
-- )

-- npcHandler:setMessage(MESSAGE_GREET, "Acredito que nao preciso pedir para um mero mortal se {curvar} diante de mim.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, mortal.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, mortal.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType:addDialogOptions("oferta", "bye")
-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
