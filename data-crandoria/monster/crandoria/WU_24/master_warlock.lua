local mType = Game.createMonsterType("Master Warlock")
local monster = {}

monster.description = "a master warlock"
monster.experience = 8900
monster.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 52,
	lookLegs = 128,
	lookFeet = 95,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 8850
monster.maxHealth = 8850
monster.race = "blood"
monster.corpse = 18246
monster.speed = 155
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

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "nightstalker", chance = 10, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "piggy bank", chance = 160 },
	{ name = "ring of the sky", chance = 830 },
	{ id = 3007, chance = 700 }, -- crystal ring
	{ name = "small sapphire", chance = 1890 },
	{ id = 3035, chance = 29340, maxCount = 22 },
	{ name = "talon", chance = 1650 },
	{ id = 3051, chance = 2800 }, -- energy ring
	{ name = "stone skin amulet", chance = 830 },
	{ name = "golden armor", chance = 2240 },
	{ id = 3509, chance = 2000 }, -- inkwell
	{ name = "blue robe", chance = 2810 },
	{ name = "cherry", chance = 19000, maxCount = 4 },
	{ name = "bread", chance = 9000 },
	{ name = "dark mushroom", chance = 3000 },
	{ name = "ultimate mana potion", chance = 3760 },
	{ name = "great health potion", chance = 6190, maxCount = 2 },
	{ name = "lightning robe", chance = 2000 },
	{ name = "luminous orb", chance = 910 },
	{ id = 10438, chance = 450 },
	{ id = 8094, chance = 1500 },
	{ name = "strong mana potion", chance = 33000, maxCount = 2 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -430 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -190, maxDamage = -480, range = 7, shootEffect = CONST_ANI_ENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -200, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -150, maxDamage = -300, range = 5, radius = 4, effect = CONST_ME_REDSMOKE, target = false },
	{ name = "firefield", interval = 2000, chance = 10, range = 7, radius = 2, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -530, length = 8, spread = 3, effect = CONST_ME_BIGCLOUDS, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 33,
	mitigation = 1.32,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 180, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 95 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = -8 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
