local doorEntregasEspeciais = Action()
function doorEntregasEspeciais.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso) >= 4 then
		if item:getPosition() == Position(5078, 4472, 8) then
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
		elseif item:getPosition() == Position(5372, 4692, 8) then
			if item.itemid == 1660 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 1661 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 1661 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		elseif item:getPosition() == Position(5523, 5142, 8) then
			if item.itemid == 1698 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 1699 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 1699 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
	end
	return true
end

doorEntregasEspeciais:aid(13178)
doorEntregasEspeciais:register()