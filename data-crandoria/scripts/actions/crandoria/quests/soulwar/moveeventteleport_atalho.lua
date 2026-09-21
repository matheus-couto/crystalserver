local teleport = MoveEvent()

function teleport.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	local storage = player:getStorageValue(Storage.Quest.U12_40.SoulWar.QuestReward)
	if storage >= 1 then
		player:teleportTo(Position(33621, 31428, 10))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas aqueles que ja finalizaram a Soul War podem entrar.")
	end
end

teleport:aid(13182)
teleport:register()