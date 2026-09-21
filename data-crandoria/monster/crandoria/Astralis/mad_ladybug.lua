local mType = Game.createMonsterType("Lost Ladybug")
local monster = {}

monster.description = "a lost ladybug"
monster.experience = 11300
monster.outfit = {
	lookType = 448,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 14100
monster.maxHealth = 14100
monster.race = "venom"
monster.corpse = 13845
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 0,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 60,
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
	{ text = "Nee Pah!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 65000, maxCount = 40 },
	{ id = 3035, chance = 66666, maxCount = 33 },
	{ id = 3043, chance = 550, maxCount = 1 },
	{ id = 3554, chance = 1800, maxCount = 1 },
	{ id = 3414, chance = 2500, maxCount = 1 },
	{ id = 3057, chance = 500, maxCount = 1 },
	{ id = 3030, chance = 4500, maxCount = 4 },
	{ id = 3039, chance = 2500, maxCount = 1 },
	{ name = "wand of everblazing", chance = 1790 },
	{ id = 5921, chance = 1800, maxCount = 1 },
	{ id = 7643, chance = 11800, maxCount = 1 },
	{ id = 29995, chance = 500, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1450 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -750, maxDamage = -1280, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "great death ring", interval = 2000, chance = 15, minDamage = -880, maxDamage = -1300, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1450, radius = 4, range = 4, effect = CONST_ME_INSECTS, target = false }

}

monster.defenses = {
	defense = 50,
	armor = 58,
	mitigation = 0.84,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
