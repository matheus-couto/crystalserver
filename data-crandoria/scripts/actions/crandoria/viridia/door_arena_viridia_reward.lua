local arenaViridiaReward = Action()
function arenaViridiaReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Reward) >= 1 then
		if item.actionid == 13101 then
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce deve completar o desafio da Arena do Caos para acessar o local.")
	end
	return true
end

arenaViridiaReward:aid(13101)
arenaViridiaReward:register()