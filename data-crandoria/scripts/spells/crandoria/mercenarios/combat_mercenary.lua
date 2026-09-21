local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local master = creature:getMaster()
    if master then
        local pos = creature:getPosition()
        local level = master:getLevel()
        local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
        local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
        local class = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Class)
        local hpMax = creature:getMaxHealth()
        local hp = creature:getHealth()
        local hpPercent = math.floor((hp/hpMax) * 100)
        local potions = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions)
        local minHeal = 150 + (20 * category) + (class * 30) + (level / 10)
        local maxHeal = 250 + (20 * category) + (class * 30) + (level / 10)

        if hpPercent < 85 and hpPercent >= 65 then
            doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
            if class == 1 then
                creature:say('exura ico', TALKTYPE_MONSTER_SAY)
            elseif class == 2 then
                creature:say('exura san', TALKTYPE_MONSTER_SAY)
            elseif class == 3 then
                creature:say('exura gran', TALKTYPE_MONSTER_SAY)
            end
        end

        if hpPercent < 75 and class == 3 then
            creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
            master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
        end

        addEvent(function()
            if potions < 1 then
                local chance = math.random(1, 5)
                if chance == 5 then
                    master:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As pocoes do seu mercenario de esgotaram")
                    return true
                end
            else
                local min = 350 + (25 * category) + (class * 25) + (level / 10)
                local max = 500 + (25 * category) + (class * 25) + (level / 10)
                if hpPercent < 65 then
                    doTargetCombatHealth(creature, creature, COMBAT_HEALING, min, max, CONST_ME_MAGIC_BLUE)
                    if class == 1 or class == 2 then
                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
                        creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
                    else
                        creature:say('exura vita', TALKTYPE_MONSTER_SAY)
                    end
                end
            end
        end, 1000)
    end
    return true
end

spell:name("cura potion mercenary")
spell:words("###773")
spell:needLearn(true)
spell:cooldown("2000")
spell:needTarget(true)
spell:register()