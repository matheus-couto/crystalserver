local kameDoorOne = Action()
function kameDoorOne.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Pig) >= 1 then
		if item.actionid == 13013 then
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
		player:say("Voce nao possui a chave para abrir essa porta.", TALKTYPE_MONSTER_SAY)
	end
	return true
end

kameDoorOne:aid(13013)
kameDoorOne:register()