local mType = Game.createMonsterType("Kitana")
local monster = {}

monster.description = "Kitana"
monster.experience = 200000
monster.outfit = {
	lookType = 1068,
	lookHead = 107,
	lookBody = 1,
	lookLegs = 88,
	lookFeet = 1,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 28667
monster.speed = 200
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
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 3,
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
	{ name = "crystal coin", chance = 27380, maxCount = 4 },
	{ id = 3035, chance = 100000, maxCount = 88 }, -- platinum coin
	{ id = 6558, chance = 19790 }, -- flask of demonic blood
	{ id = 3029, chance = 100000, maxCount = 35 }, -- small sapphire
	{ id = 7643, chance = 55000, maxCount = 24 },
	{ id = 23373, chance = 55000, maxCount = 24 },
	{ id = 23374, chance = 55000, maxCount = 24 },
	{ id = 21974, chance = 12080 }, -- golden lotus brooch
	{ id = 3041, chance = 81160 }, -- blue gem
	{ id = 21981, chance = 55920 }, -- oriental shoes
	{ id = 21975, chance = 10510 }, -- peacock feather fan
	{ id = 3567, chance = 15400 }, -- blue robe
	{ id = 5912, chance = 55400, maxCount = 3 }, -- blue piece of cloth
	{ name = "small enchanted sapphire", chance = 29640, maxCount = 6 },
	{ name = "royal star", chance = 74000, maxCount = 33 },
	{ id = 3027, chance = 10360, maxCount = 12 }, -- black pearl
	{ id = 3054, chance = 2260 }, -- silver amulet
	{ id = 3023, chance = 1000, unique = true },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500, condition = { type = CONDITION_FREEZING, totalDamage = 400, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -350, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1200, maxDamage = -2500, range = 6, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1200, maxDamage = -2500, length = 8, spread = 5, effect = CONST_ME_SLASH, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -600, maxDamage = -1500, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -100, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000 },
}

monster.defenses = {
	defense = 55,
	armor = 72,
	mitigation = 2.11,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
