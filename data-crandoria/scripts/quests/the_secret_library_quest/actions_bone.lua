local bone = Action()

function bone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.Mota) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a reward.")
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.Mota, 2)
		return true
	end
	return false
end

bone:uid(1083)
bone:register()
