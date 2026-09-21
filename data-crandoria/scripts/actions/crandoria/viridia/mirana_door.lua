local miranaDoor = Action()
function miranaDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getPosition().x == 4464 then
		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Mirana.TimerDoor) >= os.time() then
			if item.actionid == 13106 then
				if item.itemid == 5131 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 5132 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 5132 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para passar pela porta.")
		end
	else
		if item.itemid == 5131 then
			player:teleportTo(toPosition, true)
			item:transform(item.itemid + 1)
		elseif item.itemid == 5132 then
			if Creature.checkCreatureInsideDoor(player, toPosition) then
				return true
			end
			if item.itemid == 5132 then
				item:transform(item.itemid - 1)
				return true
			end
		end
	end
	return true
end

miranaDoor:aid(13106)
miranaDoor:register()