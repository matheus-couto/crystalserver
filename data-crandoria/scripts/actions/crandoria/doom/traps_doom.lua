local trapsDoom = MoveEvent()

function trapsDoom.onStepIn(player, item, position, fromPosition)

    if not player then
        return false
    end

    local condition = Condition(CONDITION_BLEEDING)
    condition:setParameter(CONDITION_PARAM_DELAYED, 5)
    condition:addDamage(14, 2000, -100)

    local condition2 = Condition(CONDITION_POISON)
    condition2:setParameter(CONDITION_PARAM_DELAYED, 5)
    condition2:addDamage(14, 2000, -100)

    if item.itemid == 31924 then
        doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -500, -1000, CONST_ME_DRAWBLOOD)
        player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_HIT)
        player:addCondition(condition)
        item:transform(31925)
        player:say('CLICK!', TALKTYPE_MONSTER_SAY)
        addEvent(function()
            item:transform(31924)
        end, 3000)
    elseif item.itemid == 23372 then
        doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -500, -1000, CONST_ME_POISONAREA)
        player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_LIFEDRAIN)
        player:addCondition(condition2)
        item:transform(23370)
        player:say('SCHLIK!', TALKTYPE_MONSTER_SAY)
        addEvent(function()
            item:transform(23372)
        end, 3000)
    elseif item.itemid == 23371 then
        doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -500, -1000, CONST_ME_DRAWBLOOD)
        player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_LIFEDRAIN)
        player:addCondition(condition)
        item:transform(23369)
        player:say('SCHLIK!', TALKTYPE_MONSTER_SAY)
        addEvent(function()
            item:transform(23371)
        end, 3000)
    end
end

trapsDoom:aid(13161)
trapsDoom:register()
