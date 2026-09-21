local exevoSan = Combat()
exevoSan:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
exevoSan:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
exevoSan:setArea(createCombatArea(AREA_CIRCLE3X3))

local exoriCon = Combat()
exoriCon:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
exoriCon:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
exoriCon:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
exoriCon:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

local exoriSan = Combat()
exoriSan:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
exoriSan:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
exoriSan:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

local exoriGranCon = Combat() -- 8
exoriGranCon:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
exoriGranCon:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
exoriGranCon:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
exoriGranCon:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)


function onGetFormulaValuesExevoSan(creature, target)
	local master = creature:getMaster()
    if not master then
        return 0, 0
    end

    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

    local min = (level / 6) + (category * 30) + (damage * 4)
    local max = (level / 5) + (category * 45) + (damage * 5)

    doTargetCombatHealth(creature, target, COMBAT_HOLYDAMAGE, -min, -max, false)
end


local function calculateExoriSanDamage(creature)
    local master = creature:getMaster()
    if not master then
        return 0, 0
    end

    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

    local min = (level / 8) + (category * 20) + (damage * 3)
    local max = (level / 6) + (category * 30) + (damage * 4)

    return -min, -max
end

local function calculateExoriGranConDamage(creature)
    local master = creature:getMaster()
    if not master then
        return 0, 0
    end

    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

    local min = (level / 5) + (category * 50) + (damage * 4)
    local max = (level / 4) + (category * 80) + (damage * 5)

    return -min, -max
end

local function calculateExoriConDamage(creature)
    local master = creature:getMaster()
    if not master then
        return 0, 0
    end

    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

    local min = (level / 6) + (category * 30) + (damage * 3)
    local max = (level / 4) + (category * 40) + (damage * 5)

    return -min, -max
end

exevoSan:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExevoSan")
-- exoriGranCon:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExevoSan")
-- exoriSan:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriGran")
-- exoriGranCon:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriMas")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local master = creature:getMaster()
    local pos = creature:getPosition()
    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
    local cooldown = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer)
    local minHeal = 125 + (55 * category) + (level / 8)
    local maxHeal = 150 + (110 * category) + (level / 6)
    local hpMax = creature:getMaxHealth()
    local hp = creature:getHealth()
    local hpPercent = math.floor((hp/hpMax) * 100)
    local potions = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions)
    local minRanged = (level / 8) + (category * 5) + (damage * 2)
    local maxRanged = (level / 4) + (category * 10) + (damage * 5)
    local now = os.time()

    addEvent(function()
        if hpPercent >= 60 and hpPercent < 85 then  
            doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
            creature:say('exura san', TALKTYPE_MONSTER_SAY)
            if creature:getCondition(CONDITION_PARALYZE) then
                creature:removeCondition(CONDITION_PARALYZE)
            end
        elseif hpPercent < 60 then
            if potions > 0 then
                local min = 350 + (25 * category) + (class * 25) + (level / 10)
                local max = 500 + (25 * category) + (class * 25) + (level / 10)
                doTargetCombatHealth(creature, creature, COMBAT_HEALING, min, max, CONST_ME_MAGIC_BLUE)
                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
                creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
            else
                local chance = math.random(1, 5)
                if chance == 1 then
                    master:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As pocoes do seu mercenario de esgotaram")
                end
                doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
                creature:say('exura san', TALKTYPE_MONSTER_SAY)
                if creature:getCondition(CONDITION_PARALYZE) then
                    creature:removeCondition(CONDITION_PARALYZE)
                end
            end
        end
    end, 1000)

    if master then
        local storage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell)
        local target = creature:getTarget()
        if target then
            local tpos = target:getPosition()
            local chanceHit = math.random(1 + (category * 7), 100)
            if category == 1 then
                pos:sendDistanceEffect(tpos, CONST_ANI_POWERBOLT)
            elseif category == 2 then
                pos:sendDistanceEffect(tpos, CONST_ANI_VORTEXBOLT)
            elseif category == 3 then
                pos:sendDistanceEffect(tpos, CONST_ANI_PRISMATICBOLT)
            end
            if chanceHit < 40 then
                tpos:sendMagicEffect(CONST_ME_POFF)
            else
                local pos = creature:getPosition()
                doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -minRanged, -maxRanged, false)
            end

            if math.abs(tpos.x - pos.x) <= 2 and math.abs(tpos.y - pos.y) <= 2 then
                addEvent(function()
                    if cooldown <= now then
                        creature:say('exevo mas san', TALKTYPE_MONSTER_SAY)
                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer, os.time() + 4)
                        local chanceMana = math.random(1, 5)
                        if chance == 1 then
                            addEvent(function()
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
                                creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
                            end, 500)
                        end
                        return exevoSan:execute(creature, var)
                    else
                        creature:say('exori con', TALKTYPE_MONSTER_SAY)
                        local min, max = calculateExoriConDamage(creature)
                        doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                        creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                        return true
                    end
                end, 300)
            else
                addEvent(function()
                    if target then
                        if pos.x == tpos.x or pos.y == tpos.y then
                            local options = {
                                Position(pos.x + 1, pos.y, pos.z),
                                Position(pos.x - 1, pos.y, pos.z),
                                Position(pos.x, pos.y + 1, pos.z),
                                Position(pos.x, pos.y - 1, pos.z)
                            }
                            for _, p in ipairs(options) do
                                if p.x ~= tpos.x and p.y ~= tpos.y then
                                    local tile = Tile(p)
                                    if tile and tile:isWalkable(false, false, false, false, true) then
                                        creature:move(Position.getDirectionTo(pos, p))
                                        break
                                    end
                                end
                            end
                        end
                    end
                end, 500)
                addEvent(function()
                    if storage < 1 then
                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 1)
                        creature:say('exori gran con', TALKTYPE_MONSTER_SAY)
                        local min, max = calculateExoriGranConDamage(creature)
                        doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                        creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                        return true
                    elseif storage == 1 then
                        if math.abs(tpos.x - pos.x) <= 2 and math.abs(tpos.y - pos.y) <= 2 then
                            if cooldown <= now then
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer, os.time() + 4)
                                creature:say('exevo mas san', TALKTYPE_MONSTER_SAY)
                                local chanceMana = math.random(1, 5)
                                if chance == 1 then
                                    addEvent(function()
                                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
                                        creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
                                    end, 500)
                                end
                                return exevoGranSan:execute(creature, var)
                            else
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
                                creature:say('exori con', TALKTYPE_MONSTER_SAY)
                                local min, max = calculateExoriConDamage(creature)
                                doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                                creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                                return true
                            end
                        else
                            master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
                            creature:say('exori con', TALKTYPE_MONSTER_SAY)
                            local min, max = calculateExoriSanDamage(creature)
                            doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                            creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                            return true
                        end
                    elseif storage == 2 then
                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 3)
                        creature:say('exori san', TALKTYPE_MONSTER_SAY)
                        local min, max = calculateExoriSanDamage(creature)
                        doTargetCombatHealth(creature, target, COMBAT_HOLYDAMAGE, min, max, CONST_ME_HOLYAREA)
                        creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_HOLY)
                        return true
                    elseif storage == 3 then
                        if math.abs(tpos.x - pos.x) <= 2 and math.abs(tpos.y - pos.y) <= 2 then
                            if cooldown <= now then
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer, os.time() + 4)
                                creature:say('exevo mas san', TALKTYPE_MONSTER_SAY)
                                local chanceMana = math.random(1, 5)
                                if chance == 1 then
                                    addEvent(function()
                                        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
                                        creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
                                    end, 500)
                                end
                                return exevoGranSan:execute(creature, var)
                            else
                                master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
                                creature:say('exori con', TALKTYPE_MONSTER_SAY)
                                local min, max = calculateExoriSanDamage(creature)
                                doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                                creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                                return true
                            end
                        else
                            master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
                            creature:say('exori con', TALKTYPE_MONSTER_SAY)
                            local min, max = calculateExoriSanDamage(creature)
                            doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
                            creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_ETHEREALSPEAR)
                            return true
                        end
                    end
                end, 300)
            end
        end
    end
    return true
end

spell:name("archer mercenary")
spell:words("###774")
spell:needLearn(true)
spell:cooldown("2000")
spell:blockWalls(true)
spell:isAggressive(true)
spell:register()