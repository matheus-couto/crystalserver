local arenaViridia = Action()
function arenaViridia.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso) >= 10 then
		if item.actionid == 13100 then
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tyrtus nao permitiu sua entrada na Arena.")
	end
	return true
end

arenaViridia:aid(13100)
arenaViridia:register()