local frozenKey = Action()
function frozenKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.FrozenKey) ~= 1 then
		local newItem = Game.createItem(9172, 1)
		newItem:setActionId(13105)
		player:addItemEx(newItem)
		player:setStorageValue(Storage.Quest.Crandoria.Viridia.FrozenKey, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a frozen key.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The " .. ItemType(item.itemid):getName() .. " is empty.")
	end
end

frozenKey:aid(13060)
frozenKey:register()