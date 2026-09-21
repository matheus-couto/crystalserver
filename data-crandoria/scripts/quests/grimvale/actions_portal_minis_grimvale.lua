-- CRANDORIA EDIT --

local config = {
	[1] = {
		teleportPosition = { x = 33167, y = 31977, z = 8 },
		bossName = "Bloodback",
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(4747, 4635, 9),
		bossPosition = Position(4746, 4642, 9),
		specPos = {
			from = Position(4737, 4630, 9),
			to = Position(4757, 4647, 9),
		},
		exitPosition = Position(4707, 4641, 8),
	},
	[2] = {
		teleportPosition = { x = 4724, y = 4614, z = 8 },
		bossName = "Darkfang",
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(4753, 4691, 8),
		bossPosition = Position(4761, 4695, 8),
		specPos = {
			from = Position(4744, 4683, 8),
			to = Position(4767, 4701, 8),
		},
		exitPosition = Position(4724, 4616, 8),
	},
	[3] = {
		teleportPosition = { x = 4785, y = 4645, z = 9 },
		bossName = "Sharpclaw",
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(4747, 4635, 9),
		bossPosition = Position(4746, 4642, 9),
		specPos = {
			from = Position(4736, 4630, 9),
			to = Position(4756, 4646, 9),
		},
		exitPosition = Position(4783, 4645, 9),
	},
	[4] = {
		teleportPosition = { x = 5016, y = 4515, z = 12 },
		bossName = "Shadowpelt",
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(4992, 4454, 12),
		bossPosition = Position(4977, 4455, 12),
		specPos = {
			from = Position(4971, 4447, 12),
			to = Position(4996, 4461, 12),
		},
		exitPosition = Position(5018, 4515, 12),
	},
	[5] = {
		teleportPosition = { x = 5056, y = 4469, z = 12 },
		bossName = "Black Vixen",
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(5046, 4426, 12),
		bossPosition = Position(5048, 4416, 12),
		specPos = {
			from = Position(5039, 4410, 12),
			to = Position(5057, 4430, 12),
		},
		exitPosition = Position(5056, 4471, 12),
	},
	[6] = {
		teleportPosition = { x = 4747, y = 4633, z = 9 },
		exitPosition = Position(4707, 4641, 8),
	},
	[7] = {
		teleportPosition = { x = 4751, y = 4691, z = 8 },
		exitPosition = Position(4724, 4616, 8),
	},
	[8] = {
		teleportPosition = { x = 4718, y = 4687, z = 8 },
		exitPosition = Position(4783, 4645, 9),
	},
	[9] = {
		teleportPosition = { x = 4992, y = 4452, z = 12 },
		exitPosition = Position(5018, 4515, 12),
	},
	[10] = {
		teleportPosition = { x = 5044, y = 4426, z = 12 },
		exitPosition = Position(5056, 4471, 12),
	},
}

local teleportBoss = MoveEvent()
local teleportBoss = MoveEvent()
function teleportBoss.onStepIn(creature, item, position, fromPosition)
	if not creature or not creature:isPlayer() then
		return false
	end

	for _, value in pairs(config) do
		if value.teleportPosition and
			position.x == value.teleportPosition.x and
			position.y == value.teleportPosition.y and
			position.z == value.teleportPosition.z then

			if not value.specPos then
				creature:teleportTo(value.exitPosition)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end

			local spec = Spectators()
			spec:setOnlyPlayer(false)
			spec:setRemoveDestination(value.exitPosition)
			spec:setCheckPosition(value.specPos)
			spec:check()

			if spec:getPlayers() > 0 then
				creature:teleportTo(fromPosition, true)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				creature:say("Ha alguem lutando contra " .. value.bossName .. ".", TALKTYPE_MONSTER_SAY)
				return true
			end

			if creature:getStorageValue(Storage.Quest.U10_80.Grimvale.MissaoWagner) < 4 then
				creature:teleportTo(fromPosition, true)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Alguma magia estranha te impede de entrar no portal.")
				return true
			end

			-- if creature:getLevel() < value.requiredLevel then
			-- 	creature:teleportTo(fromPosition, true)
			-- 	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			-- 	creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Necessario nivel " .. value.requiredLevel .. " ou superior.")
			-- 	return true
			-- end

			if not creature:canFightBoss(value.bossName) then
				creature:teleportTo(fromPosition, true)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve esperar por " .. value.timeToFightAgain .. " horas para enfrentar " .. value.bossName .. " novamente!")
				return true
			end

			spec:removeMonsters()
			local monster = Game.createMonster(value.bossName, value.bossPosition, true, true)
			if not monster then
				return true
			end

			creature:teleportTo(value.destination)
			creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			creature:setBossCooldown(value.bossName, os.time() + value.timeToFightAgain * 3600)

			addEvent(function()
				spec:clearCreaturesCache()
				spec:setOnlyPlayer(true)
				spec:check()
				spec:removePlayers()
			end, value.timeToDefeat * 60 * 1000)

			return true
		end
	end

	return true
end

teleportBoss:aid(13148)
teleportBoss:register()


-- local config = {
-- 	[1] = {
-- 		teleportPosition = { x = 33167, y = 31977, z = 8 },
-- 		bossName = "Bloodback",
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33182, 32012, 8),
-- 		bossPosition = Position(33184, 32016, 8),
-- 		specPos = {
-- 			from = Position(33174, 32007, 8),
-- 			to = Position(33191, 32020, 8),
-- 		},
-- 		exitPosition = Position(33167, 31978, 8),
-- 	},
-- 	[2] = {
-- 		teleportPosition = { x = 33055, y = 31910, z = 9 },
-- 		bossName = "Darkfang",
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33055, 31889, 9),
-- 		bossPosition = Position(33062, 31890, 9),
-- 		specPos = {
-- 			from = Position(33050, 31883, 9),
-- 			to = Position(33066, 31896, 9),
-- 		},
-- 		exitPosition = Position(33055, 31911, 9),
-- 	},
-- 	[3] = {
-- 		teleportPosition = { x = 33128, y = 31971, z = 9 },
-- 		bossName = "Sharpclaw",
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33121, 31998, 9),
-- 		bossPosition = Position(33120, 32002, 9),
-- 		specPos = {
-- 			from = Position(33113, 31994, 9),
-- 			to = Position(33126, 32007, 9),
-- 		},
-- 		exitPosition = Position(33128, 31972, 9),
-- 	},
-- 	[4] = {
-- 		teleportPosition = { x = 33402, y = 32097, z = 9 },
-- 		bossName = "Shadowpelt",
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33395, 32112, 9),
-- 		bossPosition = Position(33384, 32114, 9),
-- 		specPos = {
-- 			from = Position(33376, 32107, 9),
-- 			to = Position(33396, 32119, 9),
-- 		},
-- 		exitPosition = Position(33403, 32097, 9),
-- 	},
-- 	[5] = {
-- 		teleportPosition = { x = 33442, y = 32051, z = 9 },
-- 		bossName = "Black Vixen",
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33448, 32038, 9),
-- 		bossPosition = Position(33450, 32034, 9),
-- 		specPos = {
-- 			from = Position(33442, 32027, 9),
-- 			to = Position(33456, 32041, 9),
-- 		},
-- 		exitPosition = Position(33442, 32052, 9),
-- 	},
-- 	[6] = {
-- 		teleportPosition = { x = 33180, y = 32011, z = 8 },
-- 		exitPosition = Position(33167, 31978, 8),
-- 	},
-- 	[7] = {
-- 		teleportPosition = { x = 33055, y = 31888, z = 9 },
-- 		exitPosition = Position(33055, 31911, 9),
-- 	},
-- 	[8] = {
-- 		teleportPosition = { x = 33120, y = 31996, z = 9 },
-- 		exitPosition = Position(33128, 31972, 9),
-- 	},
-- 	[9] = {
-- 		teleportPosition = { x = 33395, y = 32111, z = 9 },
-- 		exitPosition = Position(33403, 32097, 9),
-- 	},
-- 	[10] = {
-- 		teleportPosition = { x = 33446, y = 32040, z = 9 },
-- 		exitPosition = Position(33442, 32052, 9),
-- 	},
-- }

-- local teleportBoss = MoveEvent()
-- function teleportBoss.onStepIn(creature, item, position, fromPosition)
-- 	if not creature or not creature:isPlayer() then
-- 		return false
-- 	end
-- 	for index, value in pairs(config) do
-- 		if Tile(position) == Tile(value.teleportPosition) then
-- 			if not value.specPos then
-- 				creature:teleportTo(value.exitPosition)
-- 				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 				return true
-- 			end
-- 			local spec = Spectators()
-- 			spec:setOnlyPlayer(false)
-- 			spec:setRemoveDestination(value.exitPosition)
-- 			spec:setCheckPosition(value.specPos)
-- 			spec:check()
-- 			if spec:getPlayers() > 0 then
-- 				creature:teleportTo(fromPosition, true)
-- 				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 				creature:say("There's someone fighting with " .. value.bossName .. ".", TALKTYPE_MONSTER_SAY)
-- 				return true
-- 			end
-- 			if not creature:canFightBoss(value.bossName) then
-- 				creature:teleportTo(fromPosition, true)
-- 				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait " .. value.timeToFightAgain .. " hours to face " .. value.bossName .. " again!")
-- 				return true
-- 			end
-- 			spec:removeMonsters()
-- 			local monster = Game.createMonster(value.bossName, value.bossPosition, true, true)
-- 			if not monster then
-- 				return true
-- 			end
-- 			creature:teleportTo(value.destination)
-- 			creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 			creature:setBossCooldown(value.bossName, os.time() + value.timeToFightAgain * 3600)
-- 			creature:sendBosstiaryCooldownTimer()
-- 			addEvent(function()
-- 				spec:clearCreaturesCache()
-- 				spec:setOnlyPlayer(true)
-- 				spec:check()
-- 				spec:removePlayers()
-- 			end, value.timeToDefeat * 60 * 1000)
-- 		end
-- 	end
-- end

-- for index, value in pairs(config) do
-- 	teleportBoss:position(value.teleportPosition)
-- end

-- teleportBoss:type("stepin")
-- teleportBoss:register()
