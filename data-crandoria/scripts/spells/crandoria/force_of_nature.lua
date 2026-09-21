local combat = Combat()
combat:setParameter(createCombatArea(AREA_CIRCLE5X5))
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local baseMana

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local position = creature:getPosition()
    local party = creature:getParty()
    local player = creature:getPlayer()

    local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)

    if rep < 500 then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa ser Honrado para usar essa spell.")
        return false
    end

    if not party then
        creature:sendCancelMessage("Nao ha membros de Party.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- Lista apenas membros (NAO inclui o caster)
    local members = party:getMembers()

    if not members or #members == 0 then
        creature:sendCancelMessage("Nao ha membros de Party.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- Filtra membros no alcance
    local affected = {}
    for _, member in ipairs(members) do
        if member:getPosition():getDistance(position) <= 36 then
            table.insert(affected, member)
        end
    end

    if #affected == 0 then
        creature:sendCancelMessage("Nao ha membros de Party no alcance.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- METADE da mana atual
    local currentMana = creature:getMana()
    local manaToUse = math.floor(currentMana / 2)

    if manaToUse <= 0 then
        creature:sendCancelMessage("Mana insuficiente.")
        return false
    end

    -- Divide igualmente
    local healPerMember = math.floor(manaToUse / #affected)

    if healPerMember <= 0 then
        creature:sendCancelMessage("Mana insuficiente para dividir.")
        return false
    end

    -- Remove mana do caster
    creature:addMana(-manaToUse)
    creature:addManaSpent(manaToUse)

    -- Aplica cura
    for _, member in ipairs(affected) do
        member:addHealth(healPerMember)
        member:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end

    position:sendMagicEffect(CONST_ME_MAGIC_BLUE)

    return true
end

spell:name("Force of Nature")
spell:words("exura sio honor")
spell:group("support")
-- spell:vocation("druid;true", "elder druid;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_PARTY)
spell:id(350)
spell:cooldown(60 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(200)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
