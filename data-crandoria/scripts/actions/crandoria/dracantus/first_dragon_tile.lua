local ritualFirstDragon = MoveEvent()

function ritualFirstDragon.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 7 then
		player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 8)
		position():sendMagicEffect(CONST_ME_AATAR_APPEAR)
		return true
	end

	return true

end

ritualFirstDragon:aid(13192)
ritualFirstDragon:register()