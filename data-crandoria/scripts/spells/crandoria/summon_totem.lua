local spell = Spell("instant")

function spell.onCastSpell(player, variant)
    local position = player:getPosition()
    local summonName = "Healing Totem"

    local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    if rep < 500 then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa ser Honrado para usar essa spell.")
        return false
    end

    local summon = Game.createMonster(summonName, position, true, false, player)
    if not summon then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    return true
end

spell:group("support")
spell:id(351)
spell:name("Summon Totem")
spell:words("onora res honor")
-- spell:vocation("summonar;true", "ancient summoner")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CREATURE_ILLUSION)
spell:level(200)
spell:mana(500)
spell:isAggressive(false)
spell:needLearn(false)
spell:cooldown(300 * 1000)
spell:groupCooldown(2 * 1000)
spell:register()
