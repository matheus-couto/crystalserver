local mType = Game.createMonsterType("Magincia Archer")
local monster = {}

monster.description = "a magincia archer"
monster.experience = 0
monster.outfit = {
	lookType = 1102,
	lookHead = 0,
	lookBody = 113,
	lookLegs = 114,
	lookFeet = 113,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 3800
monster.maxHealth = 3800
monster.race = "venom"
monster.corpse = 5963
monster.speed = 180
monster.manaCost = 0

monster.faction = FACTION_DEEPLING -- MAgincia
monster.enemyFactions = { FACTION_DEATHLING } -- Inimigo Elvenshire

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
	targetDistance = 4,
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
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -150 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -300, range = 5, shootEffect = CONST_ANI_ARROW, target = false },
	{ name = "Divine Missile", interval = 2000, chance = 20, minDamage = -100, maxDamage = -180, range = 5 },
	{ name = "combat", intervel = 2000, chance = 8, minDamage = -150, maxDamage = -310, range = 2, radius = 2, effect = CONST_ME_HOLYAREA },
}

monster.defenses = {
	defense = 20,
	armor = 40,
--	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 100, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -25 },
	{ type = COMBAT_FIREDAMAGE, percent = -25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
