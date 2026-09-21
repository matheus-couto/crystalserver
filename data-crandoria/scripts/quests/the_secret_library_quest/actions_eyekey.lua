local eyeKey = Action()

function eyeKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.TheLament) == 4 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"You have found a eye key.")
		player:addItem(33265, 1)
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.TheLament, 5)
		return true
	end
	return false
end

eyeKey:uid(1094)
eyeKey:register()
