local internalNpcName = "Alira"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 138,
	lookHead = 55,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 26,
    lookAddons = 3,
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

    if MsgContains(message, "hardcore") then
        npcHandler:say("Se deseja {informacoes} sobre o modo Hardcore, basta dizer. Se quiser voar direto para {Viridia}, me diga e estaremos la em segundos.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "informacoes") then
        npcHandler:say("Se voce seguir o modo Hardcore tera que passar por {Viridia} antes de ir para Crandoria. Sua missao sera mais dificil, mas voce podera obter conquistas que te darao bonus permanentes. \z
        Ao sair de {Viridia} rumo a Crandoria, os jogadores do modo Hardcore podem obter bonus de loot, skill e experiencia de acordo com suas conquistas alcancadas em Viridia, porem tambem terao penalidades. \z
        A experiencia de jogadores do Modo Hardcore possui taxa inicial de 4x em {Viridia}, caindo ate 1x. Alem disso jogadores do modo Hardcore nao podem desativar o PvP.", npc, creature)
        npcHandler:setTopic(playerId, 0)
    elseif MsgContains(message, "viridia") then
        npcHandler:say("Voce deseja ir para Viridia e seguir sua jornada no Modo Hardcore? (irreversivel)", npc, creature)
        npcHandler:setTopic(playerId, 1)
    elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) then
        if npcHandler:getTopic(playerId) == 1 then
            local money = player:getBankBalance() + player:getMoney()
            if money < 5000 then
				local baseVocation = Vocation(VOCATION.ID.NONE)

				local knight = player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT
				local paladin = player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN
				local guardian = player:getVocation():getBaseId() == VOCATION.BASE_ID.CELESTIAL_GUARDIAN
				local druid = player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID
				local sorcerer = player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER
				local summoner = player:getVocation():getBaseId() == VOCATION.BASE_ID.ANCIENT_SUMMONER
				local baseVocation = Vocation(VOCATION.ID.NONE)

				player:setLevel(8)

				addEvent(function()
					local level = player:getLevel()

					player:setMaxHealth(190)
					player:setMaxMana(90)

					player:setCapacity((7 * baseVocation:getCapacityGain()) + (level * player:getVocation():getCapacityGain()) + 40000)
				end, 2 * 1000)

                player:teleportTo(Position(4544, 5434, 3))
				player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, 0)
				player:setStorageValue(Storage.Quest.Crandoria.Viridia.TimerAcessoViridia, os.time())

				if knight then

				local msg = [[:: ATENCAO, KNIGHT!
Utilize a spell 'unera gran' para regenerar sua mana a cada 2 minutos.

Essa spell fornece regeneracao de mana ao longo do tempo.

Boa sorte!
]]
					-- player:popupFYI(msg)
				end

				addEvent(function()
				-- player:setMaxMana(90)
				-- player:setMaxHealth(185)
                player:setStorageValue(Storage.Quest.Crandoria.Viridia.Citizen, 1)
				player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
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
				end, 500)
	
				addEvent(function()
				-- --Rashid
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission07, 1)
	
	
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
				end, 1000)
				addEvent(function()
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
				end, 2000)
				addEvent(function()
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
	
				-- The Thieves Guild.
				player:setStorageValue(Storage.ThievesGuild.Quest, 1)
				player:setStorageValue(Storage.ThievesGuild.Mission01, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission02, 3)
				player:setStorageValue(Storage.ThievesGuild.Mission03, 3)
				player:setStorageValue(Storage.ThievesGuild.Mission04, 8)
				player:setStorageValue(Storage.ThievesGuild.Mission05, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission06, 4)
				player:setStorageValue(Storage.ThievesGuild.Mission07, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission08, 3)
				end, 3000)
				addEvent(function()
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
	
				-- KilmareshQuest
				player:setStorageValue(22000, 5) -- Town Counter
	
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
				end, 3500)
 
	
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
				player:save()
                npcHandler:say("Boa sorte!", npc, creature)
                npcHandler:setTopic(playerId, 0)
            else
                npcHandler:say("Voce nao pode possuir mais que 5.000 gold coins consigo ou no banco para viajar.", npc, creature)
                npcHandler:setTopic(playerId, 0)
            end
        elseif (MsgContains(message, "no") or MsgContains(message, "nao")) then
            npcHandler:say("Ok...", npc, creature)
            npcHandler:setTopic(playerId, 0)
        end
    end
end


npcHandler:setMessage(MESSAGE_GREET, "Se seguir este caminho voce entrara no Modo {Hardcore} e iniciara sua jornada em {Viridia}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus e boa sorte!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
