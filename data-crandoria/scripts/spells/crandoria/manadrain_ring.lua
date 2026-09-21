local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GHOST_SMOKE)


local arr = {
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 3, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end


spell:name("manadrain ring")
spell:words("###724")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()