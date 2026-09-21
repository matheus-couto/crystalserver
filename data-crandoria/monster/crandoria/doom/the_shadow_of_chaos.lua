local mType = Game.createMonsterType("The Shadow of Chaos")
local monster = {}

monster.description = "The Shadow of Chaos"
monster.experience = 1000000
monster.outfit = {
	lookType = 1188,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0
}


monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 350
monster.manaCost = 0

monster.events = {
	"shadowofChaosDeath",
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
	interval = 15000,
	chance = 15,
	{text = "The darkness leads me through my path!", yell = true},
	{text = "You think you can defeat the Chaos? HA HA HA", yell = true},
	{text = "I'm the only real Chaos Bringer!", yell = true},
	{text = "No light can extinguish my darkness.", yell = true},
	{text = "How does it feel to face death?", yell = true},
}

monster.loot = {
		-- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 3065, maxCount = 3 },
	{name = "crystal coin", chance = 1000000, minCount = 4, maxCount = 12},
	{name = "platinum coin", chance = 1000000, minCount = 26, maxCount = 76},
	{name = "great spirit potion", chance = 32220, maxCount = 7},
	{name = "ultimate mana potion", chance = 58322, maxCount = 11},
	{name = "ultimate health potion", chance = 66200, maxCount = 13},
	{name = "ultimate spirit potion", chance = 66500, maxCount = 12},
	{name = "supreme health potion", chance = 32500, maxCount = 8},
	{id = 3028, chance = 1000000, minCount = 8, maxCount = 12},
	{id = 22727, chance = 1000},
	{id = 3360, chance = 22000},
	{id = 5741, chance = 35000},
	{id = 3554, chance = 35000},
	{id = 16163, chance = 15000},
	{id = 16115, chance = 25000},
	{id = 3364, chance = 25000},
	{id = 3382, chance = 25000},
	{id = 11693, chance = 5000},
	{id = 5904, chance = 15000, maxCount = 5},
	{id = 22516, chance = 35000, maxCount = 3},
	{id = 22721, chance = 35000, maxCount = 3},
	{id = 6499, chance = 60000, maxCount = 10},
	{id = 19391, chance = 50, unique = true}, -- Furious Frock
	{id = 8097, chance = 50, unique = true}, -- Solar Axe
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -4000},
	{name = "great death ring", interval = 2000, minDamage = -2000, maxDamage = -3200, chance = 25, target = false },
	{ name = "life drain chain", interval = 2500, chance = 10, minDamage = -1000, maxDamage = -2500 },
	{name = "bakragore vortex", interval = 2500, chance = 25, minamage = -1800, maxDamage = -4500, range = 7, target = false },
	{ name = "shadow of chaos doom", interval = 60000, chance = 100, target = false },
	{ name = "check ip", interval = 20000, chance = 100, target = false },
}

monster.defenses = {
	defense = 75,
	armor = 100,
	{ name = "combat", interval = 4000, chance = 10, type = COMBAT_HEALING, minDamage = 3000, maxDamage = 10000, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.reflects = {
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)