local mType = Game.createMonsterType("Jade")
local monster = {}

monster.description = "Jade"
monster.experience = 200000
monster.outfit = {
	lookType = 1068,
	lookHead = 95,
	lookBody = 103,
	lookLegs = 121,
	lookFeet = 2,
	lookAddons = 3,
	lookMount = 0,
}



monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 36982
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
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
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "crystal coin", chance = 27380, maxCount = 4 },
	{ id = 3035, chance = 100000, maxCount = 88 }, -- platinum coin
	{ id = 6558, chance = 19790 }, -- flask of demonic blood
	{ id = 3032, chance = 100000, maxCount = 35 }, -- small emerald
	{ id = 7643, chance = 55000, maxCount = 24 },
	{ id = 23373, chance = 55000, maxCount = 24 },
	{ id = 23374, chance = 55000, maxCount = 24 },
	{ id = 21974, chance = 12080 }, -- golden lotus brooch
	{ id = 3038, chance = 84800 }, -- green gem
	{ id = 21981, chance = 55920 }, -- oriental shoes
	{ id = 21975, chance = 10510 }, -- peacock feather fan
	{ id = 3567, chance = 15400 }, -- blue robe
	{ id = 3052, chance = 71100 }, -- life ring
	{ name = "small enchanted sapphire", chance = 29640, maxCount = 6 },
	{ name = "royal star", chance = 74000, maxCount = 83 },
	{ id = 3027, chance = 10360, maxCount = 12 }, -- black pearl
	{ id = 3054, chance = 2260 }, -- silver amulet
	{ id = 8052, chance = 6500 }, -- swamplair armor
	{ id = 5910, chance = 83070, maxCount = 3 }, -- green piece of cloth
	{ id = 3024, chance = 1000, unique = true },
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200, condition = { type = CONDITION_POISON, totalDamage = 800, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -600, range = 7, length = 7, effect = CONST_ME_ENERGYAREA, target = false }, -- mana drain beam
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -900, maxDamage = -2000, length = 6, spread = 3, range = 6, effect = CONST_ME_GREEN_RINGS, target = false }, -- poison wave
		{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -900, maxDamage = -2000, length = 6, spread = 3, range = 6, effect = 299, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -550, range = 6, effect = CONST_ME_HITAREA, shootEffect = CONST_ANI_LEAFSTAR, target = true }, -- holy ball
	{ name = "speed", interval = 2000, chance = 15, speedChange = -400, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 15000 }, -- smoke berserk
}

monster.defenses = {
	defense = 55,
	armor = 48,
	mitigation = 1.46,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
