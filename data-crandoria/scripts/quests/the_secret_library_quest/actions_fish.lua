local fish = Action()

function fish.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.HighDry) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"You have found a hawser.")
		player:addItem(32407, 1)
		player:setStorageValue(Storage.Quest.U11_80.TheSecretLibrary.HighDry, 3)
		return true
	end
	return false
end

fish:uid(1102)
fish:register()
