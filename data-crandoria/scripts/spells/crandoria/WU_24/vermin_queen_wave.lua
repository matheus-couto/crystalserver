
arr1 = {
	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

arr2 = {
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1 },
	{ 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

arr3 = {
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

arr4 = {
	{ 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(15, 3000, 1000)
condition:addDamage(10, 3000, 900)
condition:addDamage(10, 3000, 800)


local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat1:setArea(createCombatArea(arr1))
combat1:addCondition(condition)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat2:setArea(createCombatArea(arr2))
combat2:addCondition(condition)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat3:setArea(createCombatArea(arr3))
combat3:addCondition(condition)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat4:setArea(createCombatArea(arr4))
combat4:addCondition(condition)


local spell = Spell("instant")

local combats = {combat1, combat2, combat3, combat4}

function spell.onCastSpell(creature, var)
    local randomNumber = math.random(1, #combats)  -- Gera um número aleatório entre 1 e o número total de combates
    return combats[randomNumber]:execute(creature, var)
end

spell:name("vermin queen wave")
spell:words("###727")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
