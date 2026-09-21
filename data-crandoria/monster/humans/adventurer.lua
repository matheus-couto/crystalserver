local mType = Game.createMonsterType("Adventurer")
local monster = {}

monster.description = "an adventurer"
monster.experience = 3000
monster.outfit = {
	lookType = 129,
	lookHead = 93,
	lookBody = 15,
	lookLegs = 72,
	lookFeet = 80,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 922
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Dracantus.",
}

monster.health = 2850
monster.maxHealth = 2850
monster.race = "blood"
monster.corpse = 18034
monster.speed = 120
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 65,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	isPreyExclusive = true,
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
	{ id = 3031, chance = 88000, maxCount = 92},
	{ id = 3035, chance = 23000, maxCount = 6},
	{ id = 239, chance = 15000, maxCount = 2},
	{ id = 3357, chance = 11500},
	{ id = 3351, chance = 12500},
	{ id = 3032, chance = 6500, maxCount = 4},
	{ id = 3409, chance = 31200},
	{ id = 2920, chance = 55100},
	{ id = 3054, chance = 1000},
	{ id = 3283, chance = 15000},
	{ id = 9692, chance = 18000},
	{ id = 11492, chance = 1500},
	{ id = 3554, chance = 800},
	{ id = 3372, chance = 19200},
	{ id = 3371, chance = 900},
	{ id = 3370, chance = 800},
	{ id = 3318, chance = 7200},
	{ name = "ham", chance = 15000 },
}

monster.defenses = {
	defense = 35,
	armor = 28,
	mitigation = 0.28,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 50 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
