local STORAGE_BOSS_VULNERABLE = 66621
local STORAGE_GREEDBEAST_KILLS = 66622
local STORAGE_GREEDBEAST_KILLS_TIME = 66623

local greedDeath = CreatureEvent("greedDeath")

function greedDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local boss = Creature("Goshnar's Greed")
    if not boss then
        return true
    end

    -- Se o boss estiver vulnerável (tempo ainda válido), não contabiliza
    local vulnerableUntil = Game.getStorageValue(STORAGE_GREEDBEAST_KILLS_TIME)
    if vulnerableUntil > os.time() then
        return true
    end

    local count = Game.getStorageValue(STORAGE_GREEDBEAST_KILLS)
    if count < 0 then count = 0 end
    count = count + 1
    Game.setStorageValue(STORAGE_GREEDBEAST_KILLS, count)

    if count >= 5 then
        Game.setStorageValue(STORAGE_BOSS_VULNERABLE, 1)
        Game.setStorageValue(STORAGE_GREEDBEAST_KILLS, 0)

        -- Marca o tempo até quando ele deve ficar vulnerável
        local untilTime = os.time() + 50
        Game.setStorageValue(STORAGE_GREEDBEAST_KILLS_TIME, untilTime)

        boss:teleportTo(Position(33741, 31659, 14))
        boss:say("My greed has weakened...", TALKTYPE_MONSTER_SAY)
        boss:changeSpeed(-250)

        local sphere = Game.createMonster("Soul Sphere", Position(33752, 31659, 14))

        if sphere then
            addEvent(function()
                sphere:changeSpeed(35)
                sphere:move(DIRECTION_WEST)
                addEvent(function()
                    sphere:changeSpeed(-35)
                end, 500)
            end, 4000)
        end

        -- Após 45 segundos, tornar invulnerável novamente
        addEvent(function()
            local boss = Creature("Goshnar's Greed")
            if boss then
                Game.setStorageValue(STORAGE_BOSS_VULNERABLE, 0)
                boss:teleportTo(Position(33746, 31666, 14))
                boss:changeSpeed(250)
                boss:say("My greed shields me again!", TALKTYPE_MONSTER_SAY)
            end
        end, 50 * 1000)
    end

    return true
end

greedDeath:register()



local greedHealth = CreatureEvent("greedHealth")

function greedHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isMonster() or creature:getName() ~= "Goshnar's Greed" then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if Game.getStorageValue(STORAGE_BOSS_VULNERABLE) ~= 1 then
        return 0, primaryType, 0, secondaryType
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

greedHealth:register()