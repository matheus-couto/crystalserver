local teleportConfig = {
		creatureNames = {"Amazon", "Demon Outcast", "Demon", "Valkyrie", "Bonelord", "Tarantula", "Deepling Guard", "Deepling Tyrant", "Deepling Spellsinger", "Dragon", "Dragon Hatchling", "Waspoind", "Spitter", "Spidris", "Crawler", "Deepling Warrior", "Wyrm", "Elder Wyrm", "Dawnfire Asura", "Midnight Asura", "Hellspawn", "Destroyer", "Draken Warmaster", "Draken Spellweaver", "Lizard Chosen", "Lizard Zaogun", "Frazzlemaw", "Guzzlemaw", "Silencer", "Hellhound", "Choking Fear", "Retching Horror", "True Frost Flower Asura", "True Midnight Asura", "Bashmu", "Juvenile Bashmu", "Dark Carnisylvan", "Vexclaw", "Grimeleech", "Brain Squid", "Rage Squid", "Squid Warden", "Energetic Book", "Cursed Book", "Infernal Phantom", "Kraon", "Frosthorn", "Bony Sea Devil"}
	}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local areas = {
    {fromPosition = Position(4160, 5123, 6), toPosition = Position(4177, 5139, 6)},
    {fromPosition = Position(4160, 5105, 6), toPosition = Position(4177, 5122, 6)},
    {fromPosition = Position(4160, 5087, 5), toPosition = Position(4177, 5103, 5)},
    {fromPosition = Position(4160, 5070, 5), toPosition = Position(4177, 5086, 5)},
    {fromPosition = Position(4160, 5051, 4), toPosition = Position(4177, 5067, 4)},
    {fromPosition = Position(4160, 5034, 4), toPosition = Position(4177, 5050, 4)},
    {fromPosition = Position(4160, 5017, 3), toPosition = Position(4177, 5033, 3)},
    {fromPosition = Position(4160, 5000, 3), toPosition = Position(4177, 5016, 3)},
    {fromPosition = Position(4160, 4983, 2), toPosition = Position(4177, 4999, 2)},
    {fromPosition = Position(4160, 4966, 2), toPosition = Position(4177, 4982, 2)},
    {fromPosition = Position(4160, 4948, 1), toPosition = Position(4177, 4964, 1)},
    {fromPosition = Position(4160, 4931, 1), toPosition = Position(4177, 4947, 1)}
}

local function getPlayersInArea(area)
    local players = {}
    for x = area.fromPosition.x, area.toPosition.x do
        for y = area.fromPosition.y, area.toPosition.y do
            local pos = Position(x, y, area.fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    table.insert(players, creature)
                end
            end
        end
    end
    return players
end

local function checkAndTeleportPlayers()
    for _, area in ipairs(areas) do
        local playersInArea = getPlayersInArea(area)
        for _, player in ipairs(playersInArea) do
            local timerStorage = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.DefaultTimer)
            if timerStorage < os.time() then
                player:teleportTo(Position(4160, 5138, 6))
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
            end 
        end 
    end
end

local climbTeleport = MoveEvent()

local accessedIPs = {}

function climbTeleport.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)

	local playerIP = player:getIp()

	local timerStorage1 = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer)
	local timerStorage2 = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.DefaultTimer)
	local storageStart = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.Start)


	if item:getPosition() == Position(4168, 5144, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.TheClimb.Start) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.DefaultTimer, os.time() + 20 * 60)
		else
			return true
		end
		return true
	elseif item:getPosition() == Position(4168, 5140, 6) then
		if timerStorage1 > os.time() and timerStorage2 > os.time() then
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
			player:teleportTo(Position(4168, 5137, 6))
		else
			player:teleportTo(Position(4167, 5151, 7))
		end
		checkAndTeleportPlayers()
		return true
	elseif item:getPosition() == Position(4168, 5123, 6) then
		if hasCreatureInArea(Position(4160, 5123, 6), Position(4177, 5139, 6), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5121, 6))
			else
				player:teleportTo(Position(4167, 5151, 7))
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5106, 6) then
		if hasCreatureInArea(Position(4160, 5106, 6), Position(4177, 5122, 6), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 1)
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5102, 5))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5087, 5) then
		if hasCreatureInArea(Position(4160, 5087, 5), Position(4177, 5103, 5), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5085, 5))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5070, 5) then
		if hasCreatureInArea(Position(4160, 5070, 5), Position(4177, 5086, 5), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 2)
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5066, 4))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5051, 4) then
		if hasCreatureInArea(Position(4160, 5051, 4), Position(4177, 5067, 4), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5049, 4))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5034, 4) then
		if hasCreatureInArea(Position(4160, 5034, 4), Position(4177, 5050, 4), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 3)
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5031, 3))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5017, 3) then
		if hasCreatureInArea(Position(4160, 5017, 3), Position(4177, 5033, 3), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 5015, 3))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 5000, 3) then
		if hasCreatureInArea(Position(4160, 5000, 3), Position(4177, 5016, 3), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 4)
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 4998, 2))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 4983, 2) then
		if hasCreatureInArea(Position(4160, 4983, 2), Position(4177, 4999, 2), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 4981, 2))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 4966, 2) then
		if hasCreatureInArea(Position(4160, 4966, 2), Position(4177, 4982, 2), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 5)
				player:teleportTo(Position(4168, 4963, 1))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 4948, 1) then
		if hasCreatureInArea(Position(4160, 4948, 1), Position(4177, 4964, 1), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4168, 4946, 1))
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4168, 4931, 1) then
		if hasCreatureInArea(Position(4160, 4931, 1), Position(4177, 4947, 1), teleportConfig.creatureNames) then
			player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			if timerStorage1 > os.time() and timerStorage2 > os.time() then
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
				player:teleportTo(Position(4169, 4929, 1))
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 6)
			else
				player:teleportTo(Position(4870, 5113, 7))
				if player:addItem(22720, storageStart) then
					player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				end
			end
		end
		return true
	elseif item:getPosition() == Position(4859, 5114, 7) then
		if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce so pode realizar este desafio com um personagem por dia.")
			player:teleportTo(Position(4905, 5079, 7))
			return true
		else
			if player:getStorageValue(Storage.Quest.Crandoria.TheClimb.MainTimer) < os.time() then
				player:teleportTo(Position(4184, 5153, 7))
				player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				accessedIPs[playerIP] = player:getGuid()
				return true
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce so pode realizar este desafio uma vez ao dia.")
				player:teleportTo(fromPosition)
				return true
			end
		end
	else
		player:teleportTo(Position(4870, 5113, 7))
		if player:addItem(22720, storageStart) then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu " ..storageStart.. " arena token(s).")
			player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
		end
	end
end

climbTeleport:aid(13033)
climbTeleport:register()






-- local area1 = {
--     fromPosition = {x = 4160, y = 5123, z = 6},
--     toPosition = {x = 4177, y = 5139, z = 6}
-- }

-- local area2 = {
--     fromPosition = {x = 4160, y = 5105, z = 6},
--     toPosition = {x = 4177, y = 5122, z = 6}
-- }

-- local area3 = {
--     fromPosition = {x = 4160, y = 5087, z = 5},
--     toPosition = {x = 4177, y = 5103, z = 5}
-- }

-- local area4 = {
--     fromPosition = {x = 4160, y = 5070, z = 5},
--     toPosition = {x = 4177, y = 5086, z = 5}
-- }

-- local area5 = {
--     fromPosition = {x = 4160, y = 5051, z = 4},
--     toPosition = {x = 4177, y = 5067, z = 4}
-- }

-- local area6 = {
--     fromPosition = {x = 4160, y = 5034, z = 4},
--     toPosition = {x = 4177, y = 5050, z = 4}
-- }

-- local area7 = {
--     fromPosition = {x = 4160, y = 5017, z = 3},
--     toPosition = {x = 4177, y = 5033, z = 3}
-- }

-- local area8 = {
--     fromPosition = {x = 4160, y = 5000, z = 3},
--     toPosition = {x = 4177, y = 5016, z = 3}
-- }

-- local area9 = {
--     fromPosition = {x = 4160, y = 4983, z = 2},
--     toPosition = {x = 4177, y = 4999, z = 2}
-- }

-- local area10 = {
--     fromPosition = {x = 4160, y = 4966, z = 2},
--     toPosition = {x = 4177, y = 4982, z = 2}
-- }

-- local area11 = {
--     fromPosition = {x = 4160, y = 4948, z = 1},
--     toPosition = {x = 4177, y = 4964, z = 1}
-- }

-- local area12 = {
--     fromPosition = {x = 4160, y = 4931, z = 1},
--     toPosition = {x = 4177, y = 4947, z = 1}
-- }

-- local function isInArea(player, area)
--     local playerPos = player:getPosition()
--     return playerPos.x >= area.fromPosition.x and playerPos.x <= area.toPosition.x
--         and playerPos.y >= area.fromPosition.y and playerPos.y <= area.toPosition.y
--         and playerPos.z == area.fromPosition.z
-- end

-- local teleportConfig = {
--     creatureNames = {"Amazon", "Demon", "Valkyrie", "Bonelord", "Tarantula", "Deepling Guard", "Deepling Tyrant", "Deepling Spellsinger", "Dragon", "Dragon Hatchling", "Waspoind", "Spitter", "Spidris", "Crawler", "Deepling Warrior", "Wyrm", "Elder Wyrm", "Dawnfire Asura", "Midnight Asura", "Hellspawn", "Destroyer", "Draken Warmaster", "Draken Spellweaver", "Lizard Chosen", "Lizard Zaogun", "Frazzlemaw", "Guzzlemaw", "Silencer", "Hellhound", "Choking Fear", "Retching Horror", "True Frost Flower Asura", "True Midnight Asura", "Bashmu", "Juvenile Bashmu", "Dark Carnisylvan", "Vexclaw", "Grimeleech", "Brain Squid", "Rage Squid", "Squid Warden", "Energetic Book", "Cursed Book", "Infernal Phantom", "Kraon", "Frosthorn", "Bony Sea Devil"}
-- }

-- local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
--     for x = fromPosition.x, toPosition.x do
--         for y = fromPosition.y, toPosition.y do
--             local pos = Position(x, y, fromPosition.z)
--             local tile = Tile(pos)
--             if tile then
--                 local creature = tile:getTopCreature()
--                 if creature and table.contains(creatureNames, creature:getName()) then
--                     return true
--                 end
--             end
--         end
--     end
--     return false
-- end

-- local function teleportPlayer(player, position, startValue, tokens)
--     player:teleportTo(position)
--     if startValue then
--         player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, startValue)
--     end
--     if tokens then
--         player:addItem(22720, tokens)
--         player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu " .. tokens .. " arena token(s).")
--     end
--     player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
-- end

-- local function handleTeleport(player, item, fromPosition, toPosition, areaFrom, areaTo, targetPosition, startValue, tokens)
--     local timerStorage1 = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer)
--     local timerStorage2 = player:getStorageValue(Storage.Quest.Crandoria.TheClimb.DefaultTimer)

--     if hasCreatureInArea(areaFrom, areaTo, teleportConfig.creatureNames) then
--         player:sendCancelMessage("Derrote todos os monstros da sala antes de passar pelo teleport.")
--         player:teleportTo(fromPosition)
--         player:getPosition():sendMagicEffect(CONST_ME_POFF)
--     else
--         if timerStorage1 > os.time() and timerStorage2 > os.time() then
--             player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
--             teleportPlayer(player, targetPosition, startValue)
--         else
--             teleportPlayer(player, Position(4870, 5113, 7), 0, tokens)
--         end
--     end
-- end

-- local climbTeleport = MoveEvent()

-- function climbTeleport.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
--     local positions = {
--         { pos = Position(4168, 5144, 6), action = function()
--             if player:getStorageValue(Storage.Quest.Crandoria.TheClimb.Start) ~= 0 then
--                 player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
--                 player:setStorageValue(Storage.Quest.Crandoria.TheClimb.TeleportTimer, os.time() + 3 * 60)
--                 player:setStorageValue(Storage.Quest.Crandoria.TheClimb.DefaultTimer, os.time() + 15 * 60)
--             end
--             return true
--         end },
--         { pos = Position(4168, 5140, 6), action = function()
--             handleTeleport(player, item, fromPosition, toPosition, Position(4160, 5123, 6), Position(4177, 5139, 6), Position(4168, 5137, 6), 0, nil)
--             return true
--         end },
--         -- Adicione outras posições e ações aqui seguindo o padrão
--         { pos = Position(4902, 5079, 7), action = function()
--             teleportPlayer(player, Position(4167, 5158, 7), 0, nil)
--             return true
--         end }
--     }

--     for _, entry in ipairs(positions) do
--         if item:getPosition() == entry.pos then
--             return entry.action()
--         end
--     end

--     teleportPlayer(player, Position(4870, 5113, 7), 0, player:getStorageValue(Storage.Quest.Crandoria.TheClimb.Start))
--     return true
-- end

-- climbTeleport:aid(13033)
-- climbTeleport:register()
