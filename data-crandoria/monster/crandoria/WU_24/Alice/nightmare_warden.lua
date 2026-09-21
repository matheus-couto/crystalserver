local mType = Game.createMonsterType("Nightmare Warden")
local monster = {}

monster.description = "a nightmare warden"
monster.experience = 33820
monster.outfit = {
	lookType = 1059,
	lookHead = 94,
	lookBody = 114,
	lookLegs = 79,
	lookFeet = 57,
	lookAddons = 0,
	lookMount = 0,
}



monster.health = 29000
monster.maxHealth = 29000
monster.race = "undead"
monster.corpse = 28782
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 8,
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
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 45000, maxCount = 36 },
	{ id = 3043, chance = 2000, maxCount = 1 },
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 238, chance = 25000, maxCount = 2},
	{ id = 239, chance = 25000, maxCount = 3},
	{ id = 7643, chance = 15000, maxCount = 1},
	{ id = 23373, chance = 15000, maxCount = 1},
	{ id = 23374, chance = 15000, maxCount = 2},
	{ id = 7642, chance = 25000, maxCount = 2},
	{ id = 3039, chance = 2500, maxCount = 1 },
	{ id = 30180, chance = 1500, maxCount = 1 },
	{ id = 7404, chance = 2500, maxCount = 1 },
	
--	{ id = 43733, chance = 10 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 },
	{ name = "combat", interval = 1500, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -675, maxDamage = -1200, length = 5, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -600, maxDamage = -1180, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "great death ring", interval = 2000, chance = 20, minDamage = -600, maxDamage = -1180, range = 6, target = false }
}

monster.defenses = {
	defense = 78,
	armor = 78,
	mitigation = 2.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
