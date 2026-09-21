-- local config = {
-- 	boss = {
-- 		name = "World Devourer",
-- 		position = Position(5515, 4772, 15)
-- 	},
-- 	requiredLevel = 150,
-- 	timeToFightAgain = 24 * 60 * 60,
-- 	timeToDefeatBoss = 20 * 60,
-- 	playerPositions = {
-- 		{pos = Position(5497, 4791, 15), teleport = Position(5514, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5496, 4791, 15), teleport = Position(5514, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5498, 4791, 15), teleport = Position(5514, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5497, 4792, 15), teleport = Position(5513, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5496, 4792, 15), teleport = Position(5513, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5498, 4792, 15), teleport = Position(5513, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5497, 4793, 15), teleport = Position(5512, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5496, 4793, 15), teleport = Position(5512, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5498, 4793, 15), teleport = Position(5512, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5497, 4794, 15), teleport = Position(5515, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5496, 4794, 15), teleport = Position(5515, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5498, 4794, 15), teleport = Position(5515, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5497, 4795, 15), teleport = Position(5516, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5496, 4795, 15), teleport = Position(5516, 4783, 15), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5498, 4795, 15), teleport = Position(5516, 4783, 15), effect = CONST_ME_TELEPORT}
-- 	},
-- 	specPos = {
-- 		from = Position(5503, 4761, 15),
-- 		to = Position(5527, 4785, 15)
-- 	},
-- 	exit = Position(5469, 4752, 15),
-- 	storage = Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer
-- }

-- local WorldDevourerLever = Action()
-- function WorldDevourerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	return CreateDefaultLeverBoss(player, config)
-- end

-- WorldDevourerLever:position({x = 5497, y = 4790, z = 15})
-- WorldDevourerLever:register()

--[[
Storages:
The Hunger = 14334
The Destruction = 14335
The Rage = 14336
]]
--
-- FUNCTIONS
function sparkDevourerSpawn()
    local positions = {
        { x = 5572, y = 4820, z = 15 },
        { x = 5579, y = 4821, z = 15 },
        { x = 5573, y = 4831, z = 15 },
        { x = 5581, y = 4830, z = 15 },
    }

    if sparkSpawnCount > 0 then
        for i = 1, sparkSpawnCount do
            Game.createMonster("Spark of Destruction2", positions[i], false, true)
        end
        sparkSpawnCount = 0
    end
    areaDevourer6 = addEvent(sparkDevourerSpawn, 10000)
end

local function doCheckArea()
	local upConer = { x = 5564, y = 4815, z = 15 } -- upLeftCorner
	local downConer = { x = 5587, y = 4839, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							local player = Player(creature)
							if player then
								return true
							end
						end
					end
				end
			end
		end
	end

	for _, online in ipairs(Game.getPlayers()) do
		if online:isPlayer() then
			if online:getStorageValue(14334) >= 1 or online:getStorageValue(14335) >= 1 or online:getStorageValue(14336) >= 1 then
				return true
			end
		end
	end

	return false
end

local function changeArea()
	local function organizeHunger()
		local upConer = { x = 5537, y = 4839, z = 15 } -- upLeftCorner
		local downConer = { x = 5560, y = 4863, z = 15 } -- downRightCorner
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theHungerKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5548, y = 4848, z = 15 })
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Hunger", { x = 5548, y = 4851, z = 15 }, false, true)
								theHungerKilled = false
							end
						end
					end
				end
			end
		end
	end

	local function organizeDestruction()
		local upConer = { x = 5564, y = 4783, z = 15 } -- upLeftCorner
		local downConer = { x = 5587, y = 4807, z = 15 } -- downRightCorner
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theDestructionKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5575, y = 4792, z = 15 })
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Destruction", { x = 5575, y = 4795, z = 15 }, false, true)
								theDestructionKilled = false
							end
						end
					end
				end
			end
		end
	end

	local function organizeRage()
		local upConer = { x = 5592, y = 4839, z = 15 } -- upLeftCorner
		local downConer = { x = 5615, y = 4863, z = 15 } -- downRightCorner
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theRageKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5603, y = 4848, z = 15 })
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Rage", { x = 5603, y = 4851, z = 15 }, false, true)
								theRageKilled = false
							end
						end
					end
				end
			end
		end
	end

	if devourerBossesKilled < 3 then
		for _, online in ipairs(Game.getPlayers()) do
			if online:isPlayer() then
				-- Teleport players from The Hunger to The Rage
				if online:getStorageValue(14334) >= 1 then
					online:setStorageValue(14334, -1)
					online:setStorageValue(14336, 1)
					online:teleportTo({ x = 5603, y = 4851, z = 15 })
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5603, y = 4851, z = 15 }):sendMagicEffect(11)
					-- Teleport players from The Destruction to The Hunger
				elseif online:getStorageValue(14335) >= 1 then
					online:setStorageValue(14335, -1)
					online:setStorageValue(14334, 1)
					online:teleportTo({ x = 5548, y = 4851, z = 15 })
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5548, y = 4851, z = 15 }):sendMagicEffect(11)
					-- Teleport players from The Rage to The Destruction
				elseif online:getStorageValue(14336) >= 1 then
					online:setStorageValue(14336, -1)
					online:setStorageValue(14335, 1)
					online:teleportTo({ x = 5575, y = 4795, z = 15 })
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5575, y = 4795, z = 15 }):sendMagicEffect(11)
				end
			end
		end
		organizeHunger()
		organizeDestruction()
		organizeRage()
		areaDevourer4 = addEvent(changeArea, 30000)
	else
		stopEvent(areaDevourer1)
		stopEvent(areaDevourer2)
		stopEvent(areaDevourer3)
		stopEvent(areaDevourer4)
		for _, online in ipairs(Game.getPlayers()) do
			if online:isPlayer() then
				if online:getStorageValue(14334) >= 1 then
					online:setStorageValue(14334, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5575, y = 4836, z = 15 })
					Position({ x = 5575, y = 4836, z = 15 }):sendMagicEffect(11)
				elseif online:getStorageValue(14335) >= 1 then
					online:setStorageValue(14335, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5576, y = 4836, z = 15 })
					Position({ x = 5576, y = 4836, z = 15 }):sendMagicEffect(11)
				elseif online:getStorageValue(14336) >= 1 then
					online:setStorageValue(14336, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5577, y = 4836, z = 15 })
					Position({ x = 5577, y = 4836, z = 15 }):sendMagicEffect(11)
				end
			end
		end
		local spectators = Game.getSpectators(Position(5575, 4827, 15), false, true, 10, 10, 10, 10)
		if #spectators > 0 then
			for i = 1, #spectators do
				spectators[i]:say("With the Rage, Hunger and Destruction gone, you're sucked into the heart of destruction!! THE WORLD DEVOURER AWAITS YOU!", TALKTYPE_MONSTER_YELL, false, spectators[i], Position(5575, 4827, 15))
			end
		end

		Game.createMonster("World Devourer", { x = 5575, y = 4826, z = 15 }, false, true)
		Game.createMonster("Spark of Destruction2", { x = 5572, y = 4820, z = 15 }, false, true)
		Game.createMonster("Spark of Destruction2", { x = 5579, y = 4821, z = 15 }, false, true)
		Game.createMonster("Spark of Destruction2", { x = 5573, y = 4831, z = 15 }, false, true)
		Game.createMonster("Spark of Destruction2", { x = 5581, y = 4830, z = 15 }, false, true)
		sparkSpawnCount = 0
		devourerSummon = 0
		areaDevourer5 = addEvent(clearDevourer, 30 * 60000)
		areaDevourer6 = addEvent(sparkDevourerSpawn, 10000)
	end
end

local function clearHunger()
	local upConer = { x = 5537, y = 4839, z = 15 } -- upLeftCorner
	local downConer = { x = 5560, y = 4863, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
							local creature = Creature(creatureUid)
							if creature then
								if creature:isPlayer() then
									creature:teleportTo({ x = 5480, y = 4769, z = 15 })
								elseif creature:isMonster() and creature:getName() ~= "Spark of Destruction" then
									creature:remove()
								end
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer1)
end

local function clearDestruction()
	local upConer = { x = 5564, y = 4783, z = 15 } -- upLeftCorner
	local downConer = { x = 5587, y = 4807, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
							local creature = Creature(creatureUid)
							if creature then
								if creature:isPlayer() then
									creature:teleportTo({ x = 5480, y = 4769, z = 15 })
								elseif creature:isMonster() and creature:getName() ~= "Spark of Destruction" then
									creature:remove()
								end
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer2)
end

local function clearRage()
	local upConer = { x = 5592, y = 4839, z = 15 } -- upLeftCorner
	local downConer = { x = 5615, y = 4863, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
							local creature = Creature(creatureUid)
							if creature then
								if creature:isPlayer() then
									creature:teleportTo({ x = 5480, y = 4769, z = 15 })
								elseif creature:isMonster() and creature:getName() ~= "Spark of Destruction" then
									creature:remove()
								end
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer3)
end

function clearDevourer()
	local upConer = { x = 5564, y = 4815, z = 15 } -- upLeftCorner
	local downConer = { x = 5587, y = 4839, z = 15 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
							local creature = Creature(creatureUid)
							if creature then
								if creature:isPlayer() then
									creature:teleportTo({ x = 5480, y = 4769, z = 15 })
								elseif creature:isMonster() then
									creature:remove()
								end
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer4)
	stopEvent(areaDevourer5)
	stopEvent(areaDevourer6)
end

-- FUNCTIONS END

local heartDestructionFinal = Action()
function heartDestructionFinal.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		hungerPositions = {
			Position(5575, 4853, 15),
			Position(5575, 4854, 15),
			Position(5575, 4855, 15),
			Position(5575, 4856, 15),
			Position(5575, 4857, 15),
		},

		destructionPositions = {
			Position(5576, 4853, 15),
			Position(5576, 4854, 15),
			Position(5576, 4855, 15),
			Position(5576, 4856, 15),
			Position(5576, 4857, 15),
		},

		ragePositions = {
			Position(5577, 4853, 15),
			Position(5577, 4854, 15),
			Position(5577, 4855, 15),
			Position(5577, 4856, 15),
			Position(5577, 4857, 15),
		},

		hungerNewPos = { x = 5547, y = 4684, z = 15 },
		destructionNewPos = { x = 5575, y = 4804, z = 15 },
		rageNewPos = { x = 5603, y = 4860, z = 15 },
	}

	local pushPos = { x = 5576, y = 4853, z = 15 }

	if item.actionid == 14332 then
		if item.itemid == 8911 then
			if player:getPosition().x == pushPos.x and player:getPosition().y == pushPos.y and player:getPosition().z == pushPos.z then
				local storeHunger, hungerTile = {}
				local storeDestruction, destructionTile = {}
				local storeRage, rageTile = {}

				for i = 1, #config.hungerPositions do
					hungerTile = Tile(config.hungerPositions[i]):getTopCreature()
					if hungerTile and hungerTile:isPlayer() then
						storeHunger[#storeHunger + 1] = hungerTile
					end
				end

				for i = 1, #config.destructionPositions do
					destructionTile = Tile(config.destructionPositions[i]):getTopCreature()
					if destructionTile and destructionTile:isPlayer() then
						storeDestruction[#storeDestruction + 1] = destructionTile
					end
				end

				for i = 1, #config.ragePositions do
					rageTile = Tile(config.ragePositions[i]):getTopCreature()
					if rageTile and rageTile:isPlayer() then
						storeRage[#storeRage + 1] = rageTile
					end
				end

				if #storeHunger < 1 or #storeDestruction < 1 or #storeRage < 1 then
					player:sendTextMessage(19, "You need at least 3 players, each in a column.")
					return true
				end

				if doCheckArea() == false then
					clearHunger()
					clearDestruction()
					clearRage()
					clearDevourer()

					local teamHunger
					local teamDestruction
					local teamRage

					for i = 1, #storeHunger do
						teamHunger = storeHunger[i]
						config.hungerPositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamHunger:teleportTo(config.hungerNewPos)
						teamHunger:setBossCooldown("World Devourer", os.time() + 7 * 24 * 60 * 60)
						teamHunger:setStorageValue(Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer, os.time() + 7 * 24 * 60 * 60)
						teamHunger:setStorageValue(14334, 1) --storage Hunger
						teamHunger:registerEvent("DevourerStorage")
					end

					for i = 1, #storeDestruction do
						teamDestruction = storeDestruction[i]
						config.destructionPositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamDestruction:teleportTo(config.destructionNewPos)
						teamDestruction:setBossCooldown("World Devourer", os.time() + 7 * 24 * 60 * 60)
						teamDestruction:setStorageValue(Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer, os.time() + 7 * 24 * 60 * 60)
						teamDestruction:setStorageValue(14335, 1) --storage Destruction
						teamDestruction:registerEvent("DevourerStorage")
					end

					for i = 1, #storeRage do
						teamRage = storeRage[i]
						config.ragePositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamRage:teleportTo(config.rageNewPos)
						teamRage:setBossCooldown("World Devourer", os.time() + 7 * 24 * 60 * 60)
						teamRage:setStorageValue(Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer, os.time() + 7 * 24 * 60 * 60)
						teamRage:setStorageValue(14336, 1) --storage Rage
						teamRage:registerEvent("DevourerStorage")
					end

					Position(config.hungerNewPos):sendMagicEffect(11)
					Position(config.destructionNewPos):sendMagicEffect(11)
					Position(config.rageNewPos):sendMagicEffect(11)

					areaDevourer1 = addEvent(clearHunger, 30 * 60000)
					areaDevourer2 = addEvent(clearDestruction, 30 * 60000)
					areaDevourer3 = addEvent(clearRage, 30 * 60000)
					areaDevourer4 = addEvent(changeArea, 30000) --mudar

					--Variables
					devourerBossesKilled = 0
					theHungerKilled = false
					theDestructionKilled = false
					theRageKilled = false

					hungerSummon = 0
					rageSummon = 0
					destructionSummon = 0
					devourerSummon = 0

					Game.createMonster("The Hunger", { x = 5548, y = 4851, z = 15 }, false, true)
					Game.createMonster("The Destruction", { x = 5575, y = 4795, z = 15 }, false, true)
					Game.createMonster("The Rage", { x = 5603, y = 4851, z = 15 }, false, true)

					local vortex = Tile({ x = 5585, y = 4827, z = 15 })
					local vortexId = vortex:getItemById(23482)
					if vortex and vortexId then
						vortexId:transform(23483)
						vortexId:setActionId(14352)
					end
				else
					player:sendTextMessage(19, "Someone is in the area.")
				end
			else
				return true
			end
		end
		item:transform(item.itemid == 8911 and 8912 or 8911)
	end
	return true
end

heartDestructionFinal:aid(14332)
heartDestructionFinal:register() 
