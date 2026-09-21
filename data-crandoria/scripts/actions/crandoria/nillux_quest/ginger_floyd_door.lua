local doorGinger = Action()
function doorGinger.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.Progresso) >= 6 then
		if item.actionid == 13169 then
			if item.itemid == 7723 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 7724 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 7723 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		return false
	end
	return true
end

doorGinger:aid(13169)
doorGinger:register()