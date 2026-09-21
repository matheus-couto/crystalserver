local mType = Game.createMonsterType("Kouda the Burning Shadow")
local monster = {}

monster.description = "Kouda the Burning Shadow"
monster.experience = 500000
monster.outfit = {
	lookType = 928,
	lookMount = 0
}


monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 300
monster.manaCost = 0

monster.events = {
	"koudaDeath",
}

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Can you find the shadows in the dark?", yell = false},
	{text = "My shadows fight with me!", yell = false},
	{text = "You can't defeat what you can't reach!", yell = false},
}

monster.loot = {
		-- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 3065, maxCount = 3 },
	{name = "crystal coin", chance = 1000000, minCount = 2, maxCount = 4},
	{name = "platinum coin", chance = 1000000, minCount = 26, maxCount = 44},
	{name = "great spirit potion", chance = 32220, maxCount = 7},
	{name = "ultimate mana potion", chance = 58322, maxCount = 11},
	{name = "ultimate health potion", chance = 66200, maxCount = 13},
	{name = "ultimate spirit potion", chance = 66500, maxCount = 12},
	{name = "supreme health potion", chance = 32500, maxCount = 8},
	{id = 3030, chance = 1000000, minCount = 6, maxCount = 12},
	{id = 821, chance = 22000},
	{id = 827, chance = 22000},
	{id = 818, chance = 22000},
	{id = 826, chance = 22000},
	{id = 3420, chance = 32000},
	{id = 3275, chance = 32000},
	{id = 3028, chance = 35000, maxCount = 6},
	{id = 8084, chance = 25000},
	{id = 16115, chance = 25000},
	{id = 5904, chance = 10000, maxCount = 2},
	{id = 30059, chance = 35000, maxCount = 1},
	{id = 22516, chance = 25000, maxCount = 1},
	{id = 22721, chance = 25000, maxCount = 1},
	{id = 6499, chance = 60000, maxCount = 3},
	{id = 8058, chance = 50, unique = true}, -- molten plate
	{id = 7423, chance = 50, unique = true}, -- skull crusher
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -2000},
	{name = "combat", interval = 2000, chance = 20, type = COMBAT_DEAHDAMAGE, mindamage = -1500, maxDamage = -4900, range = 8, radius = 6, effect = CONST_ME_MORTAREA, targe = false},
	{ name ="great fire ring", interval = 2000, chance = 25, minDamage = -1550, maxDamage = -3500, range = 7, target = false},
	{ name = "fire cross", interval = 2000, chance = 15, minDamage = -2000, maxDamage = -3300, target = false},
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -1550, maxDamage = -3000, range = 8, target = true},
	{ name = "mana drain chain", interval = 2500, chance = 10, minDamage = -500, maxDamage = -1000 },
	{ name = "check ip", interval = 20000, chance = 100, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 100,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 5000, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.reflects = {
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = -15},
	{type = COMBAT_DEATHDAMAGE , percent = 30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)