local mType = Game.createMonsterType("Magma Minion")
local monster = {}

-- monster.name = "Burning Book"
monster.description = "a magma minion"
monster.experience = 0
monster.outfit = {
	lookType = 1733,
}

monster.health = 10000
monster.maxHealth = 18000
monster.race = "ink"
monster.corpse = 10000
monster.speed = 150
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -700 },
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -780, range = 7, shootEffect = CONST_ANI_FLAMMINGARROW, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 1500, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -900, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -850, length = 5, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -775, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
}

monster.defenses = {
	defense = 33,
	armor = 82,
	mitigation = 2.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

local area = {
	{ 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 3, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0 },
}

local visualCombat = Combat()
visualCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
visualCombat:setArea(createCombatArea(area))

local damageCombat = Combat()
damageCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
damageCombat:setArea(createCombatArea(area))

local function executeAreaEffect(monsterId)
	local monster = Creature(monsterId)
	if not monster then
		return
	end

	local variant = Variant(monster:getPosition())
	visualCombat:execute(monster, variant)

	local targets = Game.getSpectators(monster:getPosition(), false, false, 3, 3, 3, 3)
	for _, target in ipairs(targets) do
		if target:isPlayer() or target:isMonster() then
			doTargetCombatHealth(monster, target, COMBAT_FIREDAMAGE, -1500, -2000, CONST_ME_FIREAREA)
		end
	end

	monster:remove()
end

mType.onThink = function(monster, variant, interval)
	local monsterPos = monster:getPosition()
	local playersNearby = false
	local nearbyCreatures = Game.getSpectators(monsterPos, false, true, 1, 1, 1, 1)

	for _, creature in ipairs(nearbyCreatures) do
		if creature:isPlayer() then
			playersNearby = true
			break
		end
	end

	if playersNearby then
		monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		addEvent(executeAreaEffect, 1000, monster:getId())
	end
	addEvent(executeAreaEffect, 18000, monster:getId())

	local spectators = Game.getSpectators(monsterPos, false, false, 15, 15, 15, 15)
	local bossAlive = false

	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			local name = creature:getName():lower()
			if name == "flamanzog" then
				bossAlive = true
				break
			end
		end
	end

	if not bossAlive then
		monster:remove()
	end
end

mType:register(monster)

mType:register(monster)
