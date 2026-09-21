local teleportLabirinto = MoveEvent()

function teleportLabirinto.onStepIn(player, item, position, fromPosition)

	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) >= 26 then
		player:teleportTo(Position(5898, 4325, 14))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas aqueles que derrotaram o boss podem acessar o teleport.")
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
		
end

teleportLabirinto:aid(13151)
teleportLabirinto:register()