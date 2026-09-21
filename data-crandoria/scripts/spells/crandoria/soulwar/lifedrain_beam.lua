local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)

local area = createCombatArea(AREA_BEAM11)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combat:execute(creature, var)
	return true
end

spell:name("lifedrain beam")
spell:words("###744")
spell:blockWalls(true)
spell:needLearn(true)
spell:register()