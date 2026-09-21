local chestBandits = Action()

function chestBandits.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.FloatingChest) < 1 then
		player:addItem(3295, 1)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce encontrou uma Bright Sword.")
		player:setStorageValue(Storage.Quest.Crandoria.Viridia.FloatingChest, 1)
		return true
	else
		return true
	end
end

chestBandits:aid(13102)
chestBandits:register()