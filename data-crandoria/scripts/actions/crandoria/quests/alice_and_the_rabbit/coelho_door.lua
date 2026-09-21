local coelhoDoor = Action()
function coelhoDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 5 then
		if item.actionid == 12372 then
			if item.itemid == 5113 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 5114 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 5114 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce tenta abrir a porta, mas nao consegue.")
	end
	return true
end

coelhoDoor:aid(12372)
coelhoDoor:register()