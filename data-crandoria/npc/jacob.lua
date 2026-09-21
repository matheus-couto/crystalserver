local internalNpcName = "Jacob"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 574,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3
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

	if (MsgContains(message, "missao")) or (MsgContains(message, "mission")) then
		if player:getStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso) == 3 then
			npcHandler:say("O que? Elliot te mandou trazer comida? HA! Aquele idiota... Ele sempre foi um medroso. Me deixa adivinhar... Disse que ficaria de guarda?", npc, creature)
			npcHandler:say("Hahaha... Voce foi enganado. Mas nao se preocupe, se conheco bem o Elliot, ele te ofereceu uma recompensa por isso. Ele cumprira com sua palavra, acredite. \z
			E entao... ele sempre me traz 10 meats. voce trouxe toda a comida?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif (MsgContains(message, "yes")) or (MsgContains(message, "sim")) then
		if npcHandler:getTopic(playerId) == 1 then
			if player:getItemCount(3577) >= 10 then
				player:removeItem(3577, 10)
				player:addItem(3028, 1)
				npcHandler:say("Sensacional! Eu estava mesmo ficando sem suprimentos. Diga a Elliot que eu agradeci. E fale para ele criar um pouco de verognha na cara! HA HA HA! \z
				Ah! Ja ia me esquecendo. Entregue a ele este pequeno diamante. Vai ajudar a confirmar que voce me encontrou, caso ele fique desconfiado.", npc, creature)
				player:setStorageValue(Storage.Quest.Crandoria.GloothAddon.Progresso, 4)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("Mas onde estao as 10 meats?...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)



-- local internalNpcName = "Jacob"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 574,
-- 	lookHead = 114,
-- 	lookBody = 114,
-- 	lookLegs = 114,
-- 	lookFeet = 114,
-- 	lookAddons = 3
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

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	-- Mission 3 start
-- 	if(MsgContains(message, "abandoned sewers")) then
-- 		if player:getStorageValue(Storage.Oramond.MissionAbandonedSewer) < 21 then
-- 			npcHandler:say("You want to enter the abandoned sewers? That's rather dangerous and not a good idea, man. That part of the sewers was not sealed off for nothing, you know? ...", npc, creature)
-- 			npcHandler:say("But hey, it's your life, bro. So here's the deal. I'll let you into the abandoned sewers if you help me with our {mission}.", npc, creature)
-- 		-- Mission 3 end
-- 		elseif player:getStorageValue(Storage.Oramond.MissionAbandonedSewer) == 21 then
-- 			npcHandler:say("Wow, you already did it, that's fast. I'm used to a more laid-back attitude from most people. It's a shame to risk losing you to some collapsing tunnels, but a deal is a deal. ...", npc, creature)
-- 			npcHandler:say("I hereby grant you the permission to enter the abandoned part of the sewers. Take care, man! ...", npc, creature)
-- 			npcHandler:say("If you find something interesting, come back to talk about the {abandoned sewers}.", npc, creature)
-- 			npcHandler:setTopic(playerId, 7)
-- 			player:setStorageValue(Storage.DarkTrails.Mission04, 1)
-- 			player:setStorageValue(Storage.Oramond.DoorAbandonedSewer, 1)
-- 		elseif player:getStorageValue(Storage.DarkTrails.Mission05) == 1 then
-- 			npcHandler:say("I'm glad to see you back alive and healthy. Did you find anything interesting that you want to {report}?", npc, creature)
-- 			npcHandler:setTopic(playerId, 7)
-- 		end
-- 	-- Mission 3 start
-- 	elseif(MsgContains(message, "mission")) then
-- 		if(npcHandler:getTopic(playerId) == 0) then
-- 			npcHandler:say("The sewers need repair. You in?", npc, creature)
-- 			npcHandler:setTopic(playerId, 2)
-- 		-- Mission 3 end
-- 		elseif player:getStorageValue(Storage.DarkTrails.Mission03) == 1 then
-- 			npcHandler:say("Elliott's keeps calling it that. It's just another job! You fixed some broken pipes and stuff? Let me check, {ok}?", npc, creature)
-- 			npcHandler:setTopic(playerId, 3)
-- 		end
-- 	-- Mission 3 start - sewer access
-- 	elseif(MsgContains(message, "yes")) then
-- 		if(npcHandler:getTopic(playerId) == 2) then
-- 			npcHandler:say("Good. Broken pipe and generator pieces, there's smoke evading. That's how you recognise them. See how you can fix them using your hands. Need about, oh, twenty of them at least repaired. Report to me or Jacob", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 			player:setStorageValue(Storage.Oramond.AbandonedSewer, 1)
-- 			player:setStorageValue(Storage.Oramond.MissionAbandonedSewer, 0)
-- 		end
-- 	-- Task: The Ancient Sewers
-- 	elseif(MsgContains(message, "ok")) then
-- 		if(npcHandler:getTopic(playerId) == 3) then
-- 			npcHandler:say("Good. Thanks, man. That's one vote you got for helping us with this.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 			player:setStorageValue(Storage.Oramond.MissionAbandonedSewer, 21) -- Mission 3 end
-- 		end
-- 	-- Final mission 5
-- 	elseif(MsgContains(message, "report")) then
-- 		if player:getStorageValue(Storage.DarkTrails.Mission05) == 1 then
-- 			if(npcHandler:getTopic(playerId) == 7) then
-- 				npcHandler:say("A sacrificial site? Damn, sounds like some freakish cult or something. Just great. And this ancient structure you talked about that's not part of the sewers? You'd better see the local historian about that, man. ...", npc, creature)
-- 				npcHandler:say("He can make more sense of what you found there. His name is Barazbaz. He should be in the magistrate building.", npc, creature)
-- 				player:setStorageValue(Storage.DarkTrails.Mission06, 1) -- Start mission 6
-- 				npcHandler:setTopic(playerId, 0)
-- 			else npcHandler:say("You already reported this mission, go to the next.", npc, creature)
-- 			end
-- 		end
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
