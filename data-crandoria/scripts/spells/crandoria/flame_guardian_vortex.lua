local combatGiant = Combat()
combatGiant:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatGiant:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatSuper = Combat()
combatSuper:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatSuper:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatBigger = Combat()
combatBigger:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatBigger:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatLarge = Combat()
combatLarge:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatLarge:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatMedium = Combat()
combatMedium:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatMedium:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatSmaller = Combat()
combatSmaller:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatSmaller:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local combatTiny = Combat()
combatTiny:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatTiny:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local arrGiant = {
	{ 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0 },
}

local arrSuper = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrBigger = {
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 1, 0, 0, 3, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
}

local arrLarge = {
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
}

local arrMedium = {
	{ 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0 },
}

local arrSmall = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local arrSmaller = {
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 1, 0, 0, 3, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
}

local arrTiny = {
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
}

combatGiant:setArea(createCombatArea(arrGiant))
combatSuper:setArea(createCombatArea(arrSuper))
combatBigger:setArea(createCombatArea(arrBigger))
combatLarge:setArea(createCombatArea(arrLarge))
combatMedium:setArea(createCombatArea(arrMedium))
combatSmall:setArea(createCombatArea(arrSmall))
combatSmaller:setArea(createCombatArea(arrSmaller))
combatTiny:setArea(createCombatArea(arrTiny))

local spell = Spell("instant")

local combats = {combatTiny, combatSmaller, combatSmall, combatMedium, combatLarge, combatBigger, combatSuper, combatGiant }

function spell.onCastSpell(creature, var)
    local currentIndex = 1  -- Reinicializa o índice ao lançar a spell

    local function executeCombat()
        if currentIndex <= #combats then
            local currentCombat = combats[currentIndex]
            currentCombat:execute(creature, var)
            currentIndex = currentIndex + 1
            addEvent(executeCombat, 300)  -- Ajuste conforme necessário
        end
    end

    executeCombat()
end

spell:name("flame guardian vortex")
spell:words("###714")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()