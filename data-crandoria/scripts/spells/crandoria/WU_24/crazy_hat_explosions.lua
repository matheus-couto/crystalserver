local arrGiant = {
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0 },
	{ 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 1 },
	{ 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1 },
	{ 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
}

local arrSuper = {
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0 },
	{ 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
	{ 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1 },
	{ 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
}

local arrBigger = {
	{ 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0 },
	{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
	{ 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1 },
	{ 1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1 },
	{ 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
	{ 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0 },
}


local combatGiant = Combat()
combatGiant:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatGiant:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combatGiant:setArea(createCombatArea(arrGiant))

local combatSuper = Combat()
combatGiant:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatGiant:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combatSuper:setArea(createCombatArea(arrSuper))

local combatBigger = Combat()
combatGiant:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combatGiant:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_AGONY)
combatBigger:setArea(createCombatArea(arrBigger))


local spell = Spell("instant")

local combats = { combatBigger, combatSuper, combatGiant }

function spell.onCastSpell(creature, var)
    local randomNumber = math.random(1, #combats)  -- Gera um número aleatório entre 1 e o número total de combates
    return combats[randomNumber]:execute(creature, var)
end

spell:name("crazy hat explosions")
spell:words("###731")
spell:needLearn(true)
spell:isSelfTarget(true)
spell:register()