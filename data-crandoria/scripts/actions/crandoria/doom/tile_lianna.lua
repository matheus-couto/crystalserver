local tileLianna = MoveEvent()

function tileLianna.onStepIn(creature, item, position, fromPosition)

    if item.itemid == 9929 then
        if position:isInRange(Position(5043, 5138, 14), Position(5062, 5155, 14)) then
            if creature:getName() == "Lianna the Venomous Shadow" then
                creature:say('The shadows heal my soul!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                item:transform(409)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            else
                if creature:isPlayer() then
                    local condition = Condition(CONDITION_POISON)
                    condition:setParameter(CONDITION_PARAM_DELAYED, 1)
                    condition:addDamage(15, 3000, 500)
                    creature:addCondition(condition)
                end
            end
        elseif position:isInRange(Position(5040, 5158, 14), Position(5060, 5174, 14)) then
            if creature:getName() == "Tharkor the Double Shadow" then
                creature:say('The cold shadows feed me!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                item:transform(29024)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            elseif creature:isPlayer() then
                local look = creature:getOutfit().lookType
                local head = creature:getOutfit().lookHead
                local body = creature:getOutfit().lookBody
                local legs = creature:getOutfit().lookLegs
                local feet = creature:getOutfit().lookFeet
                local condition = Condition(CONDITION_ROOTED)
                condition:setParameter(CONDITION_PARAM_TICKS, 3000)
                creature:addCondition(condition)
                creature:setOutfit({lookType = look, lookHead = 86, lookBody = 86, lookLegs = 86, lookFeet = 86})
                doTargetCombatHealth(0, creature, COMBAT_ICEDAMAGE, -1500, -2500, CONST_ME_ICEATTACK)
                item:transform(29024)
                addEvent(function()
                    if creature then
                        creature:setOutfit({lookType = look, lookHead = head, lookBody = body, lookLegs = legs, lookFeet = feet})
                    end
                end, 3000)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            end
        elseif position:isInRange(Position(5020, 5168, 14), Position(5036, 5183, 14)) then
            if creature:getName() == "Kouda the Burning Shadow" then
                creature:say('I am fortified with the shadows from the flames!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                creature:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
                item:transform(29024)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            elseif creature:isPlayer() then
                local condition = Condition(CONDITION_FIRE)
                condition:setParameter(CONDITION_PARAM_DELAYED, 1)
                condition:addDamage(10, 4000, -100)
                doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -1500, -2500, CONST_ME_FIREATTACK)
                item:transform(5815)
                addEvent(function()
                    local monster = Game.CreateMonster("Burning Spectre", position)
                    if monster then
                        monster:say('Your steps awaken the flames!', TALKTYPE_MONSTER_SAY)
                    end
                end, 200)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            end
        elseif position:isInRange(Position(5000, 5166, 14), Position(5016, 5182, 14)) then
            if creature:getName() == "Banno the Silent Shadow" then
                creature:say('This shadows fulfill my energy!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                creature:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
                item:transform(29024)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            elseif creature:isPlayer() then
                local condition = Condition(CONDITION_PARALYZE)
                condition:setParameter(CONDITION_PARAM_TICKS, 5000)
                condition:setFormula(-0.6, 0, -0.6, 0)
                doTargetCombatHealth(0, creature, COMBAT_ENERGYDAMAGE, -1500, -2500, CONST_ME_PINK_ENERGY_SPARK)
                creature:say('The energy impairs your muscular responses', TALKTYPE_MONSTER_SAY)
                creature:addCondition(condition)
                item:transform(28471)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            end
        elseif position:isInRange(Position(4983, 5149, 14), Position(4999, 5164, 14)) then
            if creature:getName() == "Vargo the Blood Shadow" then
                creature:say('Blood!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                creature:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
                item:transform(32688)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            else
                if creature:isPlayer() then
                    local condition = Condition(CONDITION_BLEEDING)
                    condition:setParameter(CONDITION_PARAM_DELAYED, 10)
                    condition:addDamage(14, 2000, -100)
                    creature:addCondition(condition)
                    doTargetCombatHealth(0, creature, COMBAT_LIFEDRAIN, -1500, -2500, CONST_ME_DRAWBLOOD)
                    creature:say('A blood curse!', TALKTYPE_MONSTER_SAY)
                    item:transform(32688)
                    addEvent(function()
                        item:transform(9929)
                    end, 5000)
                end
            end
        elseif position:isInRange(Position(4994, 5119, 14), Position(5011, 5134, 14)) then
            if creature:getName() == "Iokrah the Moon Shadow" then
                creature:say('The light of the Moon makes my shadows stronger!', TALKTYPE_MONSTER_SAY)
                creature:addHealth(25000)
                creature:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                item:transform(423)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            elseif creature:isPlayer() then
                local condition = Condition(CONDITION_DAZZLED)
                condition:setParameter(CONDITION_PARAM_TICKS, 5000)
                condition:setParameter(CONDITION_PARAM_DELAYED, 1)
                condition:addDamage(math.random(9, 15), 3000, -500)
                creature:addCondition(condition)
                doTargetCombatHealth(0, creature, COMBAT_ENERGYDAMAGE, -1000, -2000, CONST_ME_YELLOW_ENERGY_SPARK)
                creature:say('You feel dazzled by the light on the Moon!', TALKTYPE_MONSTER_SAY)
                item:transform(423)
                addEvent(function()
                    item:transform(9929)
                end, 5000)
            end
        end
    end
    return true

end

tileLianna:aid(13164)
tileLianna:register()
