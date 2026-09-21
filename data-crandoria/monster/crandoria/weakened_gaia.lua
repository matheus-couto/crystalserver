local mType = Game.createMonsterType("Weakened Gaia")
local monster = {}

monster.description = "Weakened Gaia"
monster.experience = 300000000
monster.outfit = {
	lookType = 148,
	lookHead = 94,
	lookBody = 120,
	lookLegs = 101,
	lookFeet = 80,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 2000000
monster.maxHealth = 2000000
monster.race = "blood"
monster.corpse = 18042
monster.speed = 230
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 50,
	health = 10,
	random = 30,
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Hulking Prehemoth", chance = 22, interval = 2000, count = 2},
		{name = "Undertaker", chance = 20, interval = 2000, count = 2}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "FEEL THE REAL POWER OF NATURE!", yell = false},
	{text = "YOU THINK YOU CAN DEFEAT ME? COME AND TRY!", yell = false},
	{text = "HERE IS THE NATURES FURY!", yell = false}
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{name = "crystal coin", chance = 49658, maxCount = 14},
	{id = 16163, chance = 8333}, -- crystal crossbow
	{id = 16161, chance = 7333}, -- crystalline axe
	{id = 16160, chance = 6666}, -- crystalline sword
	{id = 16164, chance = 6263}, -- mycological bow
	{id = 16162, chance = 2754}, -- mycological mace
	{id = 3043, chance = 50000, maxCount = 4},
	{id = 3043, chance = 50000, maxCount = 11},
	{id = 3102, chance = 150, maxCount = 1},
	-- {id = 35909, chance = 250, maxCount = 1},
	{ id = 39136, chance = 5000 }, -- perdao real
	-- { name = "primal bag", chance = 250, unique = true },
	{ id = 12811, chance = 40000 },
	{ id = 30060, chance = 50000 },
	{ id = 30061, chance = 50000 },
	{ id = 30059, chance = 50000 },
	{ id = 35909, chance = 1000000, unique = true },
	{ id = 26186, chance = 100000, minCount = 1, maxCount = 2 },
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900},
	{name ="condition", type = CONDITION_POISON, interval = 1000, chance = 30, minDamage = -300, maxDamage = -600, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_SMALLPLANTS, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -600, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -300, maxDamage = -800, length = 10, spread = 3, effect = CONST_ME_PLANTATTACK, target = false},
	{name ="abyssador poison wave", interval = 1000, chance = 20, minDamage = -200, maxDamage = -390, target = false},
	{name ="poison chain", interval = 2000, chance = 15, minDamage = -450, maxDamage = -800, range = 7},
	{name ="boulder ring", interval = 2000, chance = 25, minDamage = -250, maxDamage = -600, range = 6, target = false}
}

monster.defenses = {
	defense = 86,
	armor = 92,
	{name ="combat", interval = 4000, chance = 20, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 4000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 25, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -5},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -15},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 40},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
