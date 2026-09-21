local unsummonSpell = Spell("instant")

function unsummonSpell.onCastSpell(player, variant)
    local summons = player:getSummons()

    if #summons == 0 then
        player:sendCancelMessage("You have no summons to unsummon.")
        return false
    end

    local targetSummon = nil
    local minHealth = 50000  -- Inicializado com um valor grande para garantir que qualquer summon tenha menos vida

    for _, summon in ipairs(summons) do
        local currentHealth = summon:getHealth()
        if currentHealth < minHealth and summon:getName() ~= "Anti Afk Orb Anti Noob" then
            minHealth = currentHealth
            targetSummon = summon
        end
    end

    local position = targetSummon:getPosition()

    if targetSummon then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You unsummon " .. targetSummon:getName() .. ".")
        targetSummon:remove()
        position:sendMagicEffect(CONST_ME_MAGIC_RED)
        return true
    else
        player:sendCancelMessage("Unable to determine the summon with the lowest health.")
        return false
    end
end

unsummonSpell:group("support")
unsummonSpell:id(336)
unsummonSpell:name("Unsummon Creature")
unsummonSpell:words("onora ina")
unsummonSpell:vocation("summonar;true", "ancient summoner")
unsummonSpell:castSound(SOUND_EFFECT_TYPE_SPELL_CREATURE_ILLUSION)
unsummonSpell:level(11)
unsummonSpell:isAggressive(false)
unsummonSpell:needLearn(false)
unsummonSpell:cooldown(5 * 1000)
unsummonSpell:groupCooldown(2 * 1000)
unsummonSpell:register()
