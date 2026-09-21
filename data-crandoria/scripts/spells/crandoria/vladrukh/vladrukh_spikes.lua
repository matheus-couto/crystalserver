local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SPIKES)

local area = createCombatArea(AREA_VLADRUKH)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("vladrukh spikes")
spell:words("###775")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()