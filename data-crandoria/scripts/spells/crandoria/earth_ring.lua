local combatMaliz = Combat()
combatMaliz:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatMaliz:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)

local area = createCombatArea(AREA_ROOT_OPRESSOR)
combatMaliz:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("earth ring")
spell:words("###803")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()