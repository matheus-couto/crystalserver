local chestFirstWeapon = Action()

-- x do bau -> arma recebida
local rewardByChestX = {
    [4907] = 3289,
    [4909] = 3344,
    [4911] = 3295,
    [4913] = 7430,
    [4915] = 7438,
    [4917] = 3073,
    [4919] = 3065,
}

function chestFirstWeapon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.FirstWeapon.FirstWeaponReward) >= 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio. Voce ja pegou o seu item.")
        return true
    end

    local rewardId = rewardByChestX[item:getPosition().x]
    if not rewardId then
        return true
    end

    local reward = player:addItem(rewardId, 1)
    if not reward then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem espaco ou capacidade para carregar este item.")
        return true
    end

    player:setStorageValue(Storage.Quest.Crandoria.FirstWeapon.FirstWeaponReward, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou " .. ItemType(rewardId):getName() .. ".")
    return true
end

chestFirstWeapon:aid(13223)
chestFirstWeapon:register()
