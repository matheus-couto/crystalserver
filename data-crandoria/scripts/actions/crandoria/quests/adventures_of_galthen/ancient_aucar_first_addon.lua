local ancientaucar = Action()
function ancientaucar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.FirstAddon) < 1 then
		if player:getItemCount(40533) >= 1
		and player:getItemCount(40532) >= 1
		and player:getItemCount(40531) >= 1
		and player:getItemCount(40534) >= 1 then
		player:addOutfitAddon(1597, 1)
		player:addOutfitAddon(1598, 1)
		player:removeItem(40531, 1)
		player:removeItem(40532, 1)
		player:removeItem(40533, 1)
		player:removeItem(40534, 1)
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
		player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with the Ancient Aucar First Addon")
		player:setStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.FirstAddon, 1) --Questlog, Wrath of the Emperor "Mission 12: Just Rewards"
		return true
		elseif player:getStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.FirstAddon) < 1 then
			if player:getItemCount(40533) < 1
			or player:getItemCount(40532) < 1
			or player:getItemCount(40531) < 1
			or player:getItemCount(40534) < 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You do not have what is required to claim this reward.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the addon.")
	return true
	end
end
end
end

ancientaucar:position({x = 5572, y = 5114, z = 15})
ancientaucar:uid(12261)
ancientaucar:register()