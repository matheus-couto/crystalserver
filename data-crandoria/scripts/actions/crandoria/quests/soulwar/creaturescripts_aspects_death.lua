local STORAGE_ASPECTS_KILLS = 66625

local aspectsDeath = CreatureEvent("aspectsDeath")

function aspectsDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local boss = Creature("Goshnar's Megalomania")
    if not boss or not boss:isMonster() then
        return true
    end

    local count = Game.getStorageValue(STORAGE_ASPECTS_KILLS)
    if count < 0 then count = 0 end
    count = count + 1
    Game.setStorageValue(STORAGE_ASPECTS_KILLS, count)

    if count >= 4 then
        Game.setStorageValue(STORAGE_ASPECTS_KILLS, 0)

        local bossPos = boss:getPosition()
        local bossHealth = boss:getHealth()
        boss:remove()

        local newBoss = Game.createMonster("Goshnar's Megalomania 2", bossPos)
        if newBoss then
            newBoss:setHealth(bossHealth)
            addEvent(function()
                local newPos = newBoss:getPosition()
                local newHp = newBoss:getHealth()
                if newBoss then
                    newBoss:remove()
                    local bossAgain = Game.createMonster("Goshnar's Megalomania", newPos)
                    if bossAgain then
                        bossAgain:setHealth(newHp)
                    end
                end
            end, 70000)
        end
    end

    return true
end

aspectsDeath:register()
