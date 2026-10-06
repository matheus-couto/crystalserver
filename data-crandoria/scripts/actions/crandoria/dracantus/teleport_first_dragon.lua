local aposentosFirstDragon = MoveEvent()

function aposentosFirstDragon.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	if item:getPosition() == Position(4511, 4882, 5) then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 8 then
			player:teleportTo(Position(4535, 5025, 15))
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	elseif item:getPosition() == Position(4491, 4903, 8) then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 6 then
			player:teleportTo(Position(4493, 4903, 8))
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	elseif item:getPosition() == Position(4412, 5015, 15) then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 6 then
			player:teleportTo(Position(4414, 5015, 15))
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	elseif item:getPosition() == Position(4488, 5003, 5) then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 6 then
			player:teleportTo(Position(4488, 5005, 5))
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	elseif item:getPosition() == Position(4509, 5039, 7) then
		if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 6 then
			player:teleportTo(Position(4509, 5043, 7))
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	end	
	return true

end

aposentosFirstDragon:aid(13194)
aposentosFirstDragon:register()