local decayingdefender = Action()

function decayingdefender.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if (player:getSkull() == SKULL_WHITE or player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK) and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 1 then
        if player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT then
            player:addOutfit(632, 0)
            player:addOutfit(633, 0)
        elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN then
            player:addOutfit(1102, 0)
            player:addOutfit(1103, 0)
        elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER then
            player:addOutfit(1846, 0)
            player:addOutfit(1845, 0)
        elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID then
            player:addOutfit(853, 0)
            player:addOutfit(852, 0)
        elseif player:getVocation():getBaseId() == VOCATION.BASE_ID.MONK then
            player:addOutfit(1837, 0)
            player:addOutfit(1838, 0)
        end

        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been rewarded with a cursed Outfit.")
        player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit, 1)
        return true
    elseif player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already taken the outfit.")
        return true
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the followers of the Red Path can be rewarded with this Outfit.")
        return true
    end
end

decayingdefender:position({x = 6084, y = 5361, z = 5})
decayingdefender:uid(12264)
decayingdefender:register()
