local mType = Game.createMonsterType("Lost Salamander")
local monster = {}

monster.description = "a lost salamander"
monster.experience = 9800
monster.outfit = {
	lookType = 1196,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 11600
monster.maxHealth = 11600
monster.race = "blood"
monster.corpse = 17427
monster.speed = 180
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
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Chrrch!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3035, chance = 66666, maxCount = 35 },
	{ id = 3035, chance = 33333, maxCount = 22 },
	{ id = 7643, chance = 8100, maxCount = 1 },
	{ id = 238, chance = 4100, maxCount = 2 },
	{ id = 3041, chance = 4100, maxCount = 1 },
	{ id = 3029, chance = 4100, maxCount = 7 },
	{ id = 8051, chance = 100 },
	{ name = "lightning boots", chance = 2270 },
	{ id = 822, chance = 3100 },
	{ id = 3079, chance = 1500 },
	{ id = 8082, chance = 2100 },
	{ id = 30061, chance = 600, maxCount = 1 },
	{ id = 29995, chance = 200, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -850, effect = CONST_ME_DRAWBLOOD, condition = { type = CONDITION_POISON, totalDamage = 10, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_ENERGYDAMAGE, minDamage = -450, maxDamage = -780, range = 7, radius = 3, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 63,
	mitigation = 0.53,
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_HEALING, minDamage = 400, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 65 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
