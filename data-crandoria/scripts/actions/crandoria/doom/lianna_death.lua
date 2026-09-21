local config = {
	centerPosition = Position(5052, 5147, 14),
	rangeX = 8,
	rangeY = 8,
}

local itemClasses = {
	["cobra"] = {
		30393, 30395, 30396, 30397, 30398, 30399, 30400
	},
	["lion"] = {
		34150, 34151, 34152, 34153, 34154, 34155, 34156,
		34157, 34158, 34253, 34254
	},
	["falcon"] = {
		28714, 28715, 28716, 28717, 28718, 28719, 28720,
		28721, 28723, 28724, 28725
	},
	["prismatic"] = {
		16109, 16110, 16111, 16112, 16116
	},
	["soul"] = {
		34082, 34083, 34084, 34085, 34086, 34087, 34088,
		34089, 34090, 34091, 34092, 34093, 34094, 34095,
		34096, 34099, 6534
	},
	["eldritch"] = {
		36656, 36657, 36659, 36661, 36663, 36664, 36667,
		36668, 36670, 36671, 36672, 36673, 36674, 32225
	},
	["primal"] = {
		39149, 39182, 39153, 39154, 39188, 39151, 39152,
		39185, 39147, 39148, 39179
	},
	["naga"] = {
		39155, 39156, 39157, 39159, 39162, 39163, 39165, 39167
	},
	["mutant"] = {
		40589, 40593, 40595, 40590, 40591, 40588, 40592, 40594
	},
	["sanguine"] = {
		43864, 43866, 43868, 43870, 43872, 43874, 43876, 
		43877, 43879, 43881, 43882, 43884, 43885, 43887,
	},
}

local function getRandomItemByClass()
	local classNames = {}
	for name, _ in pairs(itemClasses) do
		table.insert(classNames, name)
	end

	-- Escolhe uma classe aleatória
	local randomClass = classNames[math.random(#classNames)]

	-- Escolhe um item aleatório dentro da classe sorteada
	local classItems = itemClasses[randomClass]
	local randomItem = classItems[math.random(#classItems)]

	return randomItem, randomClass
end

local event = CreatureEvent("liannaDeath")

function event.onDeath(creature)
	if creature:getName() == "Lianna the Venomous Shadow" then
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, specCreature in pairs(spectators) do
			if specCreature:isPlayer() then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Lianna foi derrotada. Tharkor surgira na proxima sala!.")
				local storage = specCreature:getStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.ItemChance)
				local chance = math.random(storage, 10000)
				specCreature:setStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.ItemChance, storage + 1)
				if chance == 10000 then
					local itemId, className = getRandomItemByClass()
					local received = specCreature:addItem(itemId, 1)
					if received then
						specCreature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce recebeu um item raro do Boss.")
					else
						Game.createItem(randomItem, 1, specCreature:getPosition())
						specCreature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce ganhou um item raro do boss, mas seu inventario estava cheio!")
					end
				end
				local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			end
		end
		Game.createMonster("Tharkor the Double Shadow", Position(5049, 5166, 14))
	end

	return true
end

event:register()

-- local config = {
-- 	centerPosition = Position(5052, 5147, 14),
-- 	rangeX = 8,
-- 	rangeY = 8,
-- }

-- local possibleItems = {
-- 	-- cobra
-- 	30393,
-- 	30395,
-- 	30396,
-- 	30397,
-- 	30398,
-- 	30399,
-- 	30400,
-- 	-- lion
-- 	34150,
-- 	34151,
-- 	34152,
-- 	34153,
-- 	34154,
-- 	34155,
-- 	34156
-- 	34157,
-- 	34158,
-- 	34253,
-- 	34254,
-- 	-- falcon
-- 	28714,
-- 	28715,
-- 	28716,
-- 	28717,
-- 	28718,
-- 	28719,
-- 	28720,
-- 	28721,
-- 	28723,
-- 	28724,
-- 	28725,
-- 	-- prismatic
-- 	16109,
-- 	16110,
-- 	16111,
-- 	16112,
-- 	16116,
-- 	-- soul
-- 	34082,
-- 	34083,
-- 	34084,
-- 	34085,
-- 	34086,
-- 	34087,
-- 	34088,
-- 	34089,
-- 	34090,
-- 	34091,
-- 	34092,
-- 	34093,
-- 	34094,
-- 	34095,
-- 	34096,
-- 	34099,
-- 	6534,
-- 	-- eldritch
-- 	36656,
-- 	36657,
-- 	36659,
-- 	36661,
-- 	36663,
-- 	36664,
-- 	36667,
-- 	36668,
-- 	36670,
-- 	36671,
-- 	36672,
-- 	36673,
-- 	36674,
-- 	32225,
-- 	-- primal
-- 	39149,
-- 	39182,
-- 	39153,
-- 	39154,
-- 	39188,
-- 	39151,
-- 	39152,
-- 	39185,
-- 	39147,
-- 	39148,
-- 	39179,
-- 	-- sanguine
-- 	43895,
-- 	-- naga
-- 	39155,
-- 	39156,
-- 	39157,
-- 	39159,
-- 	39162,
-- 	39163,
-- 	39165,
-- 	39167,
-- 	-- mutant
-- 	40589,
-- 	40593,
-- 	40595,
-- 	40590,
-- 	40591,
-- 	40588,
-- 	40592,
-- 	40594,
-- }

-- local event = CreatureEvent("liannaDeath")

-- function event.onDeath(creature)
-- 	if creature:getName() == "Lianna the Venomous Shadow" then
-- 		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
-- 		for _, specCreature in pairs(spectators) do
-- 			if specCreature:isPlayer() then
-- 				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Lianna foi derrotada. Tharkor surgira na proxima sala!.")
-- 				local storage = specCreature:getStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.ItemChance)
-- 				local chance = math.random(storage, 2000)
-- 				local randomItem = possibleItems[math.random(1, #possibleItems)]
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.MasmorraDoCaos.ItemChance, storage + 1)
-- 				if chance == 2000 then
-- 					local received = specCreature:addItem(randomItem, 1, true)
-- 					if received then
-- 						specCreature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce recebeu um item raro do Boss.")
-- 					else
-- 						Game.createItem(randomItem, 1, specCreature:getPosition())
-- 						specCreature:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce ganhou um item raro do boss, mas seu inventario estava cheio!")
-- 					end
-- 				end
-- 			end
-- 		end
-- 		Game.createMonster("Tharkor the Double Shadow", Position(5049, 5166, 14))
-- 	end

-- 	return true
-- end

-- event:register()