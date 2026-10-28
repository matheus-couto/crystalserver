local teleportConfig = {
		creatureNames = { "The Gravedigger", "Ice Horror", "Fatal Bug", "Fiona Firstdream", "Grendel Greenlunch", "Nigel Neverguess", "Percy Peacetinker", "Yorik Youngbook", "Eldritch Dragon Lord"}
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

local teleportsRoostOfGraveborn = MoveEvent()

function teleportsRoostOfGraveborn.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Progresso)
	local storageForsaken = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Forsaken)
	local storageUnhallowed = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.Unhallowed)

	if item:getPosition() == Position(4484, 5060, 8) then -- adventurer group lever
		if storage < 2 then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			player:teleportTo(Position(4456, 4934, 9))
			return true
		end
	elseif item:getPosition() == Position(32753, 32307, 12) then -- eldritch dragon lord lever
		if storage < 4 then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			player:teleportTo(Position(4520, 5006, 9))
			return true
		end
	elseif item:getPosition() == Position(5031, 5627, 7) then -- ice horror lever
		if storage < 6 then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			player:teleportTo(Position(4555, 4938, 9))
			return true
		end
	elseif item:getPosition() == Position(5481, 4607, 12) then -- gravedigger
		if storage < 8 then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			player:teleportTo(Position(4499, 4938, 9))
			return true
		end
	elseif item:getPosition() == Position(4455, 4967, 9) then
		if hasCreatureInArea(Position(4448, 4952, 9), Position(4465, 4967, 9), teleportConfig.creatureNames) then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote todos os bosses, incluindo o Fatal Bug.")
			return true
		else
			player:teleportTo(Position(4429, 4950, 9))
			return true
		end
	elseif item:getPosition() == Position(4483, 5011, 9) then
		if hasCreatureInArea(Position(4478, 4994, 9), Position(4497, 5011, 9), teleportConfig.creatureNames) then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote o Eldritch Dragon Lord para passar pelo teleport.")
			return true
		else
			player:teleportTo(Position(4454, 5003, 9))
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Use a Jade Dragon Head no item.")
			return true
		end	
	elseif item:getPosition() == Position(4556, 4874, 9) then
		if hasCreatureInArea(Position(4544, 4872, 9), Position(4566, 4917, 9), teleportConfig.creatureNames) then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote o Ice Horror para passar pelo teleport.")
			return true
		else
			player:teleportTo(Position(4558, 4850, 9))
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Use a Jade Dragon Head no item.")
			return true
		end	
	elseif item:getPosition() == Position(4503, 4977, 9) then
		if hasCreatureInArea(Position(4488, 4957, 9), Position(4506, 4977, 9), teleportConfig.creatureNames) then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote The Gravedigger para passar pelo teleport.")
			return true
		else
			player:teleportTo(Position(4533, 4962, 9))
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Use a Jade Dragon Head no item.")
			return true
		end	
	elseif item:getPosition() == Position(4433, 4889, 9) then
		if storage < 10 then
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			player:teleportTo(Position(4727, 4875, 14))
			return true
		end
	elseif item:getPosition() == Position(4727, 4870, 14) then
		if storage < 11 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			if storageForsaken < 1 then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Use Fetid Hearts para receber cargas e acessar a Forsaken Crypt.")
				return true
			else
				player:teleportTo(Position(4720, 4908, 14))
				return true
			end
		end
	elseif item:getPosition() == Position(4433, 4895, 9) then
		if storage < 11 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		else
			if storageUnhallowed < 1 then
				player:teleportTo(fromPosition)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Use Cryptic Fossils para receber cargas e acessar a Unhallowed Crypt.")
				return true
			else
				player:teleportTo(Position(4720, 4908, 14))
				return true
			end
		end
	elseif item:getPosition() == Position(4720, 4904, 14) then
		player:teleportTo(Position(4727, 4872, 14))
		return true
	end

	return true

end

teleportsRoostOfGraveborn:aid(13222)
teleportsRoostOfGraveborn:register()