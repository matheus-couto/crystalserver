local sealedBook = Action()

function sealedBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.PinkTel) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"You have found a scribbled notes.")
		player:addItem(33391, 1)
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.HighDry, 1)
		return true
	end
	return false
end

sealedBook:uid(1101)
sealedBook:register()
