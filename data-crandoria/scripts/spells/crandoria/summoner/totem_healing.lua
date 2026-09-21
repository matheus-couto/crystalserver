local combat = Combat()
combat:setArea(createCombatArea(AREA_CIRCLE5X5))
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)

    local master = creature:getMaster()
    if not master then
        return false
    end

    local position = creature:getPosition()
    local spectators = Game.getSpectators(position, false, false, 5, 5, 5, 5)

    local summons = {}

    for _, target in ipairs(spectators) do
        if target:isMonster() and target ~= creature then
            if target:getMaster() == master then
                table.insert(summons, target)
            end
        end
    end

    if #summons == 0 then
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- EFEITO VISUAL NA ÁREA INTEIRA
    combat:execute(creature, variant)

    -- Fórmula
    local magLevel = master:getMagicLevel()
    local totalHeal = math.random(magLevel * 6, magLevel * 8)
    local healPerSummon = math.floor(totalHeal / #summons)

    if healPerSummon <= 0 then
        return false
    end

    for _, summon in ipairs(summons) do
        summon:addHealth(healPerSummon)
    end

    -- Totem perde vida
    local currentHealth = creature:getHealth()

    doTargetCombatHealth(0, creature, COMBAT_AGONYDAMAGE, -250, -250, CONST_ME_MAGIC_BLUE)

    return true
end

spell:name("Totem Healing")
spell:words("###770")
spell:blockWalls(true)
spell:needLearn(false)
spell:register()