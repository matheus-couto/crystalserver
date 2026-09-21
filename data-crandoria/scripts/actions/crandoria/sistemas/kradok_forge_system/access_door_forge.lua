local forgeEldritch = Action()
function forgeEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.Door) == 2 then
		if item.actionid == 12346 then
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa da permissao de Kradok para acessar a forja.")
	end
	return true
end

forgeEldritch:aid(12346)
forgeEldritch:register()