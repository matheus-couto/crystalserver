local tileAlbinius = MoveEvent()

function tileAlbinius.onStepIn(player, item, position, fromPosition)

	if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) >= 6 then
		return true
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce ainda nao pode passar. Converse com Albinius.")
		return true
	end

end

tileAlbinius:aid(13138)
tileAlbinius:register()