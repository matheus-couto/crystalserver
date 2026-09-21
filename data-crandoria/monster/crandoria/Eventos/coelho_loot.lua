local mType = Game.createMonsterType("Coelho Loot")
local monster = {}

monster.name = "Coelho da Pascoa"
monster.description = "a coelho da pascoa"
monster.experience = 250000
monster.outfit = {
	lookType = 1157,
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
monster.corpse = 7338
monster.speed = 275
monster.manaCost = 300

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0,
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
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 1000000,
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
	interval = 30000,
	chance = 15,
}

monster.loot = {
	-- { id = 3250, chance = 100000, maxCount = 5 },
	{ name = "giant sapphire", chance = 50000, maxCount = 1 },
	{ name = "giant ruby", chance = 40000, maxCount = 1 },
	{ name = "giant emerald", chance = 40000, maxCount = 1 },
	{ id = 22739, chance = 1500, maxCount = 1 },
	{ id = 36827, chance = 800, maxCount = 1 },
	{ id = 31633, chance = 500, maxCount = 1 },
	{ id = 26186, chance = 50000, maxCount = 2 },
	{ id = 39136, chance = 25000, maxCount = 1 },
	{ id = 9099, chance = 100000, maxCount = 1 },
	{ id = 3366, chance = 10000, maxCount = 1 },
	{ id = 3386, chance = 20000, maxCount = 1 },
	{ id = 3364, chance = 10000, maxCount = 1 },
	{ id = 3388, chance = 200, maxCount = 1 },
	{ id = 3389, chance = 150, maxCount = 1 },
	{ id = 3399, chance = 200, maxCount = 1 },
	{ id = 3387, chance = 2000, maxCount = 1 },
	{ id = 3079, chance = 50000, maxCount = 1 },
	{ id = 3392, chance = 50000, maxCount = 1 },
	{ id = 8102, chance = 1000, maxCount = 1 },
	{ id = 3414, chance = 4500, maxCount = 1 },
	{ id = 3554, chance = 6000, maxCount = 1 },
	{ id = 3057, chance = 20000, maxCount = 1 },
}

monster.attacks = {
}

monster.defenses = {
	defense = 10,
	armor = 20,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
