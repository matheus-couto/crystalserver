-- local config = {
--     chestItemUniqueId = 12293,
--     rewardStorage = Storage.Quest.Crandoria.Timira.Reward,
--     cooldownHours = 20,
--     rewards = {
--         {itemId = 39156, chance = 1},   -- Naga Axe
--         {itemId = 39157, chance = 1},   -- Naga Club
--         {itemId = 39155, chance = 1},   -- Naga Sword
--         {itemId = 39162, chance = 1},   -- Naga Wand
--         {itemId = 39163, chance = 1},   -- Naga Rod
--         {itemId = 39159, chance = 1},   -- Naga Crossbow
--         {itemId = 39160, chance = 1},   -- Naga Quiver
--         {itemId = 3043, chance = 50},   -- Crystal Coin
--         {itemId = 30061, chance = 23},  -- Giant Sapphire
--         {itemId = 32622, chance = 20},  -- Giant Amethyst
--     }
-- }

local timiraChest = Action()

function timiraChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local chance1 = math.random(1, 100)
    local chance2 = math.random(1, 105)

    if player:getStorageValue(Storage.Quest.Crandoria.Timira.Reward) < os.time() then
        if chance1 == 100 then
            if chance2 > 90 then
                player:addItem(39156, 1, true)
                return true
            elseif chance2 <= 90 and chance2 > 75 then
                player:addItem(39157, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Naga Club.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            elseif chance2 <= 75 and chance2 > 60 then
                player:addItem(39155, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu uma Naga Sword.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            elseif chance2 <= 60 and chance2 > 45 then
                player:addItem(39162, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu uma Naga Wand.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            elseif chance2 <= 45 and chance2 > 30 then
                player:addItem(39163, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu uma Naga Rod.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            elseif chance2 <= 30 and chance2 > 15 then
                player:addItem(39159, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Naga Crossbow.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            else
                player:addItem(39160, 1, true)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu um Naga Quiver.")
                player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
                return true
            end
        elseif chance1 < 100 and chance1 > 50 then
            player:addItem(30061, 1, true)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu uma Giant Sapphire.")
            player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
            return true
        else
            player:addItem(3043, 3, true)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce recebeu 3 Crystal Coins.")
            player:setStorageValue(Storage.Quest.Crandoria.Timira.Reward, os.time() + 20 * 60 * 60)
            return true
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Apos abrir o bau, voce deve aguardar 20 horas para abri-lo novamente.")
        return true
    end

    -- if item:getUniqueId() == config.chestItemUniqueId then
    --     local lastUseTime = player:getStorageValue(config.rewardStorage)
    --     local currentTime = os.time()

    --     if lastUseTime > 0 and currentTime - lastUseTime < config.cooldownHours * 3600 then
    --         player:sendTextMessage(MESSAGE_INFO_DESCR, "You must wait 20 hours before using the chest again.")
    --         return true
    --     end

    --     local totalWeight = 0
    --     for _, reward in ipairs(config.rewards) do
    --         totalWeight = totalWeight + reward.chance
    --     end

    --     local randomValue = math.random(1, totalWeight)
    --     local accumulatedWeight = 0

    --     for _, reward in ipairs(config.rewards) do
    --         accumulatedWeight = accumulatedWeight + reward.chance

    --         if randomValue <= accumulatedWeight then
    --             player:addItem(reward.itemId, 1)
    --             break
    --         end
    --     end

    --     player:setStorageValue(config.rewardStorage, currentTime)

    --     player:sendTextMessage(MESSAGE_INFO_DESCR, "You received a reward from the chest.")
    --     return true
    -- else
    --     player:sendTextMessage(MESSAGE_INFO_DESCR, "This is not the correct chest.")
    --     return false
    -- end
end

timiraChest:uid(12293)
timiraChest:register()