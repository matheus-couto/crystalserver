local forgeEldritch = Action()
function forgeEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.Progresso) >= 2 then
		if item.actionid == 13046 then
			if item.itemid == 36547 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 36548 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 36548 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa da permissao de Howard Rootberg para passar.")
	end
	return true
end

forgeEldritch:aid(13046)
forgeEldritch:register()