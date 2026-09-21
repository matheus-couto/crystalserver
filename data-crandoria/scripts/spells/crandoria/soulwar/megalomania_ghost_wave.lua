local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GHOST_SMOKE)
combat:setArea(createCombatArea(AREA_WAVE12))

function onTargetCreature(creature, target)
    local damageMin, damageMax
    local timer = creature:getStorageValue(Storage.Quest.U12_40.SoulWar.PhantasmalTimer)

    if timer < os.time() then
        damageMin = -1500
        damageMax = -3000
    else
        damageMin = -4000
        damageMax = -6000
    end

    doTargetCombatHealth(creature, target, COMBAT_LIFEDRAIN, damageMin, damageMax, CONST_ME_DRAWBLOOD)
    return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end

spell:name("megalomania ghost wave")
spell:words("###760")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()