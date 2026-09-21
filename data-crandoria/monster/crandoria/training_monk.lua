local mType = Game.createMonsterType("Training Monk")
local monster = {}

monster.description = "a training monk"
monster.experience = 200
monster.outfit = {
	lookType = 57,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "blood"
monster.corpse = 18090
monster.speed = 0
monster.manaCost = 0

-- monster.changeTarget = {
-- 	interval = 3000,
-- 	chance = 35,
-- }

-- monster.changeTarget2 = {
-- 	interval = 1 * 1000,
-- 	chance = 100,
-- }

monster.changeTarget = {
	interval = 10000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 35,
}

monster.strategiesTarget = {
	nearest = 100,
	health = 0,
	random = 0,
	damage = 0,
}

monster.strategiesTarget2 = {
	nearest = 100,
}


monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 1,
	staticAttackChance = 100,
}

monster.light = {
	level = 0,
	color = 0
}


monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{id = 2815, chance = 2000}, -- scroll
	{name = "brown flask", chance = 820},
	{id = 2914, chance = 880}, -- lamp
	{name = "gold coin", chance = 15000, maxCount = 18},
	{id = 3050, chance = 100}, -- power ring
	{name = "life crystal", chance = 1002},
	{name = "ankh", chance = 2240},
	{id = 3289, chance = 440}, -- staff
	{name = "sandals", chance = 710},
	{name = "bread", chance = 20000},
	{name = "book of prayers", chance = 4930},
	{name = "rope belt", chance = 2950},
	{name = "safety pin", chance = 1001}
}

monster.attacks = {
	{name ="melee", attack = 130, interval = 2000, chance = 100, minDamage = -1, maxDamage = -2}
}

monster.defenses = {
	defense = 1,
	armor = 1,
	{name ="combat", interval = 2000, chance = 100, type = COMBAT_HEALING, minDamage = 50000, maxDamage = 100000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 100, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
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
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
