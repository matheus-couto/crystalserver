local mType = Game.createMonsterType("Mileena")
local monster = {}

monster.description = "Mileena"
monster.experience = 200000
monster.outfit = {
	lookType = 1068,
	lookHead = 70,
	lookBody = 114,
	lookLegs = 108,
	lookFeet = 2,
	lookAddons = 3,
	lookMount = 0,
}



monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 28617
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
	{ name = "crystal coin", chance = 27380, minCount = 6, maxCount = 10 },
	{ id = 3035, chance = 100000, minCount = 65, maxCount = 100 }, -- platinum coin
	{ id = 6558, chance = 19790 }, -- flask of demonic blood
	{ id = 3033, chance = 100000, minCount = 50, maxCount = 80 }, -- small amethyst
	{ id = 7643, chance = 55000, maxCount = 55 },
	{ id = 23373, chance = 55000, maxCount = 55 },
	{ id = 23374, chance = 55000, maxCount = 55 },
	{ id = 21974, chance = 12080 }, -- golden lotus brooch
	{ id = 3036, chance = 84800, maxCount = 6 }, -- green gem
	{ id = 21981, chance = 55920 }, -- oriental shoes
	{ id = 21975, chance = 35510 }, -- peacock feather fan
	{ id = 8043, chance = 55400 }, -- focus cape
	{ id = 3051, chance = 71100 }, -- energy ring
	{ name = "small enchanted amethyst", chance = 29640, maxCount = 25 },
	{ name = "royal star", chance = 74000, maxCount = 83 },
	{ id = 3027, chance = 50360, maxCount = 35 }, -- black pearl
	{ id = 3054, chance = 2260 }, -- silver amulet
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200, condition = { type = CONDITION_POISON, totalDamage = 800, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -400, range = 7, radius = 2, effect = CONST_ME_ENERGYAREA, target = false }, -- mana drain beam
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -900, maxDamage = -2000, length = 6, spread = 0, range = 6, effect = CONST_ME_ENERGYAREA, target = false }, -- poison wave
	{ name = "energy chain", interval = 2000, chance = 20, minDamage = -600, maxDamage = 1800, range = 5, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -550, range = 6, effect = CONST_ME_HITAREA, shootEffect = CONST_ANI_LEAFSTAR, target = true }, -- holy ball
	{ name = "speed", interval = 2000, chance = 15, speedChange = -400, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 15000 }, -- smoke berserk
}

monster.defenses = {
	defense = 55,
	armor = 48,
	mitigation = 1.46,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 100, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
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
