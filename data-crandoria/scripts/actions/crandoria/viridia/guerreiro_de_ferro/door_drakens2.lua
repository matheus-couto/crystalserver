local doorDrakens = Action()
function doorDrakens.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) >= 25 then
		if item.actionid == 13055 then
			if item.itemid == 9874 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 9875 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 9875 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Obtenha o tesouro do Draken Elite antes de acessar esta sala.")
	end
	return true
end

doorDrakens:aid(13055)
doorDrakens:register()