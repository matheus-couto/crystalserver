local mType = Game.createMonsterType("Mutated Cursed Ape")
local monster = {}

monster.description = "a mutated cursed ape"
monster.experience = 12600
monster.outfit = {
	lookType = 1592,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 14000
monster.maxHealth = 14000
monster.race = "blood"
monster.corpse = 42073
monster.speed = 108
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
--	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "gold coin", chance = 96120, maxCount = 257 },
	{ name = "platinum coin", chance = 66000, maxCount = 47 },
	{ id = 3043, chance = 10200, maxCount = 1 },
	{ name = "gold coin", chance = 38670, maxCount = 11 },
	{ name = "kongra's shoulderpad", chance = 18890 },
	{ name = "small amethyst", chance = 9140, maxCount = 4 },
	{ name = "protection amulet", chance = 3750 },
	{ name = "plate armor", chance = 5630 },
	{ name = "ape fur", chance = 3250 },
	{ name = "ultimate health potion", chance = 5500, maxCount = 2 },
	{ id = 3050, chance = 1380 }, -- power ring
	{ id = 3093, chance = 1250 }, -- club ring
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1298 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -510, maxDamage = -1025, radius = 2, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 45,
	armor = 70,
	mitigation = 1.37,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
