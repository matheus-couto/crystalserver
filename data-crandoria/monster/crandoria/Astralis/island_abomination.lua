local mType = Game.createMonsterType("The Island Abomination")
local monster = {}

monster.description = "The Island Abomination"
monster.experience = 800000
monster.outfit = {
	lookType = 1393,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "blood"
monster.corpse = 36612
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 10,
	health = 30,
	random = 10,
	damage = 50,
}

monster.strategiesTarget2 = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3035, chance = 66666, maxCount = 35 },
	{ id = 3035, chance = 33333, maxCount = 22 },
	{ id = 3043, chance = 100000, minCount = 5, maxCount = 13 },
	{ id = 7643, chance = 88100, maxCount = 6 },
	{ id = 238, chance = 84100, maxCount = 8 },
	{ id = 23373, chance = 84100, maxCount = 14 },
	{ id = 23375, chance = 84100, maxCount = 12 },
	{ id = 30059, chance = 55000, maxCount = 1 },
	{ id = 30060, chance = 55000, maxCount = 1 },
	{ id = 30061, chance = 55000, maxCount = 1 },
	{ id = 8057, chance = 450},
	{ id = 8054, chance = 450},
	{ id = 22758, chance = 450},
	{ id = 12811, chance = 80, maxCount = 1 },
	{ id = 11682, chance = 50000, maxCount = 3 },
	{ id = 637, chance = 15000 },
	{ id = 39037, chance = 50000, maxCount = 2 },
	{ id = 4061, chance = 1000, maxCount = 1 },
	{ id = 32002, chance = 25000, maxCount = 1 },
	{ id = 11683, chance = 100000, maxCount = 20 },
	{ id = 11460, chance = 75000, maxCount = 10 },
	{ id = 36938, chance = 300, maxCount = 1 },
	{ id = 22724, chance = 1000000, minCount = 1, maxCount = 3 },
	{id = 22721, chance = 100000, minCount = 1, maxCount = 3},
	{id = 12669, chance = 150 },
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Explosive Vermin", chance = 100, interval = 30000, count = 1 },
		{ name = "Explosive Vermin", chance = 100, interval = 30000, count = 1 },
		{ name = "Explosive Vermin", chance = 100, interval = 30000, count = 1 },
		{ name = "Explosive Vermin", chance = 100, interval = 30000, count = 1 },
	},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2850, effect = CONST_ME_DRAWBLOOD, condition = { type = CONDITION_POISON, totalDamage = 100, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -1550, maxDamage = -3200, range = 8, radius = 5, effect = CONST_ME_HITBYPOISON, target = false },
	{ name = "death explosion", interval = 6000, chance = 100, minDamage = -1800, maxDamage = -3300, range = 8, target = false },
	{name ="great death ring", interval = 2000, chance = 15, minDamage = -1200, maxDamage = -3200, range = 8, target = false, effect = CONST_ME_INSECTS},
	{ name = "death chain", interval = 6000, chance = 100, minDamage = -1500, maxDamage = -4500, range = 8, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 83,
	mitigation = 0.63,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 4000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true },
}

mType:register(monster)
