local mType = Game.createMonsterType("Crandoria Chaos Golem")
local monster = {}

monster.name = ""
monster.description = "a crandoria chaos golem"
monster.experience = 1000000
monster.outfit = {
	lookType = 947,
	lookHead = 84,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 84,
	lookAddons = 3,
	lookMount = 0
}

monster.faction = FACTION_DEATHLING
monster.enemyFactions = { FACTION_DEEPLING }

monster.health = 50000
monster.maxHealth = 50000
monster.race = "fire"
monster.corpse = 0
monster.speed = 300
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
	nearest = 80,
	random = 20,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
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
	level = 10,
	color = 215,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "BURN!!!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2000 },
	{ name = "combat", interval = 4000, chance = 35, type = COMBAT_AGONYDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_AGONY, target = false },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_AGONYDAMAGE, minDamage = -500, maxDamage = -1000, radius = 4, effect = CONST_ME_AGONY, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 50,
	mitigation = 0,
	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_HEALING, minDamage = -500, maxDamage = -500, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 35 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
