local portaViridiaAddons = Action()
function portaViridiaAddons.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) >= 35 then
		if item.actionid == 13092 then
			if item.itemid == 9363 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 9364 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 9364 then
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

portaViridiaAddons:aid(13092)
portaViridiaAddons:register()