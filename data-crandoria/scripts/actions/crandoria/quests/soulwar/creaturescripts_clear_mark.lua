local clearMark = MoveEvent()

function clearMark.onStepIn(player, item, position, fromPosition)

	if not player then
		return true
	end

	item:remove()
	player:setStorageValue(Storage.Quest.U12_40.SoulWar.TimerDeathHatred, 0)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "0")
	player:say("Contagem reiniciada.", TALKTYPE_MONSTER_SAY)
	return true

end

clearMark:id(33792)
clearMark:register()