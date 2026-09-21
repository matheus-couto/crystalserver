local mType = Game.createMonsterType("Elite Mercenary")
local monster = {}

monster.description = "an elite mercenary"
monster.experience = 7630
monster.outfit = {
	lookType = 137,
	lookHead = 95,
	lookBody = 116,
	lookLegs = 39,
	lookFeet = 76,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 9950
monster.maxHealth = 9950
monster.race = "blood"
monster.corpse = 18261
monster.speed = 150
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
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
	{ text = "Yeeyeeyeee!", yell = false },
	{ text = "Fight me if you dare!", yell = false },
	{ text = "I challenge you!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 22000, maxCount = 11 },
	{ name = "strong mana potion", chance = 33000, maxCount = 1 },
	{ name = "ultimate health potion", chance = 8000 },
	{ id = 238, chance = 33000 },
	{ name = "bread", chance = 9000 },
	{ name = "dark mushroom", chance = 3000 },
	{ name = "swamplair armor", chance = 1100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "drunk", interval = 2000, chance = 15, length = 3, spread = 2, effect = CONST_ME_SOUND_RED, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -500, range = 5, shootEffect = CONST_ANI_POWERBOLT, effect = CONST_ME_DRAWBLOOD, target = true },
	{ name = "combat", interval = 2500, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -500, range = 5, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 45,
	mitigation = 0.71,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
