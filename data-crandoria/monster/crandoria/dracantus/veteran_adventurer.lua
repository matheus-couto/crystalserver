local mType = Game.createMonsterType("Veteran Adventurer")
local monster = {}

monster.description = "a veteran adventurer"
monster.experience = 3500
monster.outfit = {
	lookType = 129,
	lookHead = 92,
	lookBody = 114,
	lookLegs = 92,
	lookFeet = 82,
	lookAddons = 0,
	lookMount = 505,
}

monster.raceId = 923
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Veteran Adventurer - Dracantus.",
}

monster.health = 3400
monster.maxHealth = 3400
monster.race = "blood"
monster.corpse = 18034
monster.speed = 140
monster.manaCost = 0

monster.events = {
	"adventurerKill",
}

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
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
	{ id = 3031, chance = 88000, maxCount = 92},
	{ id = 3035, chance = 33000, maxCount = 7},
	{ id = 239, chance = 18000, maxCount = 2},
	{ id = 3357, chance = 14500},
	{ id = 3351, chance = 16500},
	{ id = 3032, chance = 9500, maxCount = 4},
	{ id = 3409, chance = 35200},
	{ id = 2920, chance = 44100},
	{ id = 3054, chance = 3500},
	{ id = 3283, chance = 25000},
	{ id = 9692, chance = 23000},
	{ id = 11492, chance = 3500},
	{ id = 3554, chance = 1200},
	{ id = 3372, chance = 22200},
	{ id = 3371, chance = 1100},
	{ id = 3370, chance = 900},
	{ id = 3392, chance = 200},
	{ name = "ham", chance = 15000, maxCount = 2 },
	{ id = 3318, chance = 9200},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -250, range = 5, shootEffect = CONST_ANI_THROWINGKNIFE, effect = CONST_ME_HITAREA, target = false},
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -250, range = 5, radius = 3, effect = CONST_ME_FIREAREA, target = false},
}

monster.defenses = {
	defense = 35,
	armor = 28,
	mitigation = 0.35,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
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
