local mType = Game.createMonsterType("Agressive Makara")
local monster = {}

monster.description = "an agressive makara"
monster.experience = 12200
monster.outfit = {
	lookType = 1565,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 11000
monster.maxHealth = 11000
monster.race = "blood"
monster.corpse = 39366
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 10,
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
	{ text = "waddle waddle", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3043, chance = 1000, maxCount = 1 },
	{ name = "platinum coin", chance = 60000, maxCount = 23 },
	{ name = "makara tongue", chance = 10160 },
	{ name = "makara fin", chance = 7420 },
	{ name = "meat", chance = 7030, maxCount = 2 },
	{ name = "cyan crystal fragment", chance = 5300 },
	{ name = "yellow gem", chance = 5100 },
	{ name = "rainbow quartz", chance = 3320, maxCount = 2 },
	{ name = "small diamond", chance = 8340, maxCount = 4 },
	{ name = "blue gem", chance = 3150 },
	{ name = "green crystal shard", chance = 1950 },
	{ name = "green crystal fragment", chance = 1170 },
	{ name = "sea horse figurine", chance = 200 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -145, maxDamage = -590, target = true }, -- basic_attack
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -305, maxDamage = -590, radius = 3, effect = CONST_ME_STONES, shootEffect = CONST_ANI_EARTH, target = true }, -- stone_shower_ball
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -305, maxDamage = -590, radius = 5, effect = CONST_ME_STONES, shootEffect = CONST_ANI_EARTH, target = true }, -- great_stone_shower_ball
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -360, maxDamage = -590, range = 7, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK, target = true }, -- ice_strike
	{ name = "makarawatersplash", interval = 2000, chance = 25, minDamage = -380, maxDamage = -555, target = false }, -- short_water_cone-wave
}

monster.defenses = {
	defense = 74,
	armor = 74,
	mitigation = 1.99,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
