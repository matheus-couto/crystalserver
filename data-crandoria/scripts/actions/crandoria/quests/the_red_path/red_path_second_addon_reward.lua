local decayingdefender = Action()
function decayingdefender.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getSkull() == SKULL_BLACK and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 2 then
 	        if player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT then
        	player:addOutfitAddon(632, 2)
       		player:addOutfitAddon(633, 2)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN then
            	player:addOutfitAddon(1102, 2)
            	player:addOutfitAddon(1103, 2)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER then
            	player:addOutfitAddon(1846, 2)
            	player:addOutfitAddon(1845, 2)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID then
            	player:addOutfitAddon(853, 2)
            	player:addOutfitAddon(852, 2)
			elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK then
            	player:addOutfitAddon(1837, 2)
            	player:addOutfitAddon(1838, 2)
        	end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with some cursed Addon...")
		player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 3) 
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 10)
        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		return true
	elseif player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the addon.")
	return true
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only those who took enough souls can be rewarded with this Addon. You are still weak...")
	return true
	end
end

decayingdefender:position({x = 6121, y = 5259, z = 2})
decayingdefender:uid(12266)
decayingdefender:register()