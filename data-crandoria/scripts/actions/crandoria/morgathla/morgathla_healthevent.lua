local hp1 = 650000
local hp2 = 450000
local hp3 = 200000

local morgathlaHealth = CreatureEvent("morgathlaHealth")

function morgathlaHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isMonster() or creature:getName() ~= "Ancient Spawn of Morgathla" then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local storageInvulnerability = creature:getStorageValue(Storage.Quest.Crandoria.Morgathla.Health)
    local storageChange = creature:getStorageValue(Storage.Quest.Crandoria.Morgathla.HealthChange)
    local chance = math.random(1, 300)

    if chance == 1 then
        creature:setStorageValue(Storage.Quest.Crandoria.Morgathla.Health, 1)
    end

    if storageInvulnerability == 1 then
        return 0, primaryType, 0, secondaryType
    else
        if creature:getHealth() < hp1 and storageChange < 1 then
            creature:teleportTo(Position(33748, 32384, 15))
            creature:setStorageValue(Storage.Quest.Crandoria.Morgathla.HealthChange, 1)
            addEvent(function()
                creature:teleportTo(Position(33734, 32340, 15))
            end, 20000)
            local teleport = Game.createItem(1949, 1, Position(33732, 32367, 15))
            if teleport then
                teleport:setDestination(Position(33733, 32357, 15))
                addEvent(function()
                    teleport:remove()
                end, 60000)
            end
        elseif creature:getHealth() < hp2 and storageChange < 2 then
            creature:teleportTo(Position(33748, 32384, 15))
            creature:setStorageValue(Storage.Quest.Crandoria.Morgathla.HealthChange, 2)
            addEvent(function()
                creature:teleportTo(Position(33763, 32366, 15))
            end, 20000)
            local teleport = Game.createItem(1949, 1, Position(33730, 32335, 15))
            if teleport then
                teleport:setDestination(Position(33755, 32357, 15))
                addEvent(function()
                    teleport:remove()
                end, 60000)
            end
        elseif creature:getHealth() < hp3 and storageChange < 3 then
            creature:teleportTo(Position(33748, 32384, 15))
            creature:setStorageValue(Storage.Quest.Crandoria.Morgathla.HealthChange, 3)
            addEvent(function()
                creature:teleportTo(Position(33782, 32337, 15))
            end, 20000)
            local teleport = Game.createItem(1949, 1, Position(33780, 32366, 15))
            if teleport then
                teleport:setDestination(Position(33781, 32349, 15))
                addEvent(function()
                    teleport:remove()
                end, 60000)
            end
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

morgathlaHealth:register()