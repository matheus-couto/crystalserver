local mType = Game.createMonsterType("Spitter Elite")
local monster = {}

monster.description = "a spitter elite"
monster.experience = 2100
monster.outfit = {
	lookType = 461,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 798
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "Spitter Elite - Trivallis.",
}

monster.health = 2200
monster.maxHealth = 2200
monster.race = "venom"
monster.corpse = 13979
monster.speed = 150
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
	nearest = 100,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 40,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Spotz!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 65000, maxCount = 4 },
	{ name = "small amethyst", chance = 9500, maxCount = 2 },
	{ name = "green gem", chance = 410 },
	{ id = 3053, chance = 2800 }, -- time ring
	{ name = "platinum amulet", chance = 300 },
	{ name = "crusader helmet", chance = 300 },
	{ name = "brown mushroom", chance = 8500, maxCount = 3 },
	{ name = "mastermind potion", chance = 450 },
	{ name = "crystal sword", chance = 4000 },
	{ id = 238, chance = 12000 },
	{ name = "great health potion", chance = 10000 },
	{ name = "spitter nose", chance = 23000 },
	{ name = "compound eye", chance = 20000 },
	{ name = "calopteryx cape", chance = 340 },
	{ name = "grasshopper legs", chance = 220 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -220, condition = { type = CONDITION_POISON, totalDamage = 240, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -125, maxDamage = -220, range = 7, radius = 3, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, shootEffect = CONST_ANI_POISON, target = true, duration = 15000 },
}

monster.defenses = {
	defense = 30,
	armor = 55,
	mitigation = 1.60,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 400, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -11 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
