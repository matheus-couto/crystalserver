local portaViridiaDwarves = Action()
function portaViridiaDwarves.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) >= 35 then
		if item.actionid == 13093 then
			if item.itemid == 6907 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 6908 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 6908 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas os maiores aprendizes de Haldor podem acessar este local.")
	end
	return true
end

portaViridiaDwarves:aid(13093)
portaViridiaDwarves:register()