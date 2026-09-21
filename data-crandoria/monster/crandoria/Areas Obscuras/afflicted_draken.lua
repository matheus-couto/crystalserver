local mType = Game.createMonsterType("Afflicted Draken")
local monster = {}

monster.description = "an afflicted draken"
monster.experience = 20800
monster.outfit = {
	lookType = 357,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 20250
monster.maxHealth = 20250
monster.race = "venom"
monster.corpse = 11667
monster.speed = 200
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 70,
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Death Blob", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Uhhhg!", yell = false },
	{ text = "Gll", yell = false },
	{ text = "Hmmnn!", yell = false },
	{ text = "Aaag!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "gold coin", chance = 47000, maxCount = 98 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ name = "platinum coin", chance = 50590, maxCount = 8 },
	{ name = "meat", chance = 50450, maxCount = 4 },
	{ id = 238, chance = 9950, maxCount = 3 },
	{ name = "terra hood", chance = 8730 },
	{ name = "great spirit potion", chance = 4905, maxCount = 3 },
	{ name = "ultimate health potion", chance = 9400, maxCount = 3 },
	{ name = "wand of voodoo", chance = 1020 },
	{ name = "small topaz", chance = 2900, maxCount = 4 },
	{ name = "zaoan armor", chance = 470 },
	{ name = "zaoan helmet", chance = 560 },
	{ name = "zaoan legs", chance = 780 },
	{ name = "eye of corruption", chance = 12110 },
	{ name = "tail of corruption", chance = 6240 },
	{ name = "scale of corruption", chance = 10940 },
	{ name = "shield of corruption", chance = 10 },
	{ name = "draken boots", chance = 540 },
	{ name = "snake god's wristguard", chance = 10 },
	{ name = "bamboo leaves", chance = 360 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -520 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -310, maxDamage = -630, length = 4, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "draken abomination curse", interval = 2000, chance = 10, range = 5, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -400, length = 4, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "drunk", interval = 2000, chance = 15, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false, duration = 9000 },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, range = 7, radius = 3, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 30,
	armor = 45,
	mitigation = 1.60,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 650, maxDamage = 700, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
