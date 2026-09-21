local mType = Game.createMonsterType("Verdant Dragon")
local monster = {}

monster.description = "a verdant dragon"
monster.experience = 3600
monster.outfit = {
	lookType = 947,
	lookHead = 57,
	lookBody = 120,
	lookLegs = 26,
	lookFeet = 95,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1383
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Verdant Dragon - Dracantus.",
}

monster.events = {
	"TheFirstDragonDragonTaskDeath",
}

monster.health = 4200
monster.maxHealth = 4200
monster.race = "undead"
monster.corpse = 25187
monster.speed = 106
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 250,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "YOU WILL FREEZE!", yell = true },
	{ text = "ZCHHHHH!", yell = true },
	{ text = "I am so cool.", yell = false },
	{ text = "Chill out!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "gold coin", chance = 99110, maxCount = 207 },
	{ id = 3035, chance = 63000, maxCount = 5},
	{ id = 5922, chance = 200, maxCount = 1},
	{ id = 3032, chance = 4200, maxCount = 4},
	{ id = 5877, chance = 1200, maxCount = 2},
	{ id = 5920, chance = 800, maxCount = 2},
	{ id = 21158, chance = 3600, maxCount = 2},
	{ id = 30060, chance = 100},
	{ id = 3386, chance = 500},
	{ id = 8063, chance = 1400 },
	{ id = 24938, chance = 14000},
	{ id = 24937, chance = 14000},
	{ id = 3302, chance = 6400 },
	{ id = 3416, chance = 3500},
	{ id = 10305, chance = 11480 },
	{ name = "terra legs", chance = 1000 },
	{ name = "terra boots", chance = 1000 },
	{ name = "terra mantle", chance = 1000 },
	{ name = "terra hood", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -175, maxDamage = -350, length = 8, spread = 3, effect = CONST_ME_POFF, target = false },
	{ name = "great poison ring", interval = 2000, chance = 10, minDamage = -200, maxDamage = -400, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -425, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_BIGPLANTS, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAR_EARTHDAMAGE, minDamage = -125, maxDamage = -350, radius = 5, effect = CONST_ME_SMALLPLANTS, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -600, radius = 4, effect = CONST_ME_ICEAREA, target = true, duration = 12000 },
}

monster.defenses = {
	defense = 45,
	armor = 38,
	mitigation = 1.07,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 290, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
