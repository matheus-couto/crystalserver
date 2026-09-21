local ancientaucar = Action()
function ancientaucar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.Outfit) < 1 then
		player:addOutfit(1597, 0)
		player:addOutfit(1598, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with the Ancient Aucar Outfits")
		player:setStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.Outfit, 1) --Questlog, Wrath of the Emperor "Mission 12: Just Rewards"
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
		player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		return true
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the outfit.")
	return true
	end
end

ancientaucar:position({x = 5568, y = 5114, z = 15})
ancientaucar:uid(12260)
ancientaucar:register()