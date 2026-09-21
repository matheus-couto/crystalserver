local forgeEldritch = Action()
function forgeEldritch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled) > 0 then
		if item.actionid == 13043 then
			if item.itemid == 7721 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 7722 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 7722 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote The Monster para ter acesso a esta porta.")
	end
	return true
end

forgeEldritch:aid(13043)
forgeEldritch:register()