local COOLDOWN_INTERVAL = 10 * 1000

local arrLarge = {
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 1, 1, 0, 0, 0, 1, 1 },
	{ 1, 0, 0, 3, 0, 0, 1 },
	{ 1, 1, 0, 0, 0, 1, 1 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}

local arrMedium = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 1, 0, 3, 0, 1, 0 },
	{ 0, 1, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 3, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ROOTS)
combatLarge:setArea(createCombatArea(arrLarge))

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ROOTS)
combatMedium:setArea(createCombatArea(arrMedium))

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ROOTS)
combatSmall:setArea(createCombatArea(arrSmall))

local condition = Condition(CONDITION_ROOTED)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
combatLarge:addCondition(condition)
combatMedium:addCondition(condition)
combatSmall:addCondition(condition)

local spell = Spell("instant")

local combats = {combatSmall, combatMedium, combatLarge }

local lastCastTime = {}

function spell.onCastSpell(creature, var)
    local currentTime = os.time()

    -- Verifica se o cooldown já passou
    -- if lastCastTime[creature:getId()] and (currentTime - lastCastTime[creature:getId()]) < (spell:cooldown() / 1000) then
    --     creature:getPlayer():sendCancelMessage("Ainda está em cooldown.")
    --     return false
    -- end

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

spell:id(341)
spell:name("Stun Pulse")
spell:words("###726")
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_MUD_ATTACK)
spell:level(120)
spell:mana(1200)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:needLearn(true)
spell:register()