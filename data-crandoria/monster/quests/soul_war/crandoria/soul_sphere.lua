local mType = Game.createMonsterType("Soul Sphere")
local monster = {}

monster.description = "a soul sphere"
monster.experience = 0
monster.outfit = {
	lookType = 979,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

-- monster.faction = FACTION_DEEPLING
-- monster.enemyFactions = { FACTION_DEATHLING }

-- monster.changeTarget = {
-- 	interval = 500,
-- 	chance = 100,
-- }

-- monster.changeTarget2 = {
-- 	interval = 500,
-- 	chance = 100,
-- }

-- monster.strategiesTarget = {
-- 	nearest = 0,
-- 	health = 0,
-- 	random = 0,
-- 	damage = 0,
-- }

-- monster.strategiesTarget2 = {
-- 	nearest = 0,
-- 	health = 0,
-- 	damage = 0,
-- 	random = 0,
-- }

monster.health = 15000
monster.maxHealth = 15000
monster.race = "undead"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 0,
	targetDistance = 0,
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

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	-- { name = "soul sphere walk", interval = 4500, chance = 100, range = 15 },
	
}

monster.defenses = {
	defense = 45,
	armor = 60,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
