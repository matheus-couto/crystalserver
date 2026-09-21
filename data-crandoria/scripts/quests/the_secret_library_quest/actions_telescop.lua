local telescop = Action()

function telescop.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.HighDry) == 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"By using the telescope you observate the stellar constellations. This should help you to navigate your way back to mainland.")
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.HighDry, 4)
		return true
	end
	return false
end

telescop:uid(1103)
telescop:register()
