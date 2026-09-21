local decayingdefender = Action()
function decayingdefender.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if (player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK) and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 1 then
 	        if player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT then
        	player:addOutfitAddon(632, 1)
       		player:addOutfitAddon(633, 1)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN then
            	player:addOutfitAddon(1102, 1)
            	player:addOutfitAddon(1103, 1)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER then
            	player:addOutfitAddon(1846, 1)
            	player:addOutfitAddon(1845, 1)
        	elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID then
            	player:addOutfitAddon(853, 1)
            	player:addOutfitAddon(852, 1)
			elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK then
            	player:addOutfitAddon(1837, 1)
            	player:addOutfitAddon(1838, 1)
        	end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with some cursed Addon...")
		player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 2) 
		return true
	elseif player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the addon.")
	return true
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only those who took enough souls can be rewarded with this Addon. You are still weak...")
	return true
	end
end

decayingdefender:position({x = 6061, y = 5277, z = 6})
decayingdefender:uid(12265)
decayingdefender:register()