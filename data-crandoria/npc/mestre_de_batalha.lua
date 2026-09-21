local internalNpcName = "Mestre de Batalha"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1137,
	lookHead = 0,
	lookBody = 84,
	lookLegs = 114,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0
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


    local battlePassMissions = {
		[1] = { -- Janeiro
			{ name = "Dragons", raceId = 34, amount = 1000 },
			{ name = "Heroes", raceId = 73, amount = 1000 },
			{ name = "Hydras", raceId = 121, amount = 1000 },
			{ name = "Medusas", raceId = 570, amount = 1500 },
			{ name = "Mitmah Scout", raceId = 2460, amount = 2500 }
		},
		[2] = { -- Fevereiro
			{ name = "Giant Spiders", raceId = 38, amount = 1000 },
			{ name = "Hydras", raceId = 121, amount = 1000 },
			{ name = "Wyrms", raceId = 461, amount = 1000 },
			{ name = "Deepling Guards", raceId = 770, amount = 1500 },
			{ name = "Medusas", raceId = 570, amount = 2500 }
		},
		[3] = { -- Março
			{ name = "Bog Raiders", raceId = 460, amount = 1000 },
			{ name = "Vampire Brides", raceId = 483, amount = 1000 },
			{ name = "Dragon Lords", raceId = 39, amount = 1000 },
			{ name = "Gazer Spectres", raceId = 1725, amount = 1500 },
			{ name = "Demon Outcasts", raceId = 1019, amount = 2500 }
		},
		[4] = { -- abril
			{ name = "Earth Elementals", raceId = 458, amount = 1000 },
			{ name = "Wyrms", raceId = 461, amount = 1000 },
			{ name = "Frost Dragons", raceId = 317, amount = 1000 },
			{ name = "Foam Stalkers", raceId = 2259, amount = 1500 },
			{ name = "Adult Goannas", raceId = 1818, amount = 2500 }
		},
		[5] = { -- maio
			{ name = "Ancient Scarabs", raceId = 79, amount = 1000 },
			{ name = "Pirat Bombardiers", raceId = 2038, amount = 1000 },
			{ name = "Lumbering Carnivors", raceId = 1721, amount = 1000 },
			{ name = "Fury", raceId = 291, amount = 1500 },
			{ name = "Crypt Wardens", raceId = 1805, amount = 2500 }
		},
		[6] = { -- junho
			{ name = "Exotic Cave Spiders", raceId = 2024, amount = 1000 },
			{ name = "Glooth Brigands", raceId = 1120, amount = 1000 },
			{ name = "Werelions", raceId = 1965, amount = 1000 },
			{ name = "Frazzlemaws", raceId = 1022, amount = 1500 },
			{ name = "Lava Golems", raceId = 884, amount = 2500 }
		},
		[7] = { -- julho
			{ name = "Vampire Viscounts", raceId = 958, amount = 1000 },
			{ name = "Werebears", raceId = 1142, amount = 1000 },
			{ name = "Spiky Carnivors", raceId = 1722, amount = 1000 },
			{ name = "Betrayed Wraiths", raceId = 284, amount = 1500 },
			{ name = "Falcon Knights", raceId = 1646, amount = 2500 }
		},
		[8] = { -- agosto
			{ name = "Orclops Ravagers", raceId = 1320, amount = 1000 },
			{ name = "Glooth Bandits", raceId = 1119, amount = 1000 },
			{ name = "Lizard Zaoguns", raceId = 616, amount = 1000 },
			{ name = "Draken Warmasters", raceId = 617, amount = 1500 },
			{ name = "True Midnight Asuras", raceId = 1621, amount = 2500 }
		},
		[9] = { -- setembro
			{ name = "Lost Exile", raceId = 1529, amount = 1000 },
			{ name = "Minotaur Amazon", raceId = 1045, amount = 1000 },
			{ name = "Goggle Cake", raceId = 2534, amount = 1000 },
			{ name = "Flimsy Lost Soul", raceId = 1864, amount = 1500 },
			{ name = "Girtablilu Warrior", raceId = 2099, amount = 2500 }
		},
		[10] = { -- outubro
			{ name = "Dragons", raceId = 34, amount = 1000 },
			{ name = "Hydras", raceId = 121, amount = 1000 },
			{ name = "Nibblemaw", raceId = 2531, amount = 1000 },
			{ name = "Grim Reapers", raceId = 465, amount = 1500 },
			{ name = "Adult Goannas", raceId = 1818, amount = 2500 }
		},
		[11] = { -- novembro
			{ name = "Ancient Scarabs", raceId = 79, amount = 1000 },
			{ name = "Giant Spiders", raceId = 38, amount = 1000 },
			{ name = "Lion Hydras", raceId = 2678, amount = 1000 },
			{ name = "Fury", raceId = 291, amount = 1500 },
			{ name = "Demon Outcasts", raceId = 1019, amount = 2500 }
		},
		[12] = { -- dezembro
			{ name = "Heroes", raceId = 73, amount = 1000 },
			{ name = "Wyrms", raceId = 461, amount = 1000 },
			{ name = "Lumbering Carnivors", raceId = 1721, amount = 1000 },
			{ name = "Frazzlemaws", raceId = 1022, amount = 1500 },
			{ name = "Candy Floss Elementals", raceId = 2533, amount = 2500 }
		},
	}

	local itemsToGet ={
		[1] = {
			{ name = "Arena Tokens", id = 22720, amount = 5 },
			{ name = "Demon Shield", id = 3420, amount = 5 },
			{ name = "Magic Plate Armor", id = 3366, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Red Pieces of Cloth", id = 5911, amount = 50 },
			{ name = "Tremendous Tyrant Head", id = 36783, amount = 25 },
		},
		[2] = {
			{ name = "Giant Sapphire", id = 30061, amount = 5 },
			{ name = "Steel Boots", id = 3554, amount = 5 },
			{ name = "Golden Legs", id = 3364, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Yellow Pieces of Cloth", id = 5914, amount = 50 },
			{ name = "Rhindeer Antlers", id = 40587, amount = 25 },
		},
		[3] = {
			{ name = "Gold Tokens", id = 22721, amount = 5 },
			{ name = "Boots of Haste", id = 3079, amount = 5 },
			{ name = "Mastermind Shield", id = 3414, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Green Pieces of Cloth", id = 5910, amount = 50 },
			{ name = "Headpecker Feathers", id = 39388, amount = 25 },
		},
		[4] = {
			{ name = "Silver Tokens", id = 22516, amount = 5 },
			{ name = "Royal Helmets", id = 3392, amount = 5 },
			{ name = "Rings of the Sky", id = 3006, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Blue Pieces of Cloth", id = 5912, amount = 50 },
			{ name = "Undertaker Fangs", id = 39380, amount = 25 },
		},
		[5] = {
			{ name = "Arena Tokens", id = 22720, amount = 5 },
			{ name = "Steel Boots", id = 3554, amount = 5 },
			{ name = "Magic Plate Armor", id = 3366, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "White Pieces of Cloth", id = 5909, amount = 50 },
			{ name = "Prehemoth Claws", id = 39383, amount = 25 },
		},
		[6] = {
			{ name = "Giant Sapphire", id = 30061, amount = 5 },
			{ name = "Steel Boots", id = 3554, amount = 5 },
			{ name = "Golden Legs", id = 3364, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Yellow Pieces of Cloth", id = 5914, amount = 50 },
			{ name = "Rhindeer Antlers", id = 40587, amount = 25 },
		},
		[7] = {
			{ name = "Gold Tokens", id = 22721, amount = 5 },
			{ name = "Boots of Haste", id = 3079, amount = 5 },
			{ name = "Mastermind Shield", id = 3414, amount = 3 },
			{ name = "Clusters of Solace", id = 20062, amount = 25 },
			{ name = "Green Pieces of Cloth", id = 5910, amount = 50 },
			{ name = "Headpecker Feathers", id = 39388, amount = 25 },
		},
		[8] = {
			{ name = "Silver Tokens", id = 22516, amount = 5 },
			{ name = "Dreaded Cleaver", id = 7419, amount = 5 },
			{ name = "Hexagonal Ruby", id = 30180, amount = 3 },
			{ name = "Magic Sulphur", id = 5904, amount = 25 },
			{ name = "Essences of a Bad Dream", id = 10306, amount = 50 },
			{ name = "Gorerilla Manes", id = 39392, amount = 25 },
		},
		[9] = {
			{ name = "Arena Tokens", id = 22720, amount = 5 },
			{ name = "Haunted Blades", id = 7407, amount = 5 },
			{ name = "Flasks of Warrior's Sweat", id = 5885, amount = 3 },
			{ name = "Basalt Fetish", id = 17856, amount = 25 },
			{ name = "Heaven Blossom", id = 5921, amount = 50 },
			{ name = "Ensouled Essence", id = 32698, amount = 25 },
		},
		[10] = {
			{ name = "Giant Sapphire", id = 30061, amount = 5 },
			{ name = "Demon Shields", id = 3420, amount = 5 },
			{ name = "Glorious Axes", id = 7454, amount = 3 },
			{ name = "Bone Shoulderplate", id = 10404, amount = 25 },
			{ name = "Cave Devourer Legs", id = 27601, amount = 50 },
			{ name = "Bonelord Eyes", id = 5898, amount = 25 },
		},
		[11] = {
			{ name = "Gold Tokens", id = 22721, amount = 5 },
			{ name = "Fire Axes", id = 3320, amount = 5 },
			{ name = "Jade Hats", id = 10451, amount = 3 },
			{ name = "Cliff Strider Claws", id = 16134, amount = 25 },
			{ name = "Deepling Claws", id = 14044, amount = 50 },
			{ name = "Prehemoth Claws", id = 39383, amount = 25 },
		},
		[12] = {
			{ name = "Silver Tokens", id = 22516, amount = 5 },
			{ name = "Vampire Shields", id = 3434, amount = 5 },
			{ name = "Skull Helmets", id = 5741, amount = 3 },
			{ name = "Crab Man Claws", id = 40582, amount = 25 },
			{ name = "Dead Weights", id = 20202, amount = 50 },
			{ name = "Sabretooth Furs", id = 39378, amount = 25 },
		},
	}

	local battlePassBoss = {
		[1] = { -- Janeiro
			{ name = "Grand Master Oberon", amount = 5, id = 1 },
		},
		[2] = { -- Fevereiro
			{ name = "Drume", amount = 5, id = 2 },
		},
		[3] = { -- Março
			{ name = "Scarlett Etzel", amount = 5, id = 3 },
		},
		[4] = { -- abril
			{ name = "Jaul", amount = 5, id = 4 },
		},
		[5] = { -- maio
			{ name = "Grand Master Oberon", amount = 5, id = 1 },
		},
		[6] = { -- junho
			{ name = "King Zelos", amount = 5, id = 5 },
		},
		[7] = { -- julho
			{ name = "Scarlett Etzel", amount = 5, id = 3 },
		},
		[8] = { -- agosto
			{ name = "Drume", amount = 5, id = 2 },
		},
		[9] = { -- setembro
			{ name = "Zarabastan", amount = 5, id = 6 },
		},
		[10] = { -- outubro
			{ name = "Scarlett Etzel", amount = 5, id = 3 },
		},
		[11] = { -- novembro
			{ name = "Grand Master Oberon", amount = 5, id = 1 },
		},
		[12] = { -- dezembro
			{ name = "King Zelos", amount = 5, id = 5 },
		},
	}



    local storageTimer = Storage.Quest.Crandoria.PasseDeBatalha.TimerMensal
    local storagePasse = Storage.Quest.Crandoria.PasseDeBatalha.Passe
	local storageProgress = Storage.Quest.Crandoria.PasseDeBatalha.Progresso
    local storageHunt = Storage.Quest.Crandoria.PasseDeBatalha.Hunt
    local storageHuntCount = Storage.Quest.Crandoria.PasseDeBatalha.HuntCount

    local currentTime = os.time()
    local currentDate = os.date("*t", currentTime)
    local lastPassTime = player:getStorageValue(storageTimer)
    local lastPassDate = os.date("*t", lastPassTime)

	local reset = player:getStorageValue(Storage.Quest.Crandoria.DracantusQuest.KillCount)

	if reset < 1 then
		reset = 0
	end

	local factorXp = 1 + (0.35 * reset)

	-- JANEIRO --

    if MsgContains(message, "missao") or MsgContains(message, "missoes") then
		if lastPassTime == -1 or lastPassDate.year ~= currentDate.year or lastPassDate.month ~= currentDate.month then
			npcHandler:say("Voce nao possui um Passe de Batalha ativo para este mes. Compre um novo passe, ative-o e tente novamente.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		else
			if player:getStorageValue(storageProgress) > 25 and player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Mes) == currentDate.month then
				npcHandler:say("Voce ja completou todas as missoes deste mes!", npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				if player:getStorageValue(storageProgress) == 1 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[1]
					npcHandler:say("Sua primeira missao sera derrotar " .. mission.amount .. " " .. mission.name .. ". Va e so retorne quando tiver matado todos! Estarei esperando com sua recompensa.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 2)
					player:setStorageValue(storageHuntCount, 0)
					player:setStorageValue(storageHunt, mission.raceId)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 2 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[1]
					if player:getStorageValue(storageHuntCount) == 1000 then
						if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 50 then
							local container = player:addItem(8861, 1)
							npcHandler:say("Muito bem! Voce completou a missao rapidamente. Como recompensa te entregarei 100.000 gold coins, 1 exercise stash, um bestiary betterment e um pouco de experiencia. \z
							Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
							container:addItem(3043, 10)
							container:addItem(36728, 1)
							container:addItem(26186, 1)
							player:addExperience(((player:getLevel() / 15 )* 250000) * factorXp)
							player:setStorageValue(storageProgress, 3)
							player:setStorageValue(storageHuntCount, 0)
							player:setStorageValue(storageHunt, 0)
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Voce precisa de 2 slots vazios no inventario e 50 de cap para obter a recompensa.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Sua missao e derrotar " .. mission.amount .. " " .. mission.name .. ". Continue e volte quando terminar!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 3 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[1]
					npcHandler:say("Sua proxima missao sera me trazer alguns itens de valor. Busque por 5 " .. items.name .. " e traga para mim. Estarei te esperando.", npc, creature)
					player:setStorageValue(storageProgress, 4)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, items.id)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 4 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[1]
					npcHandler:say("Voce trouxe os 5 " .. items.name .. " que eu solicitei?", npc, creature)
					npcHandler:setTopic(playerId, 1)
				elseif player:getStorageValue(storageProgress) == 5 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[2]
					npcHandler:say("Sua proxima missao sera mais desafiadora. Derrote " .. mission.amount .. " " .. mission.name .. ". Tenha cuidado! Retorne quando finalizar a tarefa.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 6)
					player:setStorageValue(storageHuntCount, 0)
					player:setStorageValue(storageHunt, mission.raceId)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 6 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[2]
					if player:getStorageValue(storageHuntCount) == 1000 then
						if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 50 then
							local container = player:addItem(8861, 1)
							npcHandler:say("Muito bem! Voce completou a missao. Como recompensa te entregarei 300.000 gold coins, 1 Full Stamina Refill, 2 Casino Tickets e uma boa quantidade de experiencia. \z
							Me avise quando estiver pronto para a próxima {missao}.", npc, creature)
							container:addItem(3043, 30)
							container:addItem(20139, 1)
							container:addItem(637, 1)
							container:addItem(637, 1)
							player:addExperience(((player:getLevel() / 15 ) * 500000) * factorXp)
							player:setStorageValue(storageProgress, 7)
							player:setStorageValue(storageHuntCount, 0)
							player:setStorageValue(storageHunt, 0)
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Voce precisa de 2 slots vazios no inventario e 50 de cap para obter a recompensa.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Sua missao e derrotar " .. mission.amount .. " " .. mission.name .. ". Continue e volte quando terminar!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 7 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[2]
					npcHandler:say("Talvez sua proxima missao te traga um pouco mais de desafio. Exigira que voce cace as criaturas certas... Traga-me 5 " .. items.name .." e te darei uma boa recompensa. Estarei esperando.", npc, creature)
					player:setStorageValue(storageProgress, 8)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, items.id)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 8 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[2]
					npcHandler:say("Voce trouxe os 5 " .. items.name .. " que eu solicitei?", npc, creature)
					npcHandler:setTopic(playerId, 2)
				elseif player:getStorageValue(storageProgress) == 9 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[3]
					npcHandler:say("Pronto para uma nova batalha? Sua proxima missao sera buscar e derrotar " .. mission.amount .. " " .. mission.name .. ". Agora as coisas comecam a ficar mais interessantes... Volte quando terminar a matanca!", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 10)
					player:setStorageValue(storageHuntCount, 0)
					player:setStorageValue(storageHunt, mission.raceId)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 10 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[3]
					if player:getStorageValue(storageHuntCount) == 1000 then
						if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
							local container = player:addItem(8861, 1)
							npcHandler:say("Incrivel! Voce completou mesmo a missao. Como recompensa agora voce recebera 600.000 gold coins, 2 Small Stamina Refills, 5 Demonic Candy Balls e uma boa quantidade de experiencia. \z
							Me avise quando estiver pronto para a próxima {missao}.", npc, creature)
							container:addItem(3043, 60)
							container:addItem(20138, 1)
							container:addItem(20138, 1)
							container:addItem(11587, 5)
							player:addExperience(((player:getLevel() / 15 )* 650000) * factorXp)
							player:setStorageValue(storageProgress, 11)
							player:setStorageValue(storageHuntCount, 0)
							player:setStorageValue(storageHunt, 0)
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Sua missao e derrotar " .. mission.amount .. " " .. mission.name .. ". Continue e volte quando terminar!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 11 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[3]
					npcHandler:say("Voce ja foi um colecionador? Se sim, talvez essa missao seja facil para voce. Traga-me 3 " .. items.name .." e te darei uma recompensa ainda melhor que a ultima! Va! Estarei esperando.", npc, creature)
					player:setStorageValue(storageProgress, 12)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, items.id)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 12 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items = itemNeeded[3]
					npcHandler:say("Voce trouxe os 3 " .. items.name .. " que eu solicitei?", npc, creature)
					npcHandler:setTopic(playerId, 3)
				elseif player:getStorageValue(storageProgress) == 13 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[4]
					npcHandler:say("Voce agora vai buscar por criaturas um pouco mais desfiadoras. Prepare-se! Voce deve derrotar " .. mission.amount .. " " .. mission.name .. ". Sera que voce consegue? Veremos em breve... Mate todos e retorne ate mim com vida!", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 14)
					player:setStorageValue(storageHuntCount, 0)
					player:setStorageValue(storageHunt, mission.raceId)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 14 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[4]
					if player:getStorageValue(storageHuntCount) == 1500 then
						if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
							local container = player:addItem(8861, 1)
							npcHandler:say("Voce parece estar ficando cada dia mais forte. Simplesmente magnifico! Como recompensa pela missao estou te entregando 1.000.000 gold coins, 1 Exercise Stash, 1 Bestiary Betterment e uma boa quantidade de experiencia. \z
							Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
							container:addItem(14112, 1)
							container:addItem(36728, 1)
							container:addItem(26186, 1)
							player:addExperience(((player:getLevel() / 15 )* 900000) * factorXp)
							player:setStorageValue(storageProgress, 15)
							player:setStorageValue(storageHuntCount, 0)
							player:setStorageValue(storageHunt, 0)
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Sua missao e derrotar " .. mission.amount .. " " .. mission.name .. ". Continue e volte quando terminar!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 15 then
					local selectBoss = battlePassBoss[currentDate.month]
					local boss = selectBoss[1]
					npcHandler:say("Sua missao agora sera enfrentar um temivel Boss algumas vezes, para provar seu valor como guerreiro de Crandoria. Saia e derrote " .. boss.name .. " pelo menos " .. boss.amount .. " vezes. Retorne quando finalizar a missao!", npc, creature)
					player:setStorageValue(storageProgress, 16)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, boss.id)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) >= 16 and player:getStorageValue(storageProgress) < 21 then
					local selectBoss = battlePassBoss[currentDate.month]
					local boss = selectBoss[1]
					npcHandler:say("Voce ainda nao finalizou sua missao. Derrote " .. boss.name .. " pelo menos " .. boss.amount .. " vezes.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 21 then
					local selectBoss = battlePassBoss[currentDate.month]
					local boss = selectBoss[1]
					if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
						npcHandler:say("Cinco foi o numero de vezes que voce demonstrou quem realmente pode ser o mais forte para " .. boss.name .. ". Impressionante! Simplesmente impressionante. \z
						Aqui, sua recompensa: 1.000.000 gold coins, 2 Exercise Stashes, 1 Bestiary Betterment, 1 Bronze Medal, 1 Espelho do Mercador e uma grande quantidade de experiencia.", npc, creature)
						local container = player:addItem(8861, 1)
						container:addItem(14112, 1)
						container:addItem(36728, 1)
						container:addItem(26186, 1)
						container:addItem(26186, 1)
						container:addItem(9217, 1)
						container:addItem(36875, 1)
						player:addExperience(((player:getLevel() / 15 )* 900000) * factorXp)
						player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, 0)
						player:setStorageValue(storageProgress, 22)
						npcHandler:setTopic(playerId, 0)
					else
						npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 22 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[5]
					npcHandler:say("Esta sera sua penultima missao do Passe de Batalha deste mes. Espero que esteja preparado... Saia e derrote " .. mission.amount .. " " .. mission.name .. ". \z
					Tenha muito cuidado. Essas criaturas sao poderosas e podem causar problemas... Estarei esperando pelo seu retorno.", npc, creature)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 23)
					player:setStorageValue(storageHuntCount, 0)
					player:setStorageValue(storageHunt, mission.raceId)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 23 then
					local monthMissions = battlePassMissions[currentDate.month]
					local mission = monthMissions[5]
					if player:getStorageValue(storageHuntCount) == 2500 then
						if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 50 then
							local container = player:addItem(8861, 1)
							npcHandler:say("Nao preciso dizer mais que voce realmente me impressiona, nao e mesmo? Aqui, sua recompensa: 1.000.000 gold coins, 1 Special Casino Ticket, 1 Espelho do Mercador e muita experiencia! \z
							Dessa vez tambem vou te conceder uma nova montaria por 30 dias - O Jousting Eagle. Essa montaria te dara +50 Speed. Me avise quando estiver pronto para a sua ultima {missao}.", npc, creature)
							container:addItem(14112, 1)
							container:addItem(22706, 1)
							container:addItem(36875, 1)
							player:addMount(145)
							player:addExperience(((player:getLevel() / 15 )* 1000000) * factorXp)
							player:setStorageValue(storageProgress, 24)
							player:setStorageValue(storageHuntCount, 0)
							player:setStorageValue(storageHunt, 0)
							player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Mount, os.time() + 30 * 24 * 60 * 60)
							npcHandler:setTopic(playerId, 0)
						else
							npcHandler:say("Voce precisa de 2 slots vazios no inventario e 50 de cap para obter a recompensa.", npc, creature)
							npcHandler:setTopic(playerId, 0)
						end
					else
						npcHandler:say("Sua missao e derrotar " .. mission.amount .. " " .. mission.name .. ". Continue e volte quando terminar!", npc, creature)
						npcHandler:setTopic(playerId, 0)
					end
				elseif player:getStorageValue(storageProgress) == 24 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items1 = itemNeeded[4]
					local items2 = itemNeeded[5]
					local items3 = itemNeeded[6]
					npcHandler:say("Sua ultima missao chegou. Nao sera uma missao facil, mas voce pode encontrar metodos para chegar mais rapido aos seus objetivos... Preciso que me traga alguns materiais. \z
					Voce devera me trazer 25 " .. items1.name .. ", 50 " .. items2.name .. " e 25 " .. items3.name .. ". Estarei esperando pelo seu retorno. Nao me decepcione.", npc, creature)
					player:setStorageValue(storageProgress, 25)
					npcHandler:setTopic(playerId, 0)
				elseif player:getStorageValue(storageProgress) == 25 then
					local itemNeeded = itemsToGet[currentDate.month]
					local items1 = itemNeeded[4]
					local items2 = itemNeeded[5]
					local items3 = itemNeeded[6]
					npcHandler:say("Voce trouxe os 25 " .. items1.name .. ", 50 " .. items2.name .. " e 25 " .. items3.name .. " que eu solicitei?", npc, creature)
					npcHandler:setTopic(playerId, 4)
				end
			end
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
		if npcHandler:getTopic(playerId) == 1 then
			local itemNeeded = itemsToGet[currentDate.month]
			local items = itemNeeded[1]
			if player:getItemCount(items.id) >= 5 then
				if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 50 then
					local container = player:addItem(8861, 1)
					player:removeItem(items.id, 5)
					npcHandler:say("Muito bem! Estava precisando muito disso. Aqui, sua recompensa: 200.000 gold coins, 2 Small Stamina Refills e uma quantiadde moderada de experiência.", npc, creature)
					container:addItem(3043, 20)
					container:addItem(20138, 1)
					container:addItem(20138, 1)
					player:addExperience(((player:getLevel() / 15 )* 350000) * factorXp)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, 0)
					player:setStorageValue(storageProgress, 5)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce precisa de 2 slots vazios no inventario e 50 de cap para obter a recompensa.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui todos os itens. Lembre-se: preciso de 5 " .. items.name ..". Traga-os para mim.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			local itemNeeded = itemsToGet[currentDate.month]
			local items = itemNeeded[2]
			if player:getItemCount(items.id) >= 5 then
				if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
					local container = player:addItem(8861, 1)
					player:removeItem(items.id, 5)
					npcHandler:say("Voce conseguiu mesmo! Excelente! Aqui, como prometido, sua recompensa: 450.000 gold coins, 200 Yummy Gummy Worms, 1 Chaotic Jar, 1 Exercise Stash, 1 Wealth Duplex e uma quantidade moderada de experiencia.", npc, creature)
					container:addItem(36727, 1)
					container:addItem(39707, 1)
					container:addItem(26186, 1)
					container:addItem(3043, 45)
					container:addItem(8177, 100)
					container:addItem(8177, 100)
					player:addExperience(((player:getLevel() / 15 )* 500000) * factorXp)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, 0)
					player:setStorageValue(storageProgress, 9)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui todos os itens. Lembre-se: preciso de 5 " .. items.name ..". Traga-os para mim.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 3 then
			local itemNeeded = itemsToGet[currentDate.month]
			local items = itemNeeded[3]
			if player:getItemCount(items.id) >= 3 then
				if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
					local container = player:addItem(8861, 1)
					player:removeItem(items.id, 3)
					npcHandler:say("Otimo! Ficara otimo na minha colecao. Aqui, sua recompensa: 800.000 gold coins, 1 Silver Medal, 2 Wealth Duplex, 1 Addon Doll e uma boa quantidade de experiencia.", npc, creature)
					container:addItem(9219, 1)
					container:addItem(3043, 80)
					container:addItem(8778, 1)
					container:addItem(9216, 1)
					container:addItem(36727, 2)
					player:addExperience(((player:getLevel() / 15 )* 800000) * factorXp)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item, 0)
					player:setStorageValue(storageProgress, 13)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui todos os itens. Lembre-se: preciso de 3 " .. items.name ..". Traga tudo para mim e tera sua recompensa.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 4 then
			local itemNeeded = itemsToGet[currentDate.month]
			local items1 = itemNeeded[4]
			local items2 = itemNeeded[5]
			local items3 = itemNeeded[6]
			if player:getItemCount(items1.id) >= 25 and player:getItemCount(items2.id) >= 50 and player:getItemCount(items3.id) >= 25 then
				if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 100 then
					local container = player:addItem(8861, 1)
					player:removeItem(items1.id, 25)
					player:removeItem(items2.id, 50)
					player:removeItem(items3.id, 25)
					npcHandler:say("Voce conseguiu mesmo! Demonstrou ser um grande guerreiro de Crandoria e um importante recurso para a cidade. Aqui, sua ultima recompensa: Uma grande quantidade de experiencia, claro... \z
					Alem disso, 2.000.000 gold coins, 1 Gold Medal, 1 Chaotic Jar, 1 Chaotic Gamble, 1 Blessed Symbol e 3 Espelhos do Mercador. Por fim, te concedo o Dragon Slayer Outfits por 30 dias. Com ele voce tera um bonus de 5% de experiencia bonus. \z
					Retorne no proximo mes com um novo passe e te darei mais missoes.", npc, creature)
					container:addItem(14112, 2)
					container:addItem(9215, 1)
					container:addItem(12811, 1)
					container:addItem(36875, 3)
					container:addItem(11468, 1)
					container:addItem(39707, 1)
					player:addOutfit(1288)
					player:addOutfit(1289)
					player:addOutfitAddon(1288, 1)
					player:addOutfitAddon(1289, 1)
					player:addOutfitAddon(1288, 2)
					player:addOutfitAddon(1289, 2)
					player:addExperience(((player:getLevel() / 15 )* 1500000) * factorXp)
					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Outfit, os.time() + 30 * 24 * 60 * 60)
					player:setStorageValue(storageProgress, 26)
					local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                    player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 30)
                    player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
					npcHandler:setTopic(playerId, 0)
				else
					npcHandler:say("Voce precisa de 2 slots vazios no inventario e 100 de cap para obter a recompensa.", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("Voce nao possui todos os itens. Traga tudo para mim e tera sua recompensa.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end



end



npcHandler:setMessage(MESSAGE_GREET, "Saudacoes. Sou o responsavel pelas {missoes} do Passe de Batalha.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:addDialogOptions("bye")
-- npcType registering the npcConfig table
npcType:register(npcConfig)



-- local internalNpcName = "Mestre de Batalha"
-- local npcType = Game.createNpcType(internalNpcName)
-- local npcConfig = {}

-- npcConfig.name = internalNpcName
-- npcConfig.description = internalNpcName

-- npcConfig.health = 100
-- npcConfig.maxHealth = npcConfig.health
-- npcConfig.walkInterval = 0
-- npcConfig.walkRadius = 2

-- npcConfig.outfit = {
-- 	lookType = 1137,
-- 	lookHead = 0,
-- 	lookBody = 84,
-- 	lookLegs = 114,
-- 	lookFeet = 95,
-- 	lookAddons = 3,
-- 	lookMount = 0
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
--     local player = Player(creature)
--     local playerId = player:getId()

--     if not npcHandler:checkInteraction(npc, creature) then
--         return false
--     end
    


--     local storageTimer = Storage.Quest.Crandoria.PasseDeBatalha.TimerMensal
--     local storagePasse = Storage.Quest.Crandoria.PasseDeBatalha.Passe
--     local currentTime = os.time()
--     local currentDate = os.date("*t", currentTime)
--     local lastPassTime = player:getStorageValue(storageTimer)
--     local lastPassDate = os.date("*t", lastPassTime)

-- 	-- JANEIRO --

--     if MsgContains(message, "missao") then
-- 		if lastPassTime == -1 or lastPassDate.year ~= currentDate.year or lastPassDate.month ~= currentDate.month then
-- 			npcHandler:say("Voce nao possui um Passe de Batalha ativo para este mes. Compre um novo passe, ative-o e tente novamente.", npc, creature)
-- 			npcHandler:setTopic(playerId, 0)
-- 		else
-- 			if currentDate.month == 1 then
-- 				if player:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso) == 1 then
-- 					npcHandler:say("Para sua primeira missao do Passe de Batalha, voce devera derrotar 250 Dragons. Derrote-os e retorne ate mim.", npc, creature)
-- 					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 2)
-- 					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Hunt, 34)
-- 					player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.HuntCount, 1)
-- 					npcHandler:setTopic(playerId, 0)
-- 				elseif player:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso) == 2 then
-- 					if player:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.HuntCount) >= 250 then
-- 						npcHandler:say("Voce retornou mais rapido do que eu esperava. Muito bem, como recompensa voce recebera 50.000 gold coins, 2 Exercise Stashes e um pouco de experiencia. \z
-- 						Me avise quando estiver pronto para a proxima {missao}.", npc, creature)
-- 						player:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, 3)
-- 						npcHandler:setTopic(playerId, 0)
-- 					else
-- 						npcHandler:say("Ainda nao matou todos os dragons? Va! Retorne quando tiver matado todos os 250 dragons.", npc, creature)
-- 						npcHandler:setTopic(playerId, 0)
-- 					end
-- 				end
-- 			end
-- 		end




--     elseif MsgContains(message, "primeiro") or MsgContains(message, "first") then
-- 		npcHandler:say("Para o primeiro addon voce devera entregar 5 Pomegranades. Voce possui todos os itens com voce?", npc, creature)
-- 		npcHandler:setTopic(playerId, 2)
--     elseif MsgContains(message, "segundo") or MsgContains(message, "second") then
-- 		npcHandler:say("Para o segundo addon voce devera entregar 1 Ice Shield. Voce possui o iten com voce?", npc, creature)
-- 		npcHandler:setTopic(playerId, 3)
--     elseif MsgContains(message, "yes") or MsgContains(message, "sim") then
-- 		if npcHandler:getTopic(playerId) == 2 then
-- 			if player:getItemCount(30169) >= 5 then
-- 				player:removeItem(30169, 5)
-- 				player:addOutfitAddon(1146, 1)
-- 				player:addOutfitAddon(1147, 1)
-- 				npcHandler:say("Muito bem! Aqui esta seu primeiro addon.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Parece que voce nao possui todos os itens...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		elseif npcHandler:getTopic(playerId) == 3 then
-- 			if player:getItemCount(30168) >= 1 then
-- 				player:removeItem(30168, 1)
-- 				player:addOutfitAddon(1146, 2)
-- 				player:addOutfitAddon(1147, 2)
-- 				npcHandler:say("Muito bem! Aqui esta seu segundo addon.", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			else
-- 				npcHandler:say("Parece que voce nao possui o Ice Shield...", npc, creature)
-- 				npcHandler:setTopic(playerId, 0)
-- 			end
-- 		end
-- 	end
-- end


-- npcHandler:setMessage(MESSAGE_GREET, "Saudacoes. Em troca de alguns itens posso te entregar os {addon}s do Dream Warrior Outfit.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais!")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais.")

-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- -- npcType registering the npcConfig table
-- npcType:register(npcConfig)
