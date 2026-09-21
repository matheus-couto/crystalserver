local mType = Game.createMonsterType("Elvenshire Assassin")
local monster = {}

monster.description = "an elvenshire assassin"
monster.experience = 0
monster.outfit = {
	lookType = 577,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 84,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 3200
monster.maxHealth = 3200
monster.race = "venom"
monster.corpse = 5993
monster.speed = 180
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
	staticAttackChance = 85,
	targetDistance = 1,
	runHealth = 1,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = false,
}


monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = -100, maxDamage = -175 },
	{ name = "combat", type = COMBAT_LIFEDRAIN, interval = 2000, chance = 20, minDamage = -100, maxDamage = -250, range = 6, shootEffect = CONST_ANI_THROWINGKNIFE, effect = CONST_ME_DRAWBLOOD, target = true },
}

monster.defenses = {
	defense = 100,
	armor = 40,
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_YELLOW_RINGS },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
