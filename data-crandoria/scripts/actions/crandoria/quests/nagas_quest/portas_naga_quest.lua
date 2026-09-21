local teleportConfig = {
    creatureNames = {"Naga Guard", "Naga Sentinel"}
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

local portasNagas = Action()

function portasNagas.onUse(player, item, fromPosition, target, toPosition)

	if item.itemid == 5735 then
		if player:getPosition().x == 5926 then
			if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 3 then
				player:teleportTo(Position(5928, 4363, 6))
				return false
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
				return false
			end
		elseif player:getPosition().x == 5928 then
			player:teleportTo(Position(5926, 4363, 6))
			return false
		end
	elseif item.itemid == 8615 then
		if player:getPosition().y == 4359 or player:getPosition().y == 4360 then
			if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 8 then
				player:teleportTo(Position(5918, 4357, 6))
				return false
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
				return false
			end
		elseif player:getPosition().y == 4357 then
			if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 8 then
				player:teleportTo(Position(5918, 4359, 6))
				return false
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
				return false
			end
		end
	elseif item:getPosition() == Position(5910, 4317, 6) or item:getPosition() == Position(5843, 4332, 6) or item:getPosition() == Position(5843, 4332, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 10 then
			if item.itemid == 39351 then
				player:teleportTo(toPosition, true)
				item:transform(39353)
			elseif item.itemid == 39353 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 39353 then
					item:transform(39351)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return false
		end
	elseif item:getPosition() == Position(5909, 4358, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 11 then
			if item.itemid == 39352 then
				player:teleportTo(toPosition, true)
				item:transform(39354)
			elseif item.itemid == 39354 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 39353 then
					item:transform(39352)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return false
		end
	elseif item:getPosition() == Position(5846, 4385, 6) or item:getPosition() == Position(5846, 4384, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 14 then
			if item.itemid == 39352 then
				player:teleportTo(toPosition, true)
				item:transform(39354)
			elseif item.itemid == 39354 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 39353 then
					item:transform(39352)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Fale com Visanis.")
			return false
		end
	elseif item:getPosition() == Position(5827, 4397, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 22 then
			if item.itemid == 39351 then
				player:teleportTo(toPosition, true)
				item:transform(39353)
			elseif item.itemid == 39353 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 39353 then
					item:transform(39351)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return false
		end
	elseif item:getPosition() == Position(5830, 4392, 5) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 23 then
			if player:getPosition().x == 5831 then
				if item.itemid == 39352 then
					player:teleportTo(toPosition, true)
					item:transform(39354)
				elseif item.itemid == 39354 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 39353 then
						item:transform(39352)
						return true
					end
				end
			else
				if hasCreatureInArea(Position(5812, 4386, 5), Position(5830, 4401, 5), teleportConfig.creatureNames) then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote todos os monstros para sair.")
					return false
				else
					if item.itemid == 39352 then
						player:teleportTo(toPosition, true)
						item:transform(39354)
					elseif item.itemid == 39354 then
						if Creature.checkCreatureInsideDoor(player, toPosition) then
							return true
						end
						if item.itemid == 39353 then
							item:transform(39352)
							return true
						end
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Fale com a Rainha para poder entrar.")
			return false
		end
	elseif item:getPosition() == Position(5778, 4380, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 27 then
			if item.itemid == 39352 then
				player:teleportTo(toPosition, true)
				item:transform(39354)
			elseif item.itemid == 39354 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 39353 then
					item:transform(39352)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado. Fale com a Rainha Naga.")
			return false
		end
	elseif item:getPosition() == Position(5920, 4359, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 8 then
			player:teleportTo(Position(5918, 4357, 6))
			return false
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return false
		end
	elseif item:getPosition() == Position(5915, 4357, 6) then
		player:teleportTo(Position(5918, 4359, 6))
		return false
	end
end

portasNagas:aid(13128) 
portasNagas:register()