local doorDrakens = Action()
function doorDrakens.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) >= 5 then
		if item.actionid == 13056 then
			if item.itemid == 9361 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 9362 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 9362 then
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

doorDrakens:aid(13056)
doorDrakens:register()