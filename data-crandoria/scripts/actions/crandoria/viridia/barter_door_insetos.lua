local forgeEldritch = Action()
function forgeEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Barter) >= 4 then
		if item.actionid == 13063 then
			if item.itemid == 5287 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 5288 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 5288 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao precisa da permissao de Barter para acessar esse local.")
	end
	return true
end

forgeEldritch:aid(13063)
forgeEldritch:register()