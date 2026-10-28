local mType = Game.createMonsterType("Ayana the Crimson Curse")
local monster = {}

monster.description = "Ayana the Crimson Curse"
monster.experience = 12400
monster.outfit = {
	lookType = 1647,
	lookHead = 57,
	lookBody = 132,
	lookLegs = 2,
	lookFeet = 95,
	lookAddons = 3,
}


monster.health = 17000
monster.maxHealth = 17000
monster.race = "blood"
monster.corpse = 44039
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "Platinum Coin", chance = 63640, maxCount = 35 },
	{id = 43729, chance = 25000, maxCount = 2},
	{id = 3030, chance = 25000, maxCount = 4},
	{id = 43734, chance = 25000, maxCount = 1},
	{id = 3039, chance = 25000, maxCount = 1},
	{id = 22083, chance = 5000, maxCount = 1},
	{id = 43737, chance = 20000, maxCount = 1},
	{name = "demonrage sword", chance = 4500},
	{name = "ornate crossbow", chance = 12000},
	-- {id = 43888, chance = 12000},
	{id = 3036, chance = 20000},
	{id = 43901, chance = 150},
	-- { id = 22721, chance = 50000 }, -- gold token

}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -620 },
	{name = "combat", interval = 1000, chance = 12, minDamage = 250, maxDamage = 930, type = COMBAT_PHYSICALDAMAGE, radius = 4, range = 6, effect = CONST_ME_YELLOW_RINGS, target = true},
	{name = "life drain chain", interval = 1000, chance = 10, minDamage = 300, maxDamage = 400, range = 4, target = true},
	{name = "great fire wave", interval = 2000, chance = 20, minDamage = 145, maxDamage = 550, range = 6, target = false},
	{name = "combat", interval = 2000, chance = 15, minDamage = 300, maxDamage = 350, type = COMBAT_DEATHDAMAGE, radius = 4, range = 6, effect = CONST_ME_MORTAREA, target = true},
	{name = "giant fire ring", interval = 2000, chance = 12, minDamage = 600, maxDamage = 840, range = 6, target = false}

}

monster.defenses = {
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false},
	defense = 70,
	armor = 92,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
