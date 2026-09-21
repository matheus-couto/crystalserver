-- local internalNpcName = "Captain Dreadnought"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 2000
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 155,
-- 	lookHead = 96,
-- 	lookBody = 0,
-- 	lookLegs = 78,
-- 	lookFeet = 96,
-- 	lookAddons = 1
-- }

-- npcConfig.flags = {
-- 	floorchange = false
-- }

-- npcConfig.voices = {
-- 	interval = 15000,
-- 	chance = 50,
-- 	{text = "No smuggling aboard this ship! Only 20 pieces of any creature product allowed!"},
-- 	{text = "No fear! The Sea Cat will ship you safely to the mainland!"},
-- 	{text = "All aboard! Prepare to sail!"},
-- 	{text = "Come hell or high water, we'll reach any port I sail you to!"},
-- 	{text = "This island is too small. I need sea water around me."}
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

-- -- List of all towns to ask about and to sail to
-- local towns = {
--     [TOWNS_LIST.CRANDORIA] = {
--         name = "Crandoria",
--         about = {
--             "Welcome to Crandoria, a land of magic and wonders! Come explore our enchanting forests and ancient ruins.",
--             "Be cautious of the mystical creatures that inhabit our realm."
--         },
--         canBeSailed = true,
--         isPremium = false,
--         message = "So you've chosen Crandoria as your new home?",
--         destination = {x = 5004, y = 5003, z = 6} -- Coordenadas da cidade Crandoria
--     },
--     [TOWNS_LIST.HAKATA] = {
--         name = "Hakata",
--         about = {
--             "Greetings, traveler! Hakata is a bustling city in the midle of nature.",
--             "You'll find all sorts of goods and services here, fit for an adventurer like yourself."
--         },
--         canBeSailed = true,
--         isPremium = true,
--         message = "So you've chosen Hakata as your new home?",
--         destination = {x = 5563, y = 5112, z = 7} -- Coordenadas da cidade Hakata
--     },
--     [TOWNS_LIST.ELVENSHIRE] = {
--         name = "Elvenshire",
--         about = {
--             "Welcome to Elvenshire, the land of the elves! Our city is hidden within the lush forests.",
--             "Explore the beauty of nature and hone your skills as an adventurer."
--         },
--         canBeSailed = true,
--         isPremium = false,
--         message = "So you've chosen Elvenshire as your new home?",
--         destination = {x = 4674, y = 4783, z = 8} -- Coordenadas da cidade Elvenshire
--     },
-- }

-- local defaultTown = TOWNS_LIST.CRANDORIA
-- local townNames = {all = "", free = "", premium = ""}

-- -- Function to build town names strings and adds additional data to sailable/premium towns about
-- local function buildStrings()
-- 	local townsList = {all = {}, free = {}, premium = {}}
-- 	for id, town in pairs(towns) do
-- 		if town.canBeSailed then
-- 			if town.isPremium then
-- 				table.insert(townsList.premium, "{" .. town.name .. "}")
-- 				town.about[1] = "Only for {premium} travellers! " .. town.about[1]
-- 			else
-- 				table.insert(townsList.premium, "{" .. town.name .. "}")
-- 				table.insert(townsList.free, "{" .. town.name .. "}")
-- 			end
-- 			town.about[#town.about] = town.about[#town.about] .. " I can {sail} there if you like."
-- 		end
-- 		table.insert(townsList.all, "{" .. town.name .. "}")
-- 	end
-- 	for list, townList in pairs(townsList) do
-- 		if #townList == 1 then
-- 			townNames[list] = townList[1]
-- 		elseif #townList > 1 then
-- 			table.sort(townList, function(a, b) return a:upper() < b:upper() end)
-- 			local lastTown = table.remove(townList, #townList)
-- 			townNames[list] = table.concat(townList, ", ")  .. " or " .. lastTown
-- 		end
-- 	end
-- end

-- buildStrings()

-- -- Function to handle donations and its messages
-- local function donationHandler(npc, creature, message, keywords, parameters, node)	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if (parameters.confirm ~= true) and (parameters.decline ~= true) then
-- 		npcHandler:say("So you want to donate " .. (player:getMoney() - 500) .. " gold coins? \z
-- 			The little kiddies are going to appreciate it.", npc, creature)
-- 	elseif (parameters.confirm == true) then
-- 		if player:getMoney() > 500 then
-- 			player:removeMoney((player:getMoney() - 500))
-- 			npcHandler:say(
-- 				"Well, that's really generous of you. That'll feed a lot of hungry mouths for a while. \z
-- 				Right, now which {city} did you say you wanted to go to?", npc, creature)
-- 			npcHandler:resetNpc(creature)
-- 		else
-- 			npcHandler:say("Well, har har. Very funny. Come on, pick up the gold you just dropped.", npc, creature)
-- 		end
-- 	elseif (parameters.decline == true) then
-- 		if player:getMoney() > 500 then
-- 			npcHandler:say(
-- 				"By tempest! What's all this gold weighing us down? Don't you think that's a little risky with all \z
-- 				these pirates around? You can take 500 with you, but that's it. Drop the rest or {donate} it to the \z
-- 				Adventurers' Orphans Fund, really.", npc, creature)
-- 		end
-- 	end
-- 	return true
-- end

-- -- Function to handle town travel and its messages
-- local function townTravelHandler(npc, creature, message, keywords, parameters, node)	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if (parameters.confirm ~= true) and (parameters.decline ~= true) and parameters.townId then
-- 		local town = towns[parameters.townId]
-- 		if town.canBeSailed == false then
-- 			if player:isPremium() then
-- 				npcHandler:say("What? Whatever that is, it's not a port I sail to. " .. townNames.premium .. "?", npc, creature)
-- 			else
-- 				npcHandler:say("What? Whatever that is, it's not a port I sail to. " .. townNames.free .. "?", npc, creature)
-- 			end
-- 		elseif town.isPremium == true and not player:isPremium() then
-- 			npcHandler:say(
-- 				"Negative, can't bring you there without a premium account. \z
-- 				You should be glad you get to travel by ship - usually that's a premium service too, you know.", npc, creature)
-- 		else
-- 			npcHandler:say(town.message .. " What do you say, {yes} or {no}?", npc, creature)
-- 		end
-- 	elseif (parameters.confirm == true) then
-- 		-- Handle money excess at confirm or it may be dropped and picked up in previous steps
-- 		if player:getMoney() > 500 then
-- 			npcHandler:say(
-- 				"By tempest! What's all this gold weighing us down? Don't you think that's a little risky with all \z
-- 				these pirates around? You can take 500 with you, but that's it. Drop the rest or {donate} it to the \z
-- 				Adventurers' Orphans Fund, really.", npc, creature)
-- 			return true
-- 		end
-- 		local parentNode = node:getParent()
-- 		local parentParameters = parentNode:getParameters()
-- 		local townId = parentParameters.townId or parameters.townId
-- 		local town = Town(townId)
-- 		player:setTown(town)
-- 		player:teleportTo(towns[townId].destination)
-- 		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 		player:setStorageValue(Storage.Dawnport.Mainland, 1)


-- 				-- Liquid Black   
-- 				player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
-- 				player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
				
-- 				-- Bigfoot's Burden
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 2)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 4)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 7)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 9)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 12)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 16)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 20)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 23)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLineComplete, 2)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Rank, 1440)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone1Access, 2)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone2Access, 2)
-- 				player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Warzone3Access, 2)

-- 				-- WZ 4, 5 e 6
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Questline, 10)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneVI, 10)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneV, 10)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Access.LavaPumpWarzoneIV, 30)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Status, 10)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Status, 10)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Status, 10)	

-- 				--In Service of Yalahar 
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Questline, 51)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission01, 6)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission02, 8)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission03, 6)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission04, 6)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission05, 8)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission06, 5)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission07, 5)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission08, 4)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission09, 2)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10, 1)
-- 				-- part 2
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide , 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MatrixState, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesPalimuth, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesAzerus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToAzerus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToBog, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToLastFight, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToMatrix, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToQuara, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
-- 				player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)	


-- 				-- --Rashid
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

-- 				--Cults of Tibia Quest.
-- 				player:setStorageValue(Storage.CultsOfTibia.Questline, 7)
-- 				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.jamesfrancisTask, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.bossTimer, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra1, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra2, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra3, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Respostas, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.MotA.Perguntaid, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.sulphur, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.tar, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.ice, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.Objects, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.Temp, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Barkless.bossTimer, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Orcs.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Orcs.lookType, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Orcs.bossTimer, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Life.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Life.bossTimer, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Humans.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Humans.Vaporized, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Humans.Decaying, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Humans.bossTimer, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Misguided.Mission, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Misguided.Monsters, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Misguided.Time, 1)
-- 				player:setStorageValue(Storage.CultsOfTibia.Misguided.bossTimer, 1)

-- 				-- The Explorer Society
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 1) -- Joining the Explorers
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 4)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 7)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 16)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 26)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 29)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 32)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 35)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 38)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 41)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 43)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 46)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 47)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 50)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 55)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 56)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 58)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 61)
-- 				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.CalassaQuest, 2)

-- 				-- The Forgotten Knowledge
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled, 1)    
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.HorrorKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled, 1)
-- 				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessMachine, 1)

-- 				-- Children of the Revolution Quest.
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 21)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission00, 2)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission01, 3)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission02, 5)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission03, 3)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission04, 6)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission05, 3)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding01, 1)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding02, 1)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding03, 1)
-- 				player:setStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols, 1)

-- 				-- Factions
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Marid, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Efreet, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.MaridDoor, 1)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.EfreetDoor, 1)
-- 				-- Efreet
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Start, 1)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission01, 3)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission02, 3)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03, 3)
-- 				-- Marid
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Start, 1)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission01, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission02, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.RataMari, 2)
-- 				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Mission03, 3)

-- 				-- The Way to Yalahar
-- 				player:setStorageValue(Storage.TheWayToYalahar.Questline, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.TownsCounter, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.AbDendriel, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.Darashia, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.Venore, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.Ankrahmun, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.PortHope, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.Thais, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.LibertyBay, 1)
-- 				player:setStorageValue(Storage.SearoutesAroundYalahar.Carlin, 1)

-- 				-- The Hidden City of Beregar
-- 				player:setStorageValue(Storage.HiddenCityOfBeregar.DefaultStart, 1)
-- 				player:setStorageValue(Storage.HiddenCityOfBeregar.GoingDown, 1)


-- 				-- The Inquisition
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 14)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission01, 7)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission02, 3)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission03, 6)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission04, 3)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.GrofGuard, 1)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.KulagGuard, 1)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.TimGuard, 1)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.WalterGuard, 1)
-- 				player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.StorkusVampiredust, 1)

-- 				-- The New Frontier
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline, 28)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission01, 3)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission02, 6)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission03, 3)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission04, 2)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05, 7)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission06, 3)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission07, 3)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission08, 2)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission09, 3)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission10, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.TomeofKnowledge, 12)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver1, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver2, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver3, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeKing, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeLeeland, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeExplorerSociety, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeWydrin, 1)
-- 				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeTelas, 1)

-- 				-- The ice islands
-- 				player:setStorageValue(12200, 1) -- Storage through the Quest
-- 				player:setStorageValue(12201, 3) -- Befriending the Musher
-- 				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
-- 				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
-- 				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
-- 				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
-- 				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
-- 				player:setStorageValue(12207, 3) -- The Secret of Helheim
-- 				player:setStorageValue(12208, 4) -- The Contact
-- 				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
-- 				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
-- 				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
-- 				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation

-- 				-- The Shattered Isles
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.DefaultStart, 3)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheGovernorDaughter, 3)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheErrand, 2)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToMeriana, 1)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.APoemForTheMermaid, 3)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ADjinnInLove, 5)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToLagunaIsland, 1)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToGoroma, 1)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.Shipwrecked, 2)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.DragahsSpellbook, 1)
-- 				player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.TheCounterspell, 4)

-- 				-- The Thieves Guild.
-- 				player:setStorageValue(Storage.ThievesGuild.Quest, 1)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission01, 2)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission02, 3)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission03, 3)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission04, 8)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission05, 2)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission06, 4)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission07, 2)
-- 				player:setStorageValue(Storage.ThievesGuild.Mission08, 3)

-- 				-- The Travelling Trader Quest
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
-- 				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

-- 				-- The Ultimate Challenges Quest.
-- 				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)

-- 				-- Tibia Tales.
-- 				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
-- 				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)

-- 				-- The Postman
-- 				player:setStorageValue(12450, 6) -- Mission 1 - Check Postal Routes
-- 				player:setStorageValue(12451, 3) -- Mission 2 - Fix Mailbox
-- 				player:setStorageValue(12452, 3) -- Mission 3 - Bill Delivery
-- 				player:setStorageValue(12453, 2) -- Mission 4 - Aggressive Dogs
-- 				player:setStorageValue(12454, 4) -- Mission 5 - Present Delivery
-- 				player:setStorageValue(12455, 13) -- Mission 6 - New Uniforms
-- 				player:setStorageValue(12456, 8) -- Mission 7 - Measurements
-- 				player:setStorageValue(12457, 3) -- Mission 8 - Missing Courier
-- 				player:setStorageValue(12458, 4) -- Mission 9 - Dear Santa
-- 				player:setStorageValue(12459, 3) -- Mission 10 - Mintwallin
-- 				player:setStorageValue(12460, 5)  -- Postman Rank

-- 				-- Unnatural Selection
-- 				player:setStorageValue(12330, 1) -- Storage through the Quest
-- 				-- player:setStorageValue(12331, 3) -- Mission 1: Skulled
-- 				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
-- 				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
-- 				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
-- 				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
-- 				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn

-- 				-- Friends and Traders
-- 				player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.DefaultStart, 1)
-- 				player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheMermaidMarina, 2)
-- 				player:setStorageValue(Storage.Quest.U7_8.FriendsandTraders.TheBlessedStake, 12)				

-- 				-- KilmareshQuest
-- 				player:setStorageValue(22000, 5) -- Town Counter

-- 				-- Wrath of the Emperor
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline, 30)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission01, 3)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission02, 3)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission03, 3)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission04, 3)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission05, 3)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission06, 4)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission07, 6)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission08, 2)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission09, 2)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission10, 6)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11, 1)
-- 				player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.BossStatus, 5)

-- 				-- The Ape City Quest.
-- 				player:setStorageValue(Storage.Quest.U7_6.TheApeCity.Started, 1)
-- 				player:setStorageValue(Storage.Quest.U7_6.TheApeCity.Questline, 17)

-- 				-- Oramond.
-- 				player:setStorageValue(Storage.Oramond.QuestLine, 1)
-- 				player:setStorageValue(Storage.Oramond.MissionToTakeRoots, 3000)

-- 				-- Dangerous Depths.
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Questline, 1)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Home, 2)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Dwarves.Subterranean, 2)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Measurements, 2)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Ordnance, 3)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Gnomes.Charting, 2)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Growth, 2)
-- 				player:setStorageValue(Storage.Quest.U11_50.DangerousDepths.Scouts.Diremaw, 2)

-- 				-- Threatened Dreams
-- 				player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Start, 1)
-- 				player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TroubledMission01, 4)
-- 				player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TroubledMission01, 17)		
-- 				player:setStorageValue(Storage.Quest.U11_40.ThreatenedDreams.TatteredSwanFeathers, 5)

-- 				-- Adventurers Guild.
-- 				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
-- 				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)

-- 				-- Dawnport
-- 				player:setStorageValue(Storage.Quest.U10_55.Dawnport.Questline, 1)
-- 				player:setStorageValue(Storage.Quest.U10_55.Dawnport.GoMain, 1)

-- 		npcHandler:say(
-- 			"Cast off! Don't forget to talk to the guide at the port for directions to nearest bars... err, shops and \z
-- 			bank and such!", npc, creature)
-- 		npcHandler:resetNpc(creature)
-- 		npcHandler:removeInteraction(npc, creature)
-- 	elseif (parameters.decline == true) then
-- 		if player:isPremium() then
-- 			npcHandler:say("Changed your mind? Which city do you want to head to, " .. townNames.premium .. "?", npc, creature)
-- 		else
-- 			npcHandler:say("Changed your mind? Which city do you want to head to, " .. townNames.free .. "?", npc, creature)
-- 		end
-- 		npcHandler.keywordHandler:moveUp(creature, 1)
-- 	elseif (parameters.sailableTowns == true) and parameters.text then
-- 		if player:isPremium() then
-- 			npcHandler:say(string.gsub(parameters.text, "|TOWNS|", townNames.premium), npc, creature)
-- 		else
-- 			npcHandler:say(string.gsub(parameters.text, "|TOWNS|", townNames.free), npc, creature)
-- 		end
-- 	end
-- 	return true
-- end
-- -- Other topics
-- keywordHandler:addKeyword({"name"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "Ruby Dreadnought. But it's Captain Dreadnought to you!"
-- })
-- keywordHandler:addKeyword({"job"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "I'm captain of this little sloop here, the Sea Cat."
-- })
-- keywordHandler:addKeyword({"ship"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "She's pretty, isn't she? Will ship you safely to any port. Though a young landlubber such as you should \z
-- 	consider to travel to Venore first. The travel is for free. Just once though! You have to ask for a {passage}."
-- })
-- keywordHandler:addKeyword({"mainland"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "You chose a peaceful world. Not much danger from other adventurers. Just beware the monsters. \z
-- 	Want go there, ask for a {passage}."
-- })
-- keywordHandler:addKeyword({"rookgaard"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "That old place? Sorry, I don't sail there, no loot to be had."
-- })
-- keywordHandler:addKeyword({"adventurers guild"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = {
-- 		"Those fellows help still green adventurers like you, so you learn the lay of the Tibian Mainlands. \z
-- 		With the adventurer's stone you can reach their guild hall from all major temples. ...", 
-- 		"I recommend you travel there as soon as possible."
-- 	}
-- })
-- keywordHandler:addKeyword({"premium"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "Some regions in the world can't be accessed by everyone. Gotta pay, you know? \z
-- 	If you spend some real cash for premium time, I can bring you to much more challenging locations."
-- })
-- keywordHandler:addKeyword({"tibia"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "That's what the whole place is called."
-- })
-- -- Main topic nodes
-- local readyNode = keywordHandler:addKeyword({"yes"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "Good. Got all you want to take to the mainland, {yes}? Gear, limbs, loot?"
-- })
-- local notReadyNode = keywordHandler:addKeyword({"no"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "What? Then what DO you want? Learn about the main Tibian {cities}?"
-- })
-- -- Main subtopic nodes
-- -- hi, yes, ...
-- local defaultTownNode = readyNode:addChildKeyword({"yes"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = {
-- 		"Quick learner, good answer. For inexperienced newcomers, \z
-- 		I'd recommend the city of {" .. towns[defaultTown].name .. "}. Great place to start! ...",
-- 		"Though I can tell you about the other main Tibian {cities} too, if you wish. \z
-- 		So, ready to set sail for {" .. towns[defaultTown].name .. "}?"
-- 	}
-- })
-- readyNode:addChildKeyword({"no"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "While you take time to ponder, I will just stroll over there and pretend not to listen to you thinking.",
-- 	ungreet = true
-- })
-- -- hi, no, ...
-- local aboutTownsNode = notReadyNode:addChildKeyword({"yes"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "Well, I can tell you stuff about " .. townNames.all .. "."
-- })
-- local aboutSailNode = notReadyNode:addChildKeyword({"no"}, townTravelHandler,
-- {
-- 	sailableTowns = true,
-- 	text = "So you know it all, huh? Where do you want me to bring you to, kid? |TOWNS|?"
-- })
-- -- hi, yes, yes, ...
-- defaultTownNode:addChildKeyword({"yes"}, townTravelHandler, {confirm = true, townId = defaultTown})
-- defaultTownNode:addAliasKeyword({towns[defaultTown].name:lower()})
-- defaultTownNode:addChildKeyword({"no"}, townTravelHandler, {decline = true})
-- -- Towns topic nodes
-- local townsNode = keywordHandler:addKeyword({"cities"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "Do you want to know about " .. townNames.all .. "?"
-- })
-- for id, town in pairs(towns) do
-- 	local townNode = KeywordNode:new({town.name:lower()}, StdModule.say, {npcHandler = npcHandler, text = town.about})
-- 	townsNode:addChildKeywordNode(townNode)
-- 	aboutTownsNode:addChildKeywordNode(townNode)
-- end
-- keywordHandler:addAliasKeyword({"city"})
-- -- Sail topic nodes
-- local sailNode = keywordHandler:addKeyword({"sail"}, StdModule.say,
-- {
-- 	npcHandler = npcHandler,
-- 	text = "So, you've decided on your new home city? Which one will it be?"
-- })
-- local confirmNode = KeywordNode:new({"yes"}, townTravelHandler, {confirm = true})
-- local declineNode = KeywordNode:new({"no"}, townTravelHandler, {decline = true})
-- for id, town in pairs(towns) do
-- 	local townSailNode = KeywordNode:new({town.name:lower()}, townTravelHandler, {townId = id})	
-- 	townSailNode:addChildKeywordNode(confirmNode)
-- 	townSailNode:addChildKeywordNode(declineNode)
-- 	sailNode:addChildKeywordNode(townSailNode)
-- 	aboutSailNode:addChildKeywordNode(townSailNode)
-- end
-- keywordHandler:addAliasKeyword({"passage"})
-- keywordHandler:addAliasKeyword({"travel"})
-- -- Donate topic nodes
-- local donateNode = keywordHandler:addKeyword({"donate"}, donationHandler, {}, 
-- function(player) return player:getMoney() > 500 end
-- )
-- donateNode:addChildKeywordNode(KeywordNode:new({"yes"}, donationHandler, {confirm = true}))
-- donateNode:addChildKeywordNode(KeywordNode:new({"no"}, donationHandler, {decline = true}))

-- local function greetCallback(npc, creature)
-- 	local playerId = creature:getId()
-- 	local player = Player(creature)
-- 	npcHandler:setMessage(
-- 		MESSAGE_GREET,
-- 		"Well, well, a new " .. player:getVocation():getName():lower() .. "! Want me to bring you somewhere nice? \z
-- 		Just say {yes}."
-- 	)
-- 	return true
-- end

-- local function creatureSayCallback(npc, creature, type, message)
-- 	local player = Player(creature)
-- 	local playerId = player:getId()

-- 	if not npcHandler:checkInteraction(npc, creature) then
-- 		return false
-- 	end

-- 	local currentNode = keywordHandler:getLastNode(creature)
-- 	-- Handle other words for nodes while still handling (bye, farewell) keywords
-- 	if #currentNode.children == 0 then
-- 		npcHandler:say(
-- 			"Kid, listen. Answering with a clear {yes} or {no} will get you much further in Tibia. \z
-- 			Most people are not as sharp-eared as I am. Got that?", npc, creature)
-- 	elseif currentNode == readyNode then
-- 		npcHandler:say("Errr... was that a foreign language? Could you just answer with a clear {yes} or {no}?", npc, creature)
-- 	elseif currentNode == notReadyNode then
-- 		npcHandler:say(
-- 		"Aw, come on! Talk to me in human words! {Yes}, {no}, or mention a city's name, that kind of stuff.", npc, creature)
-- 	end
-- 	return true
-- end

-- npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:setMessage(
-- 	MESSAGE_FAREWELL,
-- 	"You sure you want to spend time on this piece of rock? I can show you the world! Huh."
-- )

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)


--------------------------------------------------------------
-----------------------------------------------------------

local internalNpcName = "Captain Dreadnought"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 155,
	lookHead = 96,
	lookBody = 0,
	lookLegs = 78,
	lookFeet = 96,
	lookAddons = 1
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = "Sem contrabandos no navio! Apenas 20 de cada item de criatura serao permitidos."},
	{text = "Nao tenha medo. O Felino do Mar te transportara em seguranca ate seu proximo destino!"},
	{text = "Todos a bordo! Preparem-se para partir!"},
	{text = "Essa ilha esta muito pequena para o meu enorme espirito aventureiro. Vamos explorar novos mares!"}
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

	-- -- Criando a janela de outfit
	-- local function sendOutfitWindow(player)
	-- 	local outfits = {
	-- 		{name = "Citizen", male = 974, female = 975},
	-- 		{name = "Warrior", male = 962, female = 963},
	-- 		{name = "Summoner", male = 964, female = 965},
	-- 		{name = "Mage", male = 969, female = 968},
	-- 		{name = "Knight", male = 970, female = 971},
	-- 		{name = "Hunter", male = 972, female = 973},
	-- 		{name = "Nobleman", male = 966, female = 967},
	-- 	}

	-- 	local window = ModalWindow{
	-- 		title = "Evento de Outono",
	-- 		message = "Selecione um Retro Outfit:"
	-- 	}

	-- 	for i, outfit in ipairs(outfits) do
	-- 		window:addButton(outfit.name, function()
	-- 			-- Aplica ambos os lookTypes
	-- 			player:addOutfit(outfit.male)
	-- 			player:addOutfit(outfit.female)
	-- 			player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu o outfit: " .. outfit.name)
	-- 		end)
	-- 	end

	-- 	window:addButton("Cancelar")
	-- 	window:sendToPlayer(player)
	-- end

	local function sendOutfitWindowPage(player, page)
		local outfits = {
			{name = "Citizen", male = 974, female = 975},
			{name = "Warrior", male = 962, female = 963},
			{name = "Summoner", male = 964, female = 965},
			{name = "Mage", male = 969, female = 968},
			{name = "Knight", male = 970, female = 971},
			{name = "Hunter", male = 972, female = 973},
			{name = "Nobleman", male = 966, female = 967},
		}

		local window = ModalWindow{
			title = "Evento de Outono - Pagina " .. page,
			message = "Selecione um Retro Outfit:"
		}

		if page == 1 then
			-- 3 primeiros outfits
			for i = 1, 3 do
				local outfit = outfits[i]
				window:addButton(outfit.name, function()
					player:addOutfit(outfit.male)
					player:addOutfit(outfit.female)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu o outfit: Retro " .. outfit.name)
				end)
			end
			-- Próxima página
			window:addButton(">>>", function()
				sendOutfitWindowPage(player, 2)
			end)

		elseif page == 2 then
			-- Botão Anterior
			window:addButton("<<<", function()
				sendOutfitWindowPage(player, 1)
			end)
			-- 2 próximos outfits
			for i = 4, 5 do
				local outfit = outfits[i]
				window:addButton(outfit.name, function()
					player:addOutfit(outfit.male)
					player:addOutfit(outfit.female)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu o outfit: Retro " .. outfit.name)
				end)
			end
			-- Próxima página
			window:addButton(">>>", function()
				sendOutfitWindowPage(player, 3)
			end)

		elseif page == 3 then
			-- Botão Retornar
			window:addButton("<<<", function()
				sendOutfitWindowPage(player, 2)
			end)
			-- Últimos 2 outfits
			for i = 6, 7 do
				local outfit = outfits[i]
				window:addButton(outfit.name, function()
					player:addOutfit(outfit.male)
					player:addOutfit(outfit.female)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu o outfit: Retro " .. outfit.name)
				end)
			end
			-- Nenhum botão de cancelar aqui
		end

		window:sendToPlayer(player)
	end

	if MsgContains(message, "nao") or MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == 0 or npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Tudo bem. Me avise quando estiver pronto(a)!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Tudo bem, me diga quando souber seu destino. Se precisar de orientação, basta me perguntar sobre as {cidades}!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			npcHandler:say("Sem problemas, fique com todo seu dinheiro. Mas lembre-se que ninguem viaja comigo carregando mais que 500 moedas de ouro!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "doacao") then
		if player:getMoney() > 500 then
			npcHandler:say("Voce gostaria de doar seu ouro excedente para o Orfanato?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		else
			npcHandler:say("Voce nao tem ouro suficiente para fazer uma doacao.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
    elseif MsgContains(message, "sim") or MsgContains(message, "yes") or MsgContains(message, "sail") or MsgContains(message, "viajar") then
		if npcHandler:getTopic(playerId) == 0 and player:getMoney() <= 500 then
            npcHandler:say("Otimo! Pegou tudo o que precisava? Seus itens iniciais e tudo mais? \z
	    	Alem disso voce nao podera levar mais que 500 moedas de ouro no navio. Nao queremos chamar a atencao de piratas. Voce esta pronto para partir?", npc, creature)
            npcHandler:setTopic(playerId, 1)
		elseif npcHandler:getTopic(playerId) == 0 and player:getMoney() > 500 then
            npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Ha piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faça uma {doacao} para o Orfanato de Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
        elseif npcHandler:getTopic(playerId) == 1 and player:getMoney() <= 500 then
            npcHandler:say("Agora te levarei para a proxima etapa de sua jornada: A cidade de {Crandoria}. Chegando la procure por Comandante Crassus. Ele te ajudara com algumas missoes. \z
			Tudo pronto para ir?", npc, creature)
            npcHandler:setTopic(playerId, 2)
		elseif npcHandler:getTopic(playerId) == 1 and player:getMoney() > 500 then
            npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Há piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faca uma {doacao} para o Orfanato de Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 and player:getMoney() > 500 then
            npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Ha piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faca uma {doacao} para o Orfanato de Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 and player:getMoney() > 500 then
			player:removeMoney(player:getMoney() - 500)
			npcHandler:say("Muito obrigado! As crianças do Novo Continente agradecem pela sua doacao. E agora, tudo pronto para partir? Esta pronto para ir para {Crandoria}?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getMoney() <= 500 then
				local time = math.random(2, 3)
					player:teleportTo(Position(5003, 5003, 6))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 30)
			player:addMount(203)
			player:setStorageValue(Storage.Dawnport.Mainland, 1)
					-- Liquid Black   
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
			
			addEvent(function()
			-- Bigfoot's Burden
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 4)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 7)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 9)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 12)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 16)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 20)
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
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

			end, 500)

			addEvent(function()
				-- The Forgotten Knowledge
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
	
				-- The ice islands
				player:setStorageValue(12200, 1) -- Storage through the Quest
				player:setStorageValue(12201, 3) -- Befriending the Musher
				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
				player:setStorageValue(12207, 3) -- The Secret of Helheim
				player:setStorageValue(12208, 4) -- The Contact
				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation
	
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
	
				-- The Travelling Trader Quest
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)
	
				-- The Ultimate Challenges Quest.
				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)
	
				-- Tibia Tales.
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)
	
				-- Unnatural Selection
				player:setStorageValue(12330, 1) -- Storage through the Quest
				-- player:setStorageValue(12331, 3) -- Mission 1: Skulled
				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn
	
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
	
				-- Adventurers Guild.
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)
	
				-- Dawnport
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.Questline, 1)
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.GoMain, 1)
			end, 1000 * time)

				local configMarks = {
					{mark = "shop", position = Position(5029, 4993, 7), markId = MAPMARK_DOLLAR, description = "Shop"}, 
					{mark = "depot", position = Position(4970, 5004, 7), markId = MAPMARK_LOCK, description = "Depot"},
					{mark = "templo", position = Position(5000, 5000, 7), markId = MAPMARK_TEMPLE, description = "Templo"},
					{mark = "promotion", position = Position(5016, 5017, 7), markId = MAPMARK_STAR, description = "Promotion"},
					{mark = "municao", position = Position(4929, 4985, 7), markId = MAPMARK_BAG, description = "Municao"},
					{mark = "potions", position = Position(4966, 4992, 7), markId = MAPMARK_BAG, description = "Potions"},
					{mark = "food", position = Position(4950, 4993, 7), markId = MAPMARK_BAG, description = "Food"},
					{mark = "barco", position = Position(4972, 5063, 7), markId = MAPMARK_FLAG, description = "Barco"},
				}
	
				local mark
				for i = 1, #configMarks do
					mark = configMarks[i]
					player:addMapMark(mark.position, mark.markId, mark.description)
				end
				sendOutfitWindowPage(player, 1)
				npcHandler:setTopic(playerId, 0)
			elseif player:getMoney() > 500 then
				npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Há piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faça uma {doacao} para o Orfanato de Crandoria.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end



            -- npcHandler:say("Se for seu primeito personagem, recomendamos que va para {Crandoria}. Porem, se ja tiver mais experiencia com o servidor, pode ir para {Hakata} ou {Elvenshire}. Qual sera seu destino?", npc, creature)
			-- npcHandler:say("Quando estiver pronto basta me dizer e te levarei para {Crandoria}.", npc, creature)
			-- npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "crandoria") and npcHandler:getTopic(playerId) >= 2 then
		if player:getMoney() <= 500 then
			local time = math.random(2, 3)
			player:teleportTo(Position(5003, 5003, 6))
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 30)
			player:addMount(203)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setStorageValue(Storage.Dawnport.Mainland, 1)
					-- Liquid Black   
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
			
			addEvent(function()
			-- Bigfoot's Burden
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 4)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 7)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 9)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 12)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 16)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 20)
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
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission01, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission02, 8)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission03, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission04, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission05, 8)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission06, 5)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission07, 5)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission08, 4)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission09, 2)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10, 1)
			-- -- part 2
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide , 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MatrixState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesPalimuth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesAzerus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToAzerus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToBog, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToLastFight, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToMatrix, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToQuara, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)	


			-- --Rashid
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

			end, 500)

			addEvent(function()
				-- The Forgotten Knowledge
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
	
				-- The ice islands
				player:setStorageValue(12200, 1) -- Storage through the Quest
				player:setStorageValue(12201, 3) -- Befriending the Musher
				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
				player:setStorageValue(12207, 3) -- The Secret of Helheim
				player:setStorageValue(12208, 4) -- The Contact
				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation
	
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
	
				-- The Travelling Trader Quest
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)
	
				-- The Ultimate Challenges Quest.
				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)
	
				-- Tibia Tales.
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)
	
				-- Unnatural Selection
				player:setStorageValue(12330, 1) -- Storage through the Quest
				-- player:setStorageValue(12331, 3) -- Mission 1: Skulled
				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn
	
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
	
				-- Adventurers Guild.
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)
	
				-- Dawnport
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.Questline, 1)
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.GoMain, 1)
			end, 1000 * time)

			local configMarks = {
				{mark = "shop", position = Position(5029, 4993, 7), markId = MAPMARK_DOLLAR, description = "Shop"}, 
				{mark = "depot", position = Position(4970, 5004, 7), markId = MAPMARK_LOCK, description = "Depot"},
				{mark = "templo", position = Position(5000, 5000, 7), markId = MAPMARK_TEMPLE, description = "Templo"},
				{mark = "promotion", position = Position(5016, 5017, 7), markId = MAPMARK_STAR, description = "Promotion"},
				{mark = "municao", position = Position(4929, 4985, 7), markId = MAPMARK_BAG, description = "Municao"},
				{mark = "potions", position = Position(4966, 4992, 7), markId = MAPMARK_BAG, description = "Potions"},
				{mark = "food", position = Position(4950, 4993, 7), markId = MAPMARK_BAG, description = "Food"},
				{mark = "barco", position = Position(4972, 5063, 7), markId = MAPMARK_FLAG, description = "Barco"},
			}

			local mark
			for i = 1, #configMarks do
				mark = configMarks[i]
				player:addMapMark(mark.position, mark.markId, mark.description)
			end
			sendOutfitWindowPage(player, 1)
			npcHandler:setTopic(playerId, 0)
		elseif player:getMoney() > 500 then
			npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Há piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faça uma {doacao} para o Orfanato de Crandoria.", npc, creature)
            npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "hakata") and npcHandler:getTopic(playerId) >= 2 then
		if player:getMoney() <= 500 then
			local time = math.random(2, 3)
			player:teleportTo(Position(5003, 5003, 6))
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 30)
			player:addMount(203)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setStorageValue(Storage.Dawnport.Mainland, 1)
					-- Liquid Black   
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
			
			addEvent(function()
			-- Bigfoot's Burden
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 4)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 7)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 9)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 12)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 16)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 20)
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
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission01, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission02, 8)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission03, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission04, 6)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission05, 8)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission06, 5)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission07, 5)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission08, 4)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission09, 2)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10, 1)
			-- -- part 2
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide , 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MatrixState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesPalimuth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesAzerus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToAzerus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToBog, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToLastFight, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToMatrix, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToQuara, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			-- player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)	


			-- --Rashid
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

			end, 500)

			addEvent(function()
				-- The Forgotten Knowledge
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
	
				-- The ice islands
				player:setStorageValue(12200, 1) -- Storage through the Quest
				player:setStorageValue(12201, 3) -- Befriending the Musher
				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
				player:setStorageValue(12207, 3) -- The Secret of Helheim
				player:setStorageValue(12208, 4) -- The Contact
				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation
	
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
	
				-- The Travelling Trader Quest
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)
	
				-- The Ultimate Challenges Quest.
				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)
	
				-- Tibia Tales.
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)
	
				-- Unnatural Selection
				player:setStorageValue(12330, 1) -- Storage through the Quest
				-- player:setStorageValue(12331, 3) -- Mission 1: Skulled
				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn
	
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
	
				-- Adventurers Guild.
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)
	
				-- Dawnport
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.Questline, 1)
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.GoMain, 1)
			end, 1000 * time)

			local configMarks = {
				{mark = "shop", position = Position(5029, 4993, 7), markId = MAPMARK_DOLLAR, description = "Shop"}, 
				{mark = "depot", position = Position(4970, 5004, 7), markId = MAPMARK_LOCK, description = "Depot"},
				{mark = "templo", position = Position(5000, 5000, 7), markId = MAPMARK_TEMPLE, description = "Templo"},
				{mark = "promotion", position = Position(5016, 5017, 7), markId = MAPMARK_STAR, description = "Promotion"},
				{mark = "municao", position = Position(4929, 4985, 7), markId = MAPMARK_BAG, description = "Municao"},
				{mark = "potions", position = Position(4966, 4992, 7), markId = MAPMARK_BAG, description = "Potions"},
				{mark = "food", position = Position(4950, 4993, 7), markId = MAPMARK_BAG, description = "Food"},
				{mark = "barco", position = Position(4972, 5063, 7), markId = MAPMARK_FLAG, description = "Barco"},
			}

			local mark
			for i = 1, #configMarks do
				mark = configMarks[i]
				player:addMapMark(mark.position, mark.markId, mark.description)
			end

			npcHandler:setTopic(playerId, 0)
		elseif player:getMoney() > 500 then
			npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Ha piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faca uma {doacao} para o Orfanato de Crandoria.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "elvenshire") and npcHandler:getTopic(playerId) >= 2 then
		if player:getMoney() <= 500 then
			local time = math.random(2, 3)
			player:teleportTo(Position(5003, 5003, 6))
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 30)
			player:addMount(203)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setStorageValue(Storage.Dawnport.Mainland, 1)
					-- Liquid Black   
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.QuestLine, 1)
			player:setStorageValue(Storage.Quest.U9_4.LiquidBlackQuest.Visitor, 5)
			
			-- Bigfoot's Burden
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 2)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 4)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 7)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 9)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 12)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.Shooting, 5)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 16)
			player:setStorageValue(Storage.Quest.U9_60.BigfootsBurden.QuestLine, 20)
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
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission01, 6)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission02, 8)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission03, 6)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission04, 6)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission05, 8)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission06, 5)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission07, 5)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission08, 4)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission09, 2)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.Mission10, 1)
			-- part 2
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide , 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MatrixState, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesPalimuth, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.NotesAzerus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToAzerus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToBog, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToLastFight, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToMatrix, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DoorToQuara, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe01, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe02, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe03, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.SewerPipe04, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedDan, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedBill, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.DiseasedFred, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.AlchemistFormula, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.BadSide, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.GoodSide, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestDoor, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MrWestStatus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.TamerinStatus, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.MorikSummon, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraState, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSplasher, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraSharptooth, 1)
			player:setStorageValue(Storage.Quest.U8_4.InServiceOfYalahar.QuaraInky, 1)	


			-- --Rashid
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)

			--Cults of Tibia Quest.
			player:setStorageValue(Storage.CultsOfTibia.Questline, 7)
			player:setStorageValue(Storage.CultsOfTibia.Minotaurs.jamesfrancisTask, 1)
			player:setStorageValue(Storage.CultsOfTibia.Minotaurs.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Minotaurs.bossTimer, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra1, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra2, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra3, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Respostas, 1)
			player:setStorageValue(Storage.CultsOfTibia.MotA.Perguntaid, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.sulphur, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.tar, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.ice, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.Objects, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.Temp, 1)
			player:setStorageValue(Storage.CultsOfTibia.Barkless.bossTimer, 1)
			player:setStorageValue(Storage.CultsOfTibia.Orcs.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Orcs.lookType, 1)
			player:setStorageValue(Storage.CultsOfTibia.Orcs.bossTimer, 1)
			player:setStorageValue(Storage.CultsOfTibia.Life.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Life.bossTimer, 1)
			player:setStorageValue(Storage.CultsOfTibia.Humans.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Humans.Vaporized, 1)
			player:setStorageValue(Storage.CultsOfTibia.Humans.Decaying, 1)
			player:setStorageValue(Storage.CultsOfTibia.Humans.bossTimer, 1)
			player:setStorageValue(Storage.CultsOfTibia.Misguided.Mission, 1)
			player:setStorageValue(Storage.CultsOfTibia.Misguided.Monsters, 1)
			player:setStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms, 1)
			player:setStorageValue(Storage.CultsOfTibia.Misguided.Time, 1)
			player:setStorageValue(Storage.CultsOfTibia.Misguided.bossTimer, 1)

			-- The Explorer Society
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 1) -- Joining the Explorers
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 4)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 7)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 16)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 26)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 29)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 32)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 35)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 38)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 41)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 43)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 46)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 47)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 50)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 55)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 56)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 58)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 61)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.CalassaQuest, 2)

			addEvent(function()
				-- The Forgotten Knowledge
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.Tomes, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled, 1)    
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.HorrorKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled, 1)
				player:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AccessMachine, 1)
	
				-- Children of the Revolution Quest.
				player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 21)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission00, 2)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission01, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission02, 5)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission03, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission04, 6)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission05, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding01, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding02, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding03, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols, 1)
	
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
	
				-- The Way to Yalahar
				player:setStorageValue(Storage.TheWayToYalahar.Questline, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.TownsCounter, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.AbDendriel, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Darashia, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Venore, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Ankrahmun, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.PortHope, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Thais, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.LibertyBay, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Carlin, 1)
	
				-- The Hidden City of Beregar
				player:setStorageValue(Storage.HiddenCityOfBeregar.DefaultStart, 1)
				player:setStorageValue(Storage.HiddenCityOfBeregar.GoingDown, 1)
	
	
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
	
				-- The New Frontier
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Questline, 28)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission01, 3)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission02, 6)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission04, 2)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05, 7)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission06, 3)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission07, 3)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission08, 2)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission09, 3)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission10, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.TomeofKnowledge, 12)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver1, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver2, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.Beaver3, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeKing, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeLeeland, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeExplorerSociety, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeWydrin, 1)
				player:setStorageValue(Storage.Quest.U8_54.TheNewFrontier.BribeTelas, 1)
	
				-- The ice islands
				player:setStorageValue(12200, 1) -- Storage through the Quest
				player:setStorageValue(12201, 3) -- Befriending the Musher
				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
				player:setStorageValue(12207, 3) -- The Secret of Helheim
				player:setStorageValue(12208, 4) -- The Contact
				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation
	
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
	
				-- The Travelling Trader Quest
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)
	
				-- The Ultimate Challenges Quest.
				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)
	
				-- Tibia Tales.
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.DefaultStart, 1)
				player:setStorageValue(Storage.Quest.U8_1.TibiaTales.ToAppeaseTheMightyQuest, 1)
	
				-- The Postman
				player:setStorageValue(12450, 6) -- Mission 1 - Check Postal Routes
				player:setStorageValue(12451, 3) -- Mission 2 - Fix Mailbox
				player:setStorageValue(12452, 3) -- Mission 3 - Bill Delivery
				player:setStorageValue(12453, 2) -- Mission 4 - Aggressive Dogs
				player:setStorageValue(12454, 4) -- Mission 5 - Present Delivery
				player:setStorageValue(12455, 13) -- Mission 6 - New Uniforms
				player:setStorageValue(12456, 8) -- Mission 7 - Measurements
				player:setStorageValue(12457, 3) -- Mission 8 - Missing Courier
				player:setStorageValue(12458, 4) -- Mission 9 - Dear Santa
				player:setStorageValue(12459, 3) -- Mission 10 - Mintwallin
				player:setStorageValue(12460, 5)  -- Postman Rank
	
				-- Unnatural Selection
				player:setStorageValue(12330, 1) -- Storage through the Quest
				-- player:setStorageValue(12331, 3) -- Mission 1: Skulled
				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn
	
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
	
				-- Adventurers Guild.
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)
	
				-- Dawnport
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.Questline, 1)
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.GoMain, 1)
			end, 1000 * time)

			local configMarks = {
				{mark = "shop", position = Position(5029, 4993, 7), markId = MAPMARK_DOLLAR, description = "Shop"}, 
				{mark = "depot", position = Position(4970, 5004, 7), markId = MAPMARK_LOCK, description = "Depot"},
				{mark = "templo", position = Position(5000, 5000, 7), markId = MAPMARK_TEMPLE, description = "Templo"},
				{mark = "promotion", position = Position(5016, 5017, 7), markId = MAPMARK_STAR, description = "Promotion"},
				{mark = "municao", position = Position(4929, 4985, 7), markId = MAPMARK_BAG, description = "Municao"},
				{mark = "potions", position = Position(4966, 4992, 7), markId = MAPMARK_BAG, description = "Potions"},
				{mark = "food", position = Position(4950, 4993, 7), markId = MAPMARK_BAG, description = "Food"},
				{mark = "barco", position = Position(4972, 5063, 7), markId = MAPMARK_FLAG, description = "Barco"},
			}

			local mark
			for i = 1, #configMarks do
				mark = configMarks[i]
				player:addMapMark(mark.position, mark.markId, mark.description)
			end

			npcHandler:setTopic(playerId, 0)
		elseif player:getMoney() > 500 then
			npcHandler:say("Ei, voce nao pode carregar tanto ouro nessa viagem! Ha piratas no caminho, precisamos ter cuidado. Por favor descarte o ouro excedente ou faca uma {doacao} para o Orfanato de Crandoria.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, jovem viajante. Chegou a hora de entrar na proxima etapa da sua jornada. Voce esta preparado para ir para uma nova cidade?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais! Volte quando quiser utilizar meus servicos.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)