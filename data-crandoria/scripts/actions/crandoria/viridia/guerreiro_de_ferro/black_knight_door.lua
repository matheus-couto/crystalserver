local doorBlackKnight = Action()
function doorBlackKnight.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) >= 18 then
		if item.actionid == 13053 then
			if item.itemid == 5131 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 5153 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 5153 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao pode acessar esta sala.")
	end
	return true
end

doorBlackKnight:aid(13053)
doorBlackKnight:register()