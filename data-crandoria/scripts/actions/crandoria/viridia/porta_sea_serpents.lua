local doorSeaSerpents = Action()
function doorSeaSerpents.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.SeaSerpentQuest) >= 7 then
		if item.actionid == 13110 then
			if item.itemid == 1644 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 1645 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 1645 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa da autorizacao de Iggmor par acessar essa porta.")
	end
	return true
end

doorSeaSerpents:aid(13110)
doorSeaSerpents:register()