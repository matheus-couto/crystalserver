local teleportNagasLabirinto = MoveEvent()

function teleportNagasLabirinto.onStepIn(player, item, position, fromPosition)

	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 25 then
		player:teleportTo(Position(5874, 4417, 14))
		return true
	else
		player:teleportTo(Position(fromPosition))
		return true
	end
end

teleportNagasLabirinto:aid(13143)
teleportNagasLabirinto:register()