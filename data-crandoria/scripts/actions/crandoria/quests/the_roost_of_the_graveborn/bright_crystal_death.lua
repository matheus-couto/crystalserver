local brightCrystalDeath = CreatureEvent("brightCrystalDeath")

local area = {
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}

local visualCombat = Combat()
visualCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
visualCombat:setArea(createCombatArea(area))

local damageMana = 5000

local damageCombat = Combat()
damageCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
damageCombat:setArea(createCombatArea(area))
damageCombat:setFormula(COMBAT_FORMULA_DAMAGE, -damageMana, 0, -damageMana, 0)

local function executeAreaEffect(monsterId)
	local monster = Creature(monsterId)
	if not monster then
		return
	end

	local variant = Variant(monster:getPosition())
	visualCombat:execute(monster, variant)
	damageCombat:execute(monster, variant)

	monster:remove()
end

function brightCrystalDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local player = mostDamageKiller or killer
	if not player or not player:isPlayer() then
		return true
	end

	addEvent(executeAreaEffect, 200, creature:getId())

	return true
end

brightCrystalDeath:register()