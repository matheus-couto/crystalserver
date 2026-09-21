-- CRANDORIA EDIT --

local config = {
	[1] = {
		teleportPosition = { x = 5191, y = 4554, z = 13 },
		bossName = "Yirkas Blue Scales",
		requiredLevel = 250,
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(5225, 4560, 13),
		bossPosition = Position(5225, 4572, 13),
		specPos = {
			from = Position(5220, 4558, 13),
			to = Position(5232, 4576, 13),
		},
		exitPosition = Position(5191, 4557, 13),
	},
	[2] = {
		teleportPosition = { x = 5199, y = 4567, z = 13 },
		bossName = "Srezz Yellow Eyes",
		requiredLevel = 250,
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(5189, 4593, 13),
		bossPosition = Position(5189, 4602, 13),
		specPos = {
			from = Position(5184, 4590, 13),
			to = Position(5195, 4606, 13),
		},
		exitPosition = Position(5197, 4567, 13),
	},
	[3] = {
		teleportPosition = { x = 5191, y = 4580, z = 13 },
		bossName = "Utua Stone Sting",
		requiredLevel = 250,
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(5155, 4556, 13),
		bossPosition = Position(5155, 4565, 13),
		specPos = {
			from = Position(5152, 4553, 13),
			to = Position(5159, 4568, 13),
		},
		exitPosition = Position(5191, 4578, 13),
	},
	[4] = {
		teleportPosition = { x = 5182, y = 4567, z = 13 },
		bossName = "Katex Blood Tongue",
		requiredLevel = 250,
		timeToFightAgain = 20, -- In hour
		timeToDefeat = 10, -- In minutes
		destination = Position(5218, 4598, 13),
		bossPosition = Position(5222, 4606, 13),
		specPos = {
			from = Position(5214, 4595, 13),
			to = Position(5227, 4609, 13),
		},
		exitPosition = Position(5184, 4567, 13),
	},
	[5] = { -- saida
		teleportPosition = { x = 5222, y = 4560, z = 13 },
		exitPosition = Position(5191, 4557, 13),
	},
	[6] = { -- saida
		teleportPosition = { x = 5187, y = 4593, z = 13 },
		exitPosition = Position(5197, 4567, 13),
	},
	[7] = { -- saida
		teleportPosition = { x = 5155, y = 4554, z = 13 },
		exitPosition = Position(5191, 4578, 13),
	},
	[8] = { -- saida
		teleportPosition = { x = 5216, y = 4598, z = 13 },
		exitPosition = Position(5184, 4567, 13),
	},
}

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

			if creature:getLevel() < value.requiredLevel then
				creature:teleportTo(fromPosition, true)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Necessario nivel " .. value.requiredLevel .. " ou superior.")
				return true
			end

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

teleportBoss:aid(30000)
teleportBoss:register()


-- local config = {
-- 	[1] = {
-- 		teleportPosition = { x = 33123, y = 32239, z = 12 },
-- 		bossName = "Yirkas Blue Scales",
-- 		requiredLevel = 250,
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33154, 32246, 12),
-- 		bossPosition = Position(33154, 32252, 12),
-- 		specPos = {
-- 			from = Position(33150, 32242, 12),
-- 			to = Position(33164, 32260, 12),
-- 		},
-- 		exitPosition = Position(33123, 32240, 12),
-- 	},
-- 	[2] = {
-- 		teleportPosition = { x = 33131, y = 32252, z = 12 },
-- 		bossName = "Srezz Yellow Eyes",
-- 		requiredLevel = 250,
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33120, 32278, 12),
-- 		bossPosition = Position(33122, 32285, 12),
-- 		specPos = {
-- 			from = Position(33115, 32275, 12),
-- 			to = Position(33127, 32290, 12),
-- 		},
-- 		exitPosition = Position(33130, 32252, 12),
-- 	},
-- 	[3] = {
-- 		teleportPosition = { x = 33123, y = 32265, z = 12 },
-- 		bossName = "Utua Stone Sting",
-- 		requiredLevel = 250,
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33087, 32240, 12),
-- 		bossPosition = Position(33087, 32245, 12),
-- 		specPos = {
-- 			from = Position(33082, 32237, 12),
-- 			to = Position(33091, 32252, 12),
-- 		},
-- 		exitPosition = Position(33123, 32264, 12),
-- 	},
-- 	[4] = {
-- 		teleportPosition = { x = 33114, y = 32252, z = 12 },
-- 		bossName = "Katex Blood Tongue",
-- 		requiredLevel = 250,
-- 		timeToFightAgain = 10, -- In hour
-- 		timeToDefeat = 10, -- In minutes
-- 		destination = Position(33149, 32283, 12),
-- 		bossPosition = Position(33152, 32289, 12),
-- 		specPos = {
-- 			from = Position(33145, 32279, 12),
-- 			to = Position(33159, 32293, 12),
-- 		},
-- 		exitPosition = Position(33115, 32252, 12),
-- 	},
-- 	[5] = {
-- 		teleportPosition = { x = 33154, y = 32245, z = 12 },
-- 		exitPosition = Position(33123, 32240, 12),
-- 	},
-- 	[6] = {
-- 		teleportPosition = { x = 33119, y = 32278, z = 12 },
-- 		exitPosition = Position(33130, 32252, 12),
-- 	},
-- 	[7] = {
-- 		teleportPosition = { x = 33087, y = 32239, z = 12 },
-- 		exitPosition = Position(33123, 32264, 12),
-- 	},
-- 	[8] = {
-- 		teleportPosition = { x = 33148, y = 32283, z = 12 },
-- 		exitPosition = Position(33115, 32252, 12),
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
-- 			if creature:getLevel() < value.requiredLevel then
-- 				creature:teleportTo(fromPosition, true)
-- 				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- 				creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "All the players need to be level " .. value.requiredLevel .. " or higher.")
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
