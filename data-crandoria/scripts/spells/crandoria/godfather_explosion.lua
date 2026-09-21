local arrSuper = {
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 0, 0, 1, 1, 0 },
	{ 1, 1, 0, 0, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 3, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 0, 0, 1, 1 },
	{ 0, 1, 1, 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
}

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

local combatSuper = Combat()
combatSuper:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatSuper:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AVATAR_APPEAR)
combatSuper:setArea(createCombatArea(arrSuper))

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AVATAR_APPEAR)
combatLarge:setArea(createCombatArea(arrLarge))

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AVATAR_APPEAR)
combatMedium:setArea(createCombatArea(arrMedium))

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AVATAR_APPEAR)
combatSmall:setArea(createCombatArea(arrSmall))


local spell = Spell("instant")

local combats = {combatSmall, combatMedium, combatLarge, combatSuper }

-- combatSuper:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE)
-- combatLarge:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE)
-- combatMedium:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE)
-- combatSmall:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE)

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


spell:name("godfather explosion")
spell:words("###723")
spell:isSelfTarget(true)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()