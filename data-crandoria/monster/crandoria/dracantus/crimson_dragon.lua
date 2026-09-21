local mType = Game.createMonsterType("Crimson Dragon")
local monster = {}

monster.description = "a crimson dragon"
monster.experience = 3800
monster.outfit = {
	lookType = 947,
	lookHead = 38,
	lookBody = 132,
	lookLegs = 56,
	lookFeet = 95,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1382
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Crimson Dragon - Dracantus.",
}

monster.events = {
	"TheFirstDragonDragonTaskDeath",
}

monster.health = 4150
monster.maxHealth = 4150
monster.race = "blood"
monster.corpse = 25188
monster.speed = 145
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
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
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
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
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
	chance = 5,
	{ text = "SWALLOW MY FLAMES!", yell = false },
	{ text = "ZCHHHHHHH", yell = true },
}

monster.loot = {
	-- -- { id = 3250, chance = 75, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 1 },
	{ name = "gold coin", chance = 95300, maxCount = 237 },
	{ id = 3035, chance = 44000, maxCount = 4 },
	{ id = 238, chance = 3400, maxCount = 2 },
	{ name = "dragon ham", chance = 79790, maxCount = 2 },
	{ name = "green mushroom", chance = 12030 },
	{ id = 2842, chance = 9590 }, -- gemmed book
	{ name = "royal spear", chance = 9380, maxCount = 5 },
	{ name = "power bolt", chance = 5920, maxCount = 14 },
	{ name = "small ruby", chance = 5590, maxCount = 4 },
	{ id = 3051, chance = 4550 }, -- energy ring
	{ name = "golden mug", chance = 3310 },
	{ name = "red dragon scale", chance = 2140 },
	{ name = "red dragon leather", chance = 1350 },
	{ name = "great health potion", chance = 2800, maxCount = 2 },
	{ name = "life crystal", chance = 1000 },
	{ name = "tower shield", chance = 750 },
	{ name = "fire axe", chance = 3400 },
	{ name = "royal helmet", chance = 450 },
	{ name = "dragon slayer", chance = 800 },
	{ name = "zaoan robe", chance = 1550 },
	{ name = "magma monocle", chance = 1000 },
	{ name = "magma coat", chance = 1000 },
	{ name = "magma boots", chance = 1000 },
	{ name = "magma legs", chance = 1000 },
	{ id = 24938, chance = 14000},
	{ id = 24937, chance = 14000},
	{ id = 30059, chance = 100},
	{ id = 3369, chance = 6500 }
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -500, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "firefield", interval = 2000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -500, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 65,
	mitigation = 1.29,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 100, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
