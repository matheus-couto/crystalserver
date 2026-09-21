local internalNpcName = "Anna"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1576,
	lookHead = 114,
	lookBody = 71,
	lookLegs = 71,
	lookFeet = 66,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.light = {
	level = 0,
	color = 0,
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = "Pronto para partir rumo a Crandoria?" },
	{ text = "Nao tenha medo. Seu destino te espera em Crandoria!" },
}

npcType:speechBubble(SPEECHBUBBLE_TRAVELER)

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

local TARGUNA_DESTINATION = Position(5000, 5000, 6)
local MIN_LEVEL_TO_TRAVEL = 8

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	if not player then
		return true
	end

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local playerId = player:getId()

	if MsgContains(message, "passagem") or MsgContains(message, "passage") then
		if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
			npcHandler:say("Voce precisa possuir nivel " .. MIN_LEVEL_TO_TRAVEL .. " para viajar para Crandoria. Continue treinando!", npc, creature)
			return true
		end

		npcHandler:say("Posso te levar a Crandoria agora mesmo. Esta tudo pronto para a viagem?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") then
		if player:getLevel() < MIN_LEVEL_TO_TRAVEL then
			npcHandler:say("Voce precisa possuir nivel " .. MIN_LEVEL_TO_TRAVEL .. " para viajar.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			return true
		end

		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Muito bem, entao vamos a Crandoria!", npc, creature)
			player:teleportTo(TARGUNA_DESTINATION)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

			player:setStorageValue(Storage.Quest.U15_12.newhavenCitizen, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenTutorialHunting, -1)
			player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, -1)

			player:setTown(Town(TOWNS_LIST.CRANDORIA))

			player:setStorageValue(Storage.Dawnport.Mainland, 1)
			-- Liquid Black   
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
			
			-- Bigfoot's Burden
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 23)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLineComplete, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Rank, 1440)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone1Access, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone2Access, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone3Access, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.WarzoneStatus, 1)

			-- WZ 4, 5 e 6
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Questline, 10)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneVI, 10)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneV, 10)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneIV, 30)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Status, 10)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Status, 10)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Status, 10)	

			--In Service of Yalahar 
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Questline, 51)


			-- --Rashid
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled, 1)    
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.HorrorKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled, 1)
			player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessMachine, 1)

			-- Factions
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Marid, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Efreet, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.MaridDoor, 1)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.EfreetDoor, 1)
			-- Efreet
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Start, 1)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission01, 3)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission02, 3)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03, 3)
			-- Marid
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Start, 1)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission01, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission02, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.RataMari, 2)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission03, 3)


			-- The Inquisition
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 14)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission01, 7)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission02, 3)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission03, 6)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.GrofGuard, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.KulagGuard, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.TimGuard, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.WalterGuard, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.StorkusVampiredust, 1)

			-- The Shattered Isles
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.DefaultStart, 3)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheGovernorDaughter, 3)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheErrand, 2)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToMeriana, 1)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.APoemForTheMermaid, 3)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ADjinnInLove, 5)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToLagunaIsland, 1)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToGoroma, 1)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.Shipwrecked, 2)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.DragahsSpellbook, 1)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheCounterspell, 4)

			-- The Ultimate Challenges Quest.
			player:setStorageValue(Storage.Quest.U8_0.BarbarianArena.QuestLogGreenhorn, 1)

			-- Tibia Tales.
			player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
			player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)

			-- Friends and Traders
			player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.DefaultStart, 1)
			player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheMermaidMarina, 2)
			player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake, 12)				

			-- Wrath of the Emperor
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline, 30)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission01, 3)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission02, 3)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission06, 4)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission07, 6)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission08, 2)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission09, 2)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission10, 6)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11, 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.BossStatus, 5)

			-- The Ape City Quest.
			player:setStorageValue(Storage.Quest.U7_6.TheApeCity.Started, 1)
			player:setStorageValue(Storage.Quest.U7_6.TheApeCity.Questline, 17)

			-- Dangerous Depths.
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Questline, 1)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Home, 2)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Subterranean, 2)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Measurements, 2)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Ordnance, 3)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Charting, 2)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Growth, 2)
			player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Diremaw, 2)

			-- Threatened Dreams
			player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Start, 1)
			player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TroubledMission01, 4)
			player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TroubledMission01, 17)		
			player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TatteredSwanFeathers, 5)

			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) >= 1 then
			npcHandler:say("Sem problemas. Volte quando sentir que chegou a sua hora!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, nobre viajante. Se estiver buscando por uma {passagem} para Crandoria, esta no lugar certo!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Cuide-se!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("passage", "bye")

npcType:register(npcConfig)
