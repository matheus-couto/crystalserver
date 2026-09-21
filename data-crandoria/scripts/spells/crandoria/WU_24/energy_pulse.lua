local COOLDOWN_INTERVAL = 10 * 1000

local arrLarge = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrMedium = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
	{ 0, 0, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 0, 1, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
	{ 0, 0, 1, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combatLarge:setArea(createCombatArea(arrLarge))

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combatMedium:setArea(createCombatArea(arrMedium))

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combatSmall:setArea(createCombatArea(arrSmall))

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(20, 3000, -250)
combatSmall:addCondition(condition)
combatMedium:addCondition(condition)
combatLarge:addCondition(condition)

local spell = Spell("instant")

local combats = {combatSmall, combatLarge }

local lastCastTime = {}

function spell.onCastSpell(creature, var)
    local currentTime = os.time()

    local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

    local function executeCombat()
        if currentIndex <= #combats then
            local currentCombat = combats[currentIndex]
            currentCombat:execute(creature, var)
            currentIndex = currentIndex + 1
            addEvent(executeCombat, 250)  -- Ajuste conforme necessário
        else
            -- Atualiza o tempo de lançamento da última spell
            lastCastTime[creature:getId()] = currentTime
        end
    end

    executeCombat()
    return true
end

spell:id(342)
spell:name("Arcane Pulse")
spell:words("###729")
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_MUD_ATTACK)
spell:mana(1200)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:needLearn(true)
spell:register()