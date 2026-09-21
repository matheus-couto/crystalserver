local spell = Spell("instant")

-- ========= FUNÇÃO DE DANO =========
local function getMercDamage(creature, type)
    local master = creature:getMaster()
    if not master then
        return 0, 0
    end

    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

    if type == "exori" then
        return -(level/6 + category*30 + damage*4),
               -(level/5 + category*45 + damage*5)

    elseif type == "exoriGran" then
        return -(level/6 + category*50 + damage*5),
               -(level/4.5 + category*60 + damage*8)

    elseif type == "exoriMas" then
        return -(level/8 + category*25 + damage*2),
               -(level/6 + category*30 + damage*4)

    elseif type == "exoriHur" then
        return -(level/8 + category*25 + damage*3),
               -(level/6 + category*35 + damage*4)
    end

    return 0, 0
end

-- ========= AREA 3x3 MANUAL =========
local function doAreaDamage(creature, effect, damageType, min, max)
    local pos = creature:getPosition()
    local master = creature:getMaster()
    if not master then return end

    for x = -1, 1 do
        for y = -1, 1 do
            local tilePos = Position(pos.x + x, pos.y + y, pos.z)
            local tile = Tile(tilePos)
            if tile then
                tilePos:sendMagicEffect(effect)
                for _, target in ipairs(tile:getCreatures() or {}) do
                    if target ~= creature then
                        doTargetCombatHealth(master, target, damageType, min, max, CONST_ME_NONE)
                    end
                end
            end
        end
    end
end

-- ========= SPELL =========
function spell.onCastSpell(creature, var)

    local master = creature:getMaster()
    if not master then return true end

    local pos = creature:getPosition()
    local target = creature:getTarget()
    local level = master:getLevel()
    local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
    local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
    local class = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Class)
    local storage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell)

    if storage < 0 then storage = 0 end

    -- ========= HEAL SYSTEM =========
    local hp = creature:getHealth()
    local hpMax = creature:getMaxHealth()
    local hpPercent = math.floor((hp/hpMax) * 100)
    local potions = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions)

    local minHeal = 100 + (50 * category) + (level / 8)
    local maxHeal = 125 + (100 * category) + (level / 6)

    if hpPercent >= 60 and hpPercent < 85 then
        doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
        creature:say('exura ico', TALKTYPE_MONSTER_SAY)

    elseif hpPercent < 60 then
        if potions > 0 then
            local min = 350 + (25 * category) + (class * 25) + (level / 10)
            local max = 500 + (25 * category) + (class * 25) + (level / 10)

            doTargetCombatHealth(creature, creature, COMBAT_HEALING, min, max, CONST_ME_MAGIC_BLUE)
            master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
            creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
        else
            doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
            creature:say('exura ico', TALKTYPE_MONSTER_SAY)
        end
    end

    -- ========= CHALLENGE =========
    if master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer) <= os.time() then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer, os.time() + 4)
        creature:say('exeta res', TALKTYPE_MONSTER_SAY)
        if target then
            doChallengeCreature(creature, target, 4000)
        end
    end

    if not target then return true end

    local tpos = target:getPosition()

    -- ========= EXORI HUR (DISTANCIA) =========
    if math.abs(tpos.x - pos.x) > 1 or math.abs(tpos.y - pos.y) > 1 then
        local min, max = getMercDamage(creature, "exoriHur")

        creature:say('exori hur', TALKTYPE_MONSTER_SAY)
        pos:sendDistanceEffect(tpos, CONST_ANI_WHIRLWINDSWORD)
        doTargetCombatHealth(master, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
        return true
    end

    -- ========= ROTACAO DE SPELLS =========

    if storage == 0 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 1)
        local min, max = getMercDamage(creature, "exoriGran")
        creature:say('exori gran', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 1 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
        local min, max = getMercDamage(creature, "exoriMas")
        creature:say('exori mas', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_GROUNDSHAKER, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 2 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 3)
        local min, max = getMercDamage(creature, "exori")
        creature:say('exori', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 3 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 4)
        local min, max = getMercDamage(creature, "exoriGran")
        creature:say('exori gran', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 4 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 5)
        local min, max = getMercDamage(creature, "exori")
        creature:say('exori', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 5 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 6)
        local min, max = getMercDamage(creature, "exoriMas")
        creature:say('exori mas', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_GROUNDSHAKER, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 6 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 7)
        local min, max = getMercDamage(creature, "exoriGran")
        creature:say('exori gran', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)

    elseif storage == 7 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 8)
        local min, max = getMercDamage(creature, "exori")
        creature:say('exori', TALKTYPE_MONSTER_SAY)
        doAreaDamage(creature, CONST_ME_HITAREA, COMBAT_PHYSICALDAMAGE, min, max)
    elseif storage == 8 then
        master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
        local min, max = getMercDamage(creature, "exoriHur")
        creature:say('exori hur', TALKTYPE_MONSTER_SAY)
        pos:sendDistanceEffect(tpos, CONST_ANI_WHIRLWINDSWORD)
        doTargetCombatHealth(master, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
    end

    return true
end

spell:name("melee mercenary")
spell:words("###771")
spell:needLearn(true)
spell:cooldown(2000)
spell:blockWalls(true)
spell:isAggressive(true)
spell:register()







-- local exori = Combat()
-- exori:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exori:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exori:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exori:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exori:setArea(createCombatArea(AREA_SQUARE1X1))

-- local exoriGran = Combat()
-- exoriGran:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriGran:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exoriGran:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exoriGran:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriGran:setArea(createCombatArea(AREA_SQUARE1X1))

-- local exoriMas = Combat()
-- exoriMas:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriMas:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
-- exoriMas:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exoriMas:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriMas:setArea(createCombatArea(AREA_CIRCLE3X3))

-- local exoriHur = Combat()
-- exoriHur:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriHur:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exoriHur:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WHIRLWINDSWORD)
-- exoriHur:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriHur:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

-- local challenge = Combat()
-- challenge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
-- challenge:setArea(createCombatArea(AREA_SQUARE1X1))

-- function onTargetCreature(creature, target)
--     local master = creature:getMaster()
--     if master then
--         if master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer) <= os.time() then
--             return doChallengeCreature(creature, target, 4000)
--         end
--     end
-- end

-- challenge:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

-- function onGetFormulaValuesExori(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 6) + (category * 30) + (damage * 4)
--     local max = (level / 5) + (category * 45) + (damage * 5)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end

-- function onGetFormulaValuesExoriGran(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 6) + (category * 50) + (damage * 5)
--     local max = (level / 4.5) + (category * 60) + (damage * 8)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end

-- function onGetFormulaValuesExoriMas(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end
--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 8) + (category * 25) + (damage * 2)
--     local max = (level / 6) + (category * 30) + (damage * 4)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end


-- local function calculateExoriHurDamage(creature)
--     local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 8) + (category * 25) + (damage * 3)
--     local max = (level / 6) + (category * 35) + (damage * 4)

--     return -min, -max
-- end

-- exori:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExori")
-- exoriGran:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriGran")
-- exoriMas:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriMas")

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
--     local master = creature:getMaster()
--     local pos = creature:getPosition()
--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
--     local class = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Class)
--     if master then
--         local storage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell)
--         local target = creature:getTarget()
--         local minHeal = 100 + (50 * category) + (level / 8)
--         local maxHeal = 125 + (100 * category) + (level / 6)
--         local hpMax = creature:getMaxHealth()
--         local hp = creature:getHealth()
--         local hpPercent = math.floor((hp/hpMax) * 100)
--         local potions = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions)
--         local minMelee = (level / 8) + (category * 5) + (damage * 2)
--         local maxMelee = (level / 4) + (category * 10) + (damage * 5)

--         addEvent(function()
--             if hpPercent >= 60 and hpPercent < 85 then
--                 doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
--                 creature:say('exura ico', TALKTYPE_MONSTER_SAY)
--                 if creature:getCondition(CONDITION_PARALYZE) then
--                     creature:removeCondition(CONDITION_PARALYZE)
--                 end
--             elseif hpPercent < 60 then
--                 if potions > 0 then
--                     local min = 350 + (25 * category) + (class * 25) + (level / 10)
--                     local max = 500 + (25 * category) + (class * 25) + (level / 10)
--                     doTargetCombatHealth(creature, creature, COMBAT_HEALING, min, max, CONST_ME_MAGIC_BLUE)
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Potions, potions - 1)
--                     creature:say('Aaaah...', TALKTYPE_MONSTER_SAY)
--                 else
--                     local chance = math.random(1, 5)
--                     if chance == 1 then
--                         master:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As pocoes do seu mercenario de esgotaram")
--                     end
--                     doTargetCombatHealth(creature, creature, COMBAT_HEALING, minHeal, maxHeal, CONST_ME_MAGIC_BLUE)
--                     creature:say('exura ico', TALKTYPE_MONSTER_SAY)
--                     if creature:getCondition(CONDITION_PARALYZE) then
--                         creature:removeCondition(CONDITION_PARALYZE)
--                     end
--                 end
--             end
--         end, 1000)

--         addEvent(function()
--             if master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer) <= os.time() then
--                 master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.SpellTimer, os.time() + 4)
--                 creature:say('exeta res', TALKTYPE_MONSTER_SAY)
--                 return challenge:execute(creature, var)
--             end
--         end, 200)

--         if target then
--             local tpos = target:getPosition()
--             if math.abs(tpos.x - pos.x) > 1 and math.abs(tpos.y - pos.y) > 1 then
--                 creature:say('exori hur', TALKTYPE_MONSTER_SAY)
--                 local min, max = calculateExoriHurDamage(creature)
--                 doTargetCombatHealth(master, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
--                 creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_WHIRLWINDSWORD)
--                 return true
--             else
--                 addEvent(function()
--                     if target then
--                         if math.abs(tpos.x - pos.x) <= 1 and math.abs(tpos.y - pos.y) <= 1 then
--                             local chanceHit = math.random(1 + (category * 10), 100)
--                             if chanceHit < 30 then
--                                 tpos:sendMagicEffect(CONST_ME_BLOCKHIT)
--                             elseif chanceHit >= 30 and chanceHit < 40 then
--                                 tpos:sendMagicEffect(CONST_ME_POFF)
--                             else
--                                 doTargetCombatHealth(master, target, COMBAT_PHYSICALDAMAGE, -minMelee, -maxMelee, false)
--                             end
--                         end
--                     end
--                 end, 500)

--                 addEvent(function()
--                     if target then
--                         if pos.x == tpos.x or pos.y == tpos.y then
--                             local options = {
--                                 Position(pos.x + 1, pos.y, pos.z),
--                                 Position(pos.x - 1, pos.y, pos.z),
--                                 Position(pos.x, pos.y + 1, pos.z),
--                                 Position(pos.x, pos.y - 1, pos.z)
--                             }
--                             for _, p in ipairs(options) do
--                                 if p.x ~= tpos.x and p.y ~= tpos.y then
--                                     local tile = Tile(p)
--                                     if tile and tile:isWalkable(false, false, false, false, true) then
--                                         creature:move(Position.getDirectionTo(pos, p))
--                                         break
--                                     end
--                                 end
--                             end
--                         end
--                     end
--                 end, 500)

--                 if storage < 1 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 1)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 1 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
--                     creature:say('exori mas', TALKTYPE_MONSTER_SAY)
--                     return exoriMas:execute(creature, var)
--                 elseif storage == 2 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 3)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 3 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 4)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 4 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 5)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 5 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 6)
--                     creature:say('exori mas', TALKTYPE_MONSTER_SAY)
--                     return exoriMas:execute(creature, var)
--                 elseif storage == 6 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 7)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 7 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 8)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 8 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
--                     creature:say('exori hur', TALKTYPE_MONSTER_SAY)
--                     local min, max = calculateExoriHurDamage(creature)
--                     doTargetCombatHealth(master, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
--                     creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_WHIRLWINDSWORD)
--                     return true
--                 end
--             end
--         end
--     end
--     return true
-- end

-- spell:name("melee mercenary")
-- spell:words("###771")
-- spell:needLearn(true)
-- spell:cooldown("2000")
-- spell:blockWalls(true)
-- spell:isAggressive(true)
-- spell:register()


-- local exori = Combat()
-- exori:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exori:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exori:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exori:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

-- exori:setArea(createCombatArea(AREA_SQUARE1X1))

-- local exoriGran = Combat()
-- exoriGran:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriGran:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exoriGran:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exoriGran:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriGran:setArea(createCombatArea(AREA_SQUARE1X1))

-- local exoriMas = Combat()
-- exoriMas:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriMas:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
-- exoriMas:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exoriMas:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriMas:setArea(createCombatArea(AREA_CIRCLE3X3))

-- local exoriHur = Combat()
-- exoriHur:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriHur:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exoriHur:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WHIRLWINDSWORD)
-- exoriHur:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriHur:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

-- local exoriMin = Combat()
-- exoriMin:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
-- exoriMin:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
-- exoriMin:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
-- exoriMin:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
-- exoriMin:setArea(createCombatArea(AREA_WAVE6, AREADIAGONAL_WAVE6))

-- function onGetFormulaValuesExori(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 6) + (category * 30) + (damage * 4)
--     local max = (level / 5) + (category * 45) + (damage * 5)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end

-- function onGetFormulaValuesExoriGran(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 6) + (category * 50) + (damage * 5)
--     local max = (level / 4.5) + (category * 60) + (damage * 8)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end

-- function onGetFormulaValuesExoriMas(creature, target)
-- 	local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end
--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 8) + (category * 25) + (damage * 2)
--     local max = (level / 6) + (category * 30) + (damage * 4)

--     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, false)

-- end


-- local function calculateExoriHurDamage(creature)
--     local master = creature:getMaster()
--     if not master then
--         return 0, 0
--     end

--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)

--     local min = (level / 8) + (category * 25) + (damage * 3)
--     local max = (level / 6) + (category * 35) + (damage * 4)

--     return -min, -max
-- end

-- exori:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExori")
-- exoriGran:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriGran")
-- exoriMas:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValuesExoriMas")

-- local spell = Spell("instant")

-- function spell.onCastSpell(creature, var)
--     local master = creature:getMaster()
--     local pos = creature:getPosition()
--     local level = master:getLevel()
--     local category = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Category)
--     local damage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Damage)
--     if master then
--         local storage = master:getStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell)
--         local target = creature:getTarget()
--         if target then
--             local tpos = target:getPosition()
--             if tpos.x - pos.x > 1 or pos.x - tpos.x > 1 or tpos.y - pos.y > 1 or pos.y - tpos.y > 1 then
--                 creature:say('exori hur', TALKTYPE_MONSTER_SAY)
--                 local min, max = calculateExoriHurDamage(creature)
--                 doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
--                 creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_WHIRLWINDSWORD)
--                 return true
--             else
--                 local minMelee = (level / 8) + (category * 5) + (damage * 2)
--                 local maxMelee = (level / 4) + (category * 10) + (damage * 5)
--                 addEvent(function()
--                     if target then
--                         if tpos.x - pos.x <= 1 or pos.x - tpos.x <= 1 or tpos.y - pos.y <= 1 or pos.y - tpos.y <= 1 then
--                             local chanceHit = math.random(1 + (category * 10), 100)
--                             if chanceHit < 30 then
--                                 tpos:sendMagicEffect(CONST_ME_BLOCKHIT)
--                             elseif chanceHit >= 30 and chanceHit < 40 then
--                                 tpos:sendMagicEffect(CONST_ME_POFF)
--                             else
--                                 doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -minMelee, -maxMelee, false)
--                             end
--                         end
--                         if pos.x == tpos.x or pos.y == tpos.y then
--                             local options = {
--                                 Position(pos.x + 1, pos.y, pos.z),
--                                 Position(pos.x - 1, pos.y, pos.z),
--                                 Position(pos.x, pos.y + 1, pos.z),
--                                 Position(pos.x, pos.y - 1, pos.z)
--                             }
--                             for _, p in ipairs(options) do
--                                 if p.x ~= tpos.x and p.y ~= tpos.y then
--                                     local tile = Tile(p)
--                                     if tile and tile:isWalkable(false, false, false, false, true) then
--                                         creature:move(Position.getDirectionTo(pos, p))
--                                         break
--                                     end
--                                 end
--                             end
--                         end
--                     end
--                 end, 500)
--                 if storage < 1 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 1)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 1 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 2)
--                     creature:say('exori mas', TALKTYPE_MONSTER_SAY)
--                     return exoriMas:execute(creature, var)
--                 elseif storage == 2 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 3)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 3 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 4)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 4 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 5)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 5 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 6)
--                     creature:say('exori mas', TALKTYPE_MONSTER_SAY)
--                     return exoriMas:execute(creature, var)
--                 elseif storage == 6 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 7)
--                     creature:say('exori gran', TALKTYPE_MONSTER_SAY)
--                     return exoriGran:execute(creature, var)
--                 elseif storage == 7 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 8)
--                     creature:say('exori', TALKTYPE_MONSTER_SAY)
--                     return exori:execute(creature, var)
--                 elseif storage == 8 then
--                     master:setStorageValue(Storage.Quest.Crandoria.Mercenarios.Spell, 0)
--                     creature:say('exori hur', TALKTYPE_MONSTER_SAY)
--                     local min, max = calculateExoriHurDamage(creature)
--                     doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, min, max, CONST_ME_HITAREA)
--                     creature:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_WHIRLWINDSWORD)
--                     return true
--                 end
--             end
--         end
--     end
--     return true
-- end

-- spell:name("melee mercenary")
-- spell:words("###771")
-- spell:needLearn(true)
-- spell:cooldown("2000")
-- spell:blockWalls(true)
-- spell:isAggressive(true)
-- spell:register()