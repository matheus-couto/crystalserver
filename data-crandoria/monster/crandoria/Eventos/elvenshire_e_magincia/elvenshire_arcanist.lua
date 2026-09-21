local mType = Game.createMonsterType("Elvenshire Arcanist")
local monster = {}

monster.description = "an elvenshire arcanist"
monster.experience = 0
monster.outfit = {
	lookType = 695,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 84,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 2800
monster.maxHealth = 2800
monster.race = "venom"
monster.corpse = 5993
monster.speed = 150
monster.manaCost = 0

monster.faction = FACTION_DEATHLING -- Crandoria
monster.enemyFactions = { FACTION_DEEPLING } -- Inimigo Magincia

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 15,
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
	staticAttackChance = 100,
	targetDistance = 3,
	runHealth = 1,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}


monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -50, maxDamage = -100, range = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -250, range = 4, radius = 4, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 20,
	armor = 30,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
