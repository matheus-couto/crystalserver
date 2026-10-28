local mType = Game.createMonsterType("Myzareth's Soulcage")
local monster = {}

monster.description = "Myzareth's soulcage"
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
	canPushItems = false,
	canPushCreatures = false,
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
		{ name = "Myzareth's Spirit", chance = 100, interval = 2000, count = 1 },
	},
}

monster.attacks = {
	-- { "soulcage curse", interval = 2000, chance = 20, range = 10 },
	{ name = "soulcage spell", interval = 2000, chance = 20, range = 10 },
	{ name = "soulcage mechanic", interval = 2000, chance = 5, range = 10 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = 1400, range = 8, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = 1500, range = 8, radius = 4, effect = CONST_ME_ELECTRICALSPARK, target = false },
	{ name = "energy chain", interval = 2000, chance = 15, minDamage = -825, maxDamage = -1450, range = 6, target = true },

	-- { name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -900, radius = 4, effect = CONST_ME_SMALLCLOUDS, target = false }, -- não confirmado
	-- { name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1200, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false }, -- não confirmado
	-- { name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1000, radius = 4, effect = CONST_ME_ENERGYAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 80, -- não confirmado
	armor = 80, -- não confirmado
	mitigation = 2.50, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
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
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
