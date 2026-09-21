local mType = Game.createMonsterType("Angry Harpy")
local monster = {}

monster.description = "an angry harpy"
monster.experience = 8360
monster.outfit = {
	lookType = 1604,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2340
monster.Bestiary = {
	class = "Bird",
	race = BESTY_RACE_BIRD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Ingol",
}

monster.health = 9850
monster.maxHealth = 9850
monster.race = "blood"
monster.corpse = 42222
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 3,
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
	{ text = "Blood will flow!", yell = false },
	{ text = "Shriek!", yell = false },
	{ text = "Screech!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
--	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "platinum coin", chance = 73130, maxCount = 30 },
	{ name = "platinum coin", chance = 73130, maxCount = 22 },
	{ name = "harpy feathers", chance = 8720 },
	{ name = "violet crystal shard", chance = 6690 },
	{ name = "blue crystal shard", chance = 6530 },
	{ name = "ultimate spirit potion", chance = 4970, maxCount = 3 },
	{ name = "violet gem", chance = 3500 },
	{ name = "gold ring", chance = 1720 },
	{ name = "wand of defiance", chance = 2720 },
	{ name = "focus cape", chance = 3560 },
	{ name = "ornate crossbow", chance = 1910 },
	{ name = "magic plate armor", chance = 1140 },
	{ name = "shockwave amulet", chance = 770 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -845 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -396, maxDamage = -750, range = 3, effect = CONST_ME_BIG_SCRATCH, target = true },
	{ name = "energy ring", interval = 2000, chance = 20, minDamage = -480, maxDamage = -750 },
	{ name = "energy chain", interval = 2000, chance = 20, minDamage = -355, maxDamage = -749, range = 3, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -310, maxDamage = -805, length = 5, spread = 3, effect = CONST_ME_SOUND_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -420, maxDamage = -980, range = 7, radius = 4, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -525, maxDamage = -1045, effect = CONST_ME_POISON, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 58,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
