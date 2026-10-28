local mType = Game.createMonsterType("Zharvorin's Soulcage")
local monster = {}

monster.description = "Zharvorin's Soulcage"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 52546,
}

monster.health = 120000
monster.maxHealth = 120000
monster.race = "undead"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100, -- não confirmado
}

monster.events = {
	"soulcageLifeChange",
	"soulcageDeath"
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
	canPushCreatures = true,
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true, -- não confirmado
	canWalkOnFire = true, -- não confirmado
	canWalkOnPoison = true, -- não confirmado
}

monster.light = {
	level = 0,
	color = 0,
}

monster.loot = {}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Zharvorin's Spirit", chance = 100, interval = 2000, count = 1 },
	},
}

-- Ice Explosion (700+), Ice Chain (700+)
monster.attacks = {
	{ name = "soulcage spell", interval = 2000, chance = 20, range = 10 },
	{ name = "soulcage mechanic", interval = 2000, chance = 5, range = 10 },
	{name ="ice chain", interval = 2000, chance = 20, minDamage = -900, maxDamage = -1100, range = 7},
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -600, maxDamage = -900, radius = 4, effect = CONST_ME_ICEAREA, target = false },
}

monster.defenses = {
	defense = 80, -- não confirmado
	armor = 80, -- não confirmado
	mitigation = 2.50, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
