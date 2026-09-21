local mType = Game.createMonsterType("Enraged Carnisylvan")
local monster = {}

monster.description = "an enraged carnisylvan"
monster.experience = 8200
monster.outfit = {
	lookType = 1418,
	lookHead = 23,
	lookBody = 98,
	lookLegs = 22,
	lookFeet = 61,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 9000
monster.maxHealth = 9000
monster.race = "blood"
monster.corpse = 36890
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
	targetDistance = 4,
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
		{ name = "Poisonous Carnisylvan", chance = 10, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- -- { id = 3250, chance = 1875, maxCount = 1 },
	{ name = "platinum coin", chance = 70000, maxCount = 17 },
	{ name = "platinum coin", chance = 70000, maxCount = 47 },
	{ id = 3043, chance = 970, maxCount = 1 }, 
	{ name = "carnisylvan bark", chance = 16040, maxCount = 2 },
	{ name = "mushroom pie", chance = 12640, maxCount = 1 },
	{ name = "carnisylvan finger", chance = 11640, maxCount = 4 },
	{ name = "emerald bangle", chance = 6970 },
	{ name = "ultimate spirit potion", chance = 6810, maxCount = 2 },
	{ name = "guardian halberd", chance = 6970 },
	{ id = 23542, chance = 4970 },
	{ name = "terra rod", chance = 11330 },
	{ name = "underworld rod", chance = 9280 },
	{ name = "diamond sceptre", chance = 6710 },
	{ name = "fire mushroom", chance = 3140 },
	{ name = "knight axe", chance = 8760 },
	{ name = "wand of starstorm", chance = 6710 },
	{ name = "sacred tree amulet", chance = 3880 },
	{ id = 281, chance = 2090 }, -- giant shimmering pearl (green)
	{ name = "gemmed figurine", chance = 1790 },
	{ name = "human teeth", chance = 2520 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -780 },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -920, radius = 4, range = 5, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_POISONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -890, range = 5, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_POISONAREA, target = true },
}

monster.defenses = {
	defense = 37,
	armor = 37,
	mitigation = 1.13,
	{ name = "speed", interval = 2000, chance = 8, speedChange = 250, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
