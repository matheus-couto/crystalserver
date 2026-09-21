local mType = Game.createMonsterType("Cursed Strider")
local monster = {}

monster.description = "a cursed strider"
monster.experience = 12800
monster.outfit = {
	lookType = 1403,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 11500
monster.maxHealth = 11500
monster.race = "blood"
monster.corpse = 36716
monster.speed = 190
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
	nearest = 70,
	damage = 30,
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
	staticAttackChance = 70,
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
--	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "platinum coin", chance = 50000, maxCount = 66 },
	{ name = "afflicted strider worms", chance = 14940, maxCount = 3 },
	{ name = "guardian halberd", chance = 11410 },
	{ name = "crystal sword", chance = 8940 },
	{ name = "violet gem", chance = 9940, maxCount = 1 },
	{ name = "violet crystal shard", chance = 7410 },
	{ name = "doublet", chance = 5060 },
	{ name = "green crystal shard", chance = 8820 },
	{ name = "belted cape", chance = 3760 },
	{ name = "afflicted strider head", chance = 6820 },
	{ name = "knight armor", chance = 8590 },
	{ name = "spirit cloak", chance = 5060 },
	{ name = "magma coat", chance = 4470 },
	{ name = "serpent sword", chance = 3240 },
	{ name = "machete", chance = 3760 },
	{ name = "broadsword", chance = 1060 },
	{ name = "focus cape", chance = 6240 },
	{ name = "ice rapier", chance = 4240 },
	{ name = "titan axe", chance = 2880 },
	{ name = "haunted blade", chance = 4410 },
	{ name = "mercenary sword", chance = 3530 },
	{ name = "knight axe", chance = 2290 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -650, maxDamage = -1150, range = 3, shootEffect = CONST_ANI_POISON, target = true },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -750, maxDamage = -1200, radius = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 68,
	armor = 68,
	mitigation = 1.88,
	{ name = "speed", interval = 2000, chance = 25, speedChange = 450, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
