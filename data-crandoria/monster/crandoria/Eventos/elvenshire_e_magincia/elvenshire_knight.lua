local mType = Game.createMonsterType("Elvenshire Knight")
local monster = {}

monster.description = "an elvenshire knight"
monster.experience = 0
monster.outfit = {
	lookType = 268,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 84,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 401,
}

monster.health = 5000
monster.maxHealth = 5000
monster.race = "venom"
monster.corpse = 5993
monster.speed = 200
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

monster.light = {
	level = 4,
	color = 203,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -250, range = 2, radius = 3, effect = CONST_ME_HITAREA, target = false },
	{ name = "Whirlwind Throw", interval = 2000, chance = 15, minDamage = -180, maxDamage = -250, range = 5, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 50,
--	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 190, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
