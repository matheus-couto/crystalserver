local mType = Game.createMonsterType("Elvenshire Mage")
local monster = {}

monster.description = "an elvenshire mage"
monster.experience = 0
monster.outfit = {
	lookType = 1146,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 84,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 3400
monster.maxHealth = 3400
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
	staticAttackChance = 100,
	targetDistance = 3,
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
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_EARTHDAMAGE, minDamage = -50, maxDamage = -100, range = 3, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false },
	{ name = "Ice Strike", interval = 2000, chance = 20, minDamage = -150, maxDamage = -380, range = 4 },
	{ name = "Terra Strike", interval = 2000, chance = 20, minDamage = -150, maxDamage = -320, range = 4 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -450, range = 5, length = 6, spread = 3, effect = CONST_ME_ICEATTACK, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 150, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
