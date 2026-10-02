local chestFirstWeapon = Action()

function chestFirstWeapon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.FirstWeapon.FirstWeaponReward)

    if storage < 1 then
        if item:getPosition().x == 4907 then
            player:addItem(3289, 1) 
        elseif item:getPosition().x == 4909 then
            player:addItem(3344, 1) 
        elseif item:getPosition().x == 4911 then
            player:addItem(3295, 1) 
        elseif item:getPosition().x == 4913 then
            player:addItem(7430, 1) 
        elseif item:getPosition().x == 4915 then
            player:addItem(7438, 1) 
        elseif item:getPosition().x == 4917 then
            player:addItem(3073, 1) 
        elseif item:getPosition().x == 4919 then
            player:addItem(3065, 1) 
        end
        player:setStorageValue(Storage.Quest.Crandoria.FirstWeapon.FirstWeaponReward, 1)
    end
	return true
end

chestFirstWeapon:aid(13223)
chestFirstWeapon:register()