-- local reputationConfig = {
-- 	{ -- donahue
-- 		storage = Storage.Quest.Crandoria.CaptainDonahue.Treasure,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 5
-- 	},
-- 	{ -- sociedade dos magos
-- 		storage = Storage.Quest.Crandoria.WorldTeleports.Access,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 5
-- 	},
-- 	{ -- crassus
-- 		storage = Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso,
-- 		type = "progress",
-- 		stages = {
-- 			{min = 6, max = 11, points = 3},
-- 			{min = 12, max = 19, points = 6},
-- 			{min = 20, max = 27, points = 9},
-- 			{min = 28, max = 31, points = 12}, -- demon helmet
-- 			{min = 32, max = 41, points = 15}, -- wrath of emperor
-- 			{min = 42, max = 49, points = 18}, 
-- 			{min = 50, max = 57, points = 21}, 
-- 			{min = 58, max = 77, points = 24}, 
-- 			{min = 78, max = 86, points = 29}, 
-- 			{min = 87, max = 97, points = 34}, 
-- 			{min = 98, max = 105, points = 39}, 
-- 			{min = 106, max = 113, points = 44}, 
-- 			{min = 114, max = 131, points = 49}, 
-- 			{min = 132, max = 139, points = 54}, 
-- 			{min = 140, max = 162, points = 59}, 
-- 			{min = 163, max = 175, points = 64}, 
-- 		}
-- 	},
-- 	{ -- ajudando alice
-- 		storage = Storage.Quest.Crandoria.AliceMcronald.Progress,
-- 		type = "threshold",
-- 		value = 17,
-- 		points = 25
-- 	},
-- 	{ -- demon helmet
-- 		storage = 6030,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 3
-- 	},
-- 	{ -- demon oak
-- 		storage = Storage.Quest.U8_2.TheDemonOak.Done,
-- 		type = "threshold",
-- 		value = 3,
-- 		points = 5
-- 	},
-- 	{ -- inq
-- 		storage = Storage.Quest.U8_2.TheInquisitionQuest.Reward,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 8
-- 	},
-- 	{ -- false god
-- 		storage = Storage.Quest.Crandoria.TheFalseGod.Progresso,
-- 		type = "threshold",
-- 		value = 9,
-- 		points = 8
-- 	},
-- 	{ -- primal ordeal
-- 		storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled,
-- 		type = "threshold",
-- 		value = 9,
-- 		points = 10
-- 	},
-- 	{ -- red path
-- 		storage = Storage.Quest.Crandoria.TheRedPath.Outfit,
-- 		type = "threshold",
-- 		value = 3,
-- 		points = 10
-- 	},
-- 	{ -- rotten blood
-- 		storage = Storage.Quest.Crandoria.RottenBloodQuest.BakragoreKilled,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 20
-- 	},
-- 	{ -- asura secret
-- 		storage = Storage.Quest.Crandoria.AsurasSecret.Reward,
-- 		type = "threshold",
-- 		value = 3,
-- 		points = 7
-- 	},
-- 	{ -- wrath of emperor
-- 		storage = Storage.Quest.U8_6.WrathOfTheEmperor.Mission12,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 5
-- 	},
-- 	{ -- forja kradok
-- 		storage = Storage.Quest.Crandoria.ForgeSystem.Door,
-- 		type = "threshold",
-- 		value = 2,
-- 		points = 20
-- 	},
-- 	{ -- lost island
-- 		storage = Storage.Quest.Crandoria.AstralisTales.Progresso,
-- 		type = "threshold",
-- 		value = 2,
-- 		points = 8
-- 	},
-- 	{ -- kozlon warlocks
-- 		storage = Storage.Quest.Crandoria.WarlocksConspiracy.Reward,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 10
-- 	},
-- 	{ -- asura palace
-- 		storage = Storage.Quest.Crandoria.AsurasSecret.TrueSecret,
-- 		type = "threshold",
-- 		value = 11,
-- 		points = 10
-- 	},
-- 	{ -- lucy
-- 		storage = Storage.Quest.Crandoria.LucyQuest.Progresso,
-- 		type = "threshold",
-- 		value = 9,
-- 		points = 3
-- 	},
-- 	{ -- into the shadows
-- 		storage = Storage.Quest.Crandoria.IntoTheShaodws.Progresso,
-- 		type = "threshold",
-- 		value = 18,
-- 		points = 5
-- 	},
-- 	{ -- soul war
-- 		storage = Storage.Quest.U12_40.SoulWar.QuestReward,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 15
-- 	},
-- 	{ -- secret library
-- 		storage = Storage.Quest.U11_80.TheSecretLibrary.ScourgeOfOblivionDoor,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 8
-- 	},
-- 	{ -- cradle of monsters
-- 		storage = Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled,
-- 		type = "threshold",
-- 		value = 2,
-- 		points = 6
-- 	},
-- 	{ -- naga queen
-- 		storage = Storage.Quest.Crandoria.NagasQuest.Progresso,
-- 		type = "threshold",
-- 		value = 27,
-- 		points = 8
-- 	},
-- 	{ -- quest violeta
-- 		storage = Storage.Quest.Crandoria.VioletaQuest.Progresso,
-- 		type = "threshold",
-- 		value = 8,
-- 		points = 5
-- 	},
-- 	-- { -- familiares
-- 	-- 	storage = Storage.Quest.Crandoria.QuestFamiliares.Progresso,
-- 	-- 	type = "threshold",
-- 	-- 	value = 16,
-- 	-- 	points = 5
-- 	-- },
-- 	{ -- POI
-- 		type = "all",
-- 		storages = {
-- 			2080,
-- 			2081,
-- 			2082,
-- 			2083,
-- 			2084,
-- 			2085,
-- 			2086
-- 		},
-- 		value = 1,
-- 		points = 10
-- 	},
-- 	{ -- kame
-- 		storage = Storage.Quest.Crandoria.OldKame.Progresso,
-- 		type = "progress",
-- 		stages = {
-- 			{min = 3, max = 8, points = 3},
-- 			{min = 9, max = 10, points = 10},
-- 		}
-- 	},
-- 	{ -- tp room
-- 		storage = Storage.Quest.Crandoria.TeleportRoom.Progresso,
-- 		type = "progress",
-- 		stages = {
-- 			{min = 3, max = 4, points = 3},
-- 			{min = 5, max = 6, points = 6},
-- 			{min = 7, max = 8, points = 9},
-- 			{min = 9, max = 10, points = 15},
-- 		}
-- 	},
-- 	{ -- yalahar
-- 		storage = Storage.Quest.U8_4.InServiceOfYalahar.Questline,
-- 		type = "threshold",
-- 		value = 54,
-- 		points = 5
-- 	},
-- 	{ -- heart of destruction
-- 		storage = 45357,
-- 		type = "threshold",
-- 		value = 1,
-- 		points = 15
-- 	},
-- 	-- {
-- 	-- 	storage = Storage.Quest.Crandoria.DracantusQuest.KillCount,
-- 	-- 	type = "formula",
-- 	-- 	calculate = function(player, value)
-- 	-- 		return 3 * value
-- 	-- 	end
-- 	-- },
	
-- }

-- local reputationOutfits = {
--     { male = 430, female = 431 },
-- 	{ male = 1597, female = 1598 },
-- 	{ male = 152, female = 156 },
-- 	{ male = 1069, female = 1070 },
-- 	{ male = 153, female = 157 },
-- 	{ male = 278, female = 279 },
-- 	{ male = 574, female = 575 },
-- 	{ male = 1386, female = 1387 },
-- 	{ male = 512, female = 513 },
-- 	{ male = 1662, female = 1663 },
-- 	{ male = 463, female = 464 },
-- 	{ male = 288, female = 289 },
-- 	{ male = 541, female = 542 },
-- 	{ male = 1094, female = 1095 },
-- 	{ male = 577, female = 578 },
-- 	{ male = 1146, female = 1147 },
-- 	{ male = 432, female = 433 },
-- 	{ male = 929, female = 931 }, -- NAO TEM?
-- 	{ male = 1568, female = 1569 },
-- 	{ male = 1460, female = 1461 },
-- 	{ male = 610, female = 618 },
-- 	{ male = 1243, female = 1244 },
-- 	{ male = 465, female = 466 },
-- 	{ male = 270, female = 273 },
-- 	{ male = 1042, female = 1043 },
-- 	{ male = 268, female = 269 },
-- 	{ male = 251, female = 252 },
-- 	{ male = 151, female = 155 },
-- 	{ male = 1270, female = 1271 },
-- 	{ male = 1371, female = 1372 },
-- 	{ male = 1322, female = 1323 },
-- 	{ male = 845, female = 846 },
-- 	{ male = 1436, female = 1437 }, -- NAO TEM?
-- 	{ male = 1456, female = 1457 }, -- NAO TEM?
-- 	{ male = 154, female = 158 },
-- 	{ male = 514, female = 516 },
-- 	-- { male = 366, female = 367 }, -- INCLUSO EM QUEST
-- 	{ male = 324, female = 325 },
-- }

-- local function calculateOutfitReputation(player)
--     local total = 0
--     local sex = player:getSex() -- 0 = female, 1 = male (normalmente)

--     for _, outfit in ipairs(reputationOutfits) do
--         local lookType = (sex == PLAYERSEX_FEMALE) and outfit.female or outfit.male

--         if lookType then
--             -- Outfit base
--             if player:hasOutfit(lookType, 0) then
--                 total = total + 1
--             end

--             -- Addon 1
--             if player:hasOutfit(lookType, 1) then
--                 total = total + 1
--             end

--             -- Addon 2
--             if player:hasOutfit(lookType, 2) then
--                 total = total + 3
--             end
--         end
--     end

--     return total
-- end

-- local function calculateReputation(player)
-- 	local total = 0

-- 	for _, quest in ipairs(reputationConfig) do
-- 		local value = player:getStorageValue(quest.storage)

-- 		if quest.type == "threshold" then
-- 			if value >= quest.value then
-- 				total = total + quest.points
-- 			end

-- 		elseif quest.type == "progress" then
-- 			for _, stage in ipairs(quest.stages) do
-- 				if value >= stage.min and value <= stage.max then
-- 					total = total + stage.points
-- 					break
-- 				end
-- 			end
-- 		elseif quest.type == "any" then
-- 			for _, storage in ipairs(quest.storages) do
-- 				if player:getStorageValue(storage) >= quest.value then
-- 					total = total + quest.points
-- 					break
-- 				end
-- 			end
-- 		elseif quest.type == "all" then
-- 			local completed = true

-- 			for _, storage in ipairs(quest.storages) do
-- 				if player:getStorageValue(storage) < quest.value then
-- 					completed = false
-- 					break
-- 				end
-- 			end

-- 			if completed then
-- 				total = total + quest.points
-- 			end
-- 		end
-- 	end

-- 	total = total + calculateOutfitReputation(player)

-- 	return total
-- end

local function getReputationRank(points)
    if points >= 1000 then
        return "Singular"
    elseif points >= 500 then
        return "Admiravel"
    elseif points >= 275 then
        return "Nobre"
    elseif points >= 175 then
        return "Ilustre"
    elseif points >= 100 then
        return "Respeitavel"
    elseif points >= 50 then
        return "Confiavel"
    elseif points >= 25 then
        return "Notavel"
    elseif points >= 10 then
        return "Amigavel"
    else
        return "Ninguem"
    end
end

-- local repStatue = Action()

-- function repStatue.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

-- 	if not player then
-- 		return true
-- 	end

-- 	local storageActivate = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Activate)
-- 	local rep = calculateReputation(player)
-- 	local rank = getReputationRank(rep)

-- 	if storageActivate < 1 then
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Activate, 1)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep)
-- 		addEvent(function()
-- 			local message =
-- 			"=== Sistema de Reputacao ===\n\n" ..
-- 			"Classificacao: " .. rank .. "\n" ..
-- 			"Pontos: " .. rep .. "\n"
-- 			player:popupFYI(message)
-- 		end, 100)
-- 	else
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja atualizou seus pontos de reputacao. Aguarde pelo update.")
-- 		player:getPosition():sendMagicEffect(CONST_ME_POFF)
-- 		return true
-- 	end
--     return true
-- end

-- repStatue:aid(13193)
-- repStatue:register()

local reputation = TalkAction("!rep")

function reputation.onSay(player, words, param)

	-- local storageActivate = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Activate)
	-- local rep = calculateReputation(player)
	-- local rank = getReputationRank(rep)

	-- if storageActivate < 1 then
	-- 	player:setStorageValue(Storage.Quest.Crandoria.Reputation.Activate, 1)
	-- 	player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep)
	-- 	addEvent(function()
	-- 		local message =
	-- 		"=== Sistema de Reputacao ===\n\n" ..
	-- 		"Classificacao: " .. rank .. "\n" ..
	-- 		"Pontos: " .. rep .. "\n"
	-- 		player:popupFYI(message)
	-- 	end, 500)
	-- else
		local points = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
		local rep1 = points > 0 and points or 0
		local rank1 = getReputationRank(points)
		local message1 =
			"=== Sistema de Reputacao ===\n\n" ..
			"Classificacao: " .. rank1 .. "\n" ..
			"Pontos: " .. rep1 .. "\n"
		player:popupFYI(message1)
	-- end
    return true
end

reputation:groupType("normal")
reputation:register()