local summonLever = Action()

local summonData = {
    [21125] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon1, monsters = {
        [1] = {"Crandoria Knight", "Crandoria Gladiator", "Crandoria Warmaster"},
        [2] = {"Umbra Knight", "Umbra Gladiator", "Umbra Warmaster"}
    }},
    [21127] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon2, monsters = {
        [1] = {"Crandoria Archer", "Crandoria Ranger", "Crandoria Windstriker"},
        [2] = {"Umbra Archer", "Umbra Ranger", "Umbra Windstriker"}
    }},
    [21128] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon3, monsters = {
        [1] = {"Crandoria Mage", "Crandoria Conjurer", "Crandoria Warlock"},
        [2] = {"Umbra Mage", "Umbra Conjurer", "Umbra Warlock"}
    }}
}

local summonCosts = {10, 15, 20}

local summonPositions = {
    [1] = Position(3947, 4762, 7),
    [2] = Position(4015, 4762, 7)
}

function summonLever.onUse(player, item, fromPosition, target, toPosition)
    local summonInfo = summonData[item.itemid]
    if not summonInfo then
        return false
    end
    
    if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerSummon) > os.time() then
        player:sendCancelMessage("Voce so pode invocar um monstro a cada 5 segundos.")
        return true
    end
    
    local summonCount = player:getStorageValue(summonInfo.storage)
    if summonCount < 0 then
        summonCount = 0
    end
    
    local level = math.min(math.floor(summonCount / 3) + 1, 3)
    local cost = summonCosts[level]
    
    if player:getItemCount(3031) < cost then
        player:sendCancelMessage("Voce precisa de " .. cost .. " gold coins para invocar este monstro.")
        return true
    end
    
    local team = player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time)
    local spawnPosition = summonPositions[team]
    if not spawnPosition then
        player:sendCancelMessage("Voce nao esta em um time valido.")
        return true
    end

    local monsterName = summonInfo.monsters[team] and summonInfo.monsters[team][level]
    if not monsterName then
        player:sendCancelMessage("Nao foi possivel determinar o monstro a ser invocado.")
        return true
    end
    
    player:removeItem(3031, cost)
    player:setStorageValue(summonInfo.storage, summonCount + 1)
    player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerSummon, os.time() + 5)
    
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce invocou " .. monsterName .. "!")

    local monsterSummoned = Game.createMonster(monsterName, spawnPosition, true, true)
    if monsterSummoned then
        addEvent(function()
            if monsterSummoned:getOutfit().lookLegs == 0 then
                monsterSummoned:teleportTo(Position(3956, 4762, 7))
            elseif monsterSummoned:getOutfit().lookLegs == 114 then
                monsterSummoned:teleportTo(Position(4005, 4762, 7))
            end
        end, 200)
    end

    return true
end

summonLever:aid(13115)
summonLever:register()


-- local summonLever = Action()

-- local summonData = {
--     [21125] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon1, monsters = {"Knight 1", "Knight 2", "Knight 3"}},
--     [21127] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon2, monsters = {"Archer 1", "Archer 2", "Archer 3"}},
--     [21128] = {storage = Storage.Quest.Crandoria.TibiaClash.Summon3, monsters = {"Mage 1", "Mage 2", "Mage 3"}}
-- }

-- local summonCosts = {10, 15, 20}

-- local summonPositions = {
--     [1] = Position(3956, 4762, 7),
--     [2] = Position(4005, 4762, 7)
-- }

-- function summonLever.onUse(player, item, fromPosition, target, toPosition)
--     local summonInfo = summonData[item.itemid]
--     if not summonInfo then
--         return false
--     end
    
--     if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerSummon) > os.time() then
--         player:sendCancelMessage("Voce so pode invocar um monstro a cada 5 segundos.")
--         return true
--     end
    
--     local summonCount = player:getStorageValue(summonInfo.storage)
--     if summonCount < 0 then
--         summonCount = 0
--     end
    
--     local level = math.min(math.floor(summonCount / 3) + 1, 3)
--     local cost = summonCosts[level]
    
--     if player:getItemCount(3031) < cost then
--         player:sendCancelMessage("Voce precisa de " .. cost .. " gold coins para invocar este monstro.")
--         return true
--     end
    
--     local team = player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.Time)
--     local spawnPosition = summonPositions[team]
--     if not spawnPosition then
--         player:sendCancelMessage("Voce nao esta em um time valido.")
--         return true
--     end
    
--     player:removeItem(3031, cost)
--     Game.createMonster(summonInfo.monsters[level], spawnPosition, true, true)
--     player:setStorageValue(summonInfo.storage, summonCount + 1)
--     player:setStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerSummon, os.time() + 5)
    
--     player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce invocou " .. summonInfo.monsters[level] .. "!")
--     return true
-- end

-- summonLever:aid(13115)
-- summonLever:register()










