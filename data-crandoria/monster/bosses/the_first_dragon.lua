local mType = Game.createMonsterType("The First Dragon")
local monster = {}

monster.description = "the first dragon"
monster.experience = 1000000
monster.outfit = {
	lookType = 947,
	lookHead = 94,
	lookBody = 80,
	lookLegs = 101,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "blood"
monster.corpse = 25065
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.bosstiary = {
	bossRaceId = 1368,
	bossRace = RARITY_NEMESIS,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = true,
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

monster.events = {
	"FirstDragonDeath",
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
	{ id = 3035, chance = 100000, minCount = 16, maxCount = 35},
	{ id = 3031, chance = 100000, minCount = 55, maxCount = 100},
	{ id = 9058, chance = 50000, minCount = 1, maxCount = 3},
	{ id = 3057, chance = 22000 },
	{ id = 7643, chance = 42000, minCount = 6, maxCount = 11 },
	{ id = 23373, chance = 42000, minCount = 6, maxCount = 11 },
	{ id = 23374, chance = 42000, minCount = 6, maxCount = 11 },
	{ id = 5877, chance = 32000, minCount = 1, maxCount = 3 },
	{ id = 5920, chance = 32000, minCount = 1, maxCount = 3 },
	{ id = 5948, chance = 32000, minCount = 1, maxCount = 3 },
	{ id = 5882, chance = 32000, minCount = 1, maxCount = 3 },
	{ id = 7430, chance = 22000 },
	{ id = 818, chance = 22000 },
	{ id = 30059, chance = 15000 },
	{ id = 30060, chance = 15000 },
	{ id = 30061, chance = 15000 },
	{ id = 10347, chance = 300 },
	{ id = 8039, chance = 300 },
	{ id = 10326, chance = 100 },
	{ id = 3363, chance = 30 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -3000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -910, maxDamage = -2400, range = 5, radius = 5, effect = CONST_ME_FIREAREA, target = true },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, radius = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1510, maxDamage = -2250, length = 9, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "great fire explosion", interval = 20000, chance = 100, minDamage = -500, maxDamage = -1500, target = false},
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1800, radius = 7, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -550, maxDamage = -1000, radius = 6, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 64,
	armor = 52,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
