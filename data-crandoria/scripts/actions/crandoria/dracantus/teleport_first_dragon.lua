local aposentosFirstDragon = MoveEvent()

function aposentosFirstDragon.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 8 then
		player:teleportTo(Position(4535, 5025, 15))
		return true
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
		return true
	end

	return true

end

aposentosFirstDragon:aid(13194)
aposentosFirstDragon:register()