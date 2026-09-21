local mType = Game.createMonsterType("Ancient Leiden")
local monster = {}

monster.description = "Ancient Leiden"
monster.experience = 1000000
monster.outfit = {
	lookType = 988,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 800000
monster.maxHealth = 800000
monster.race = "blood"
monster.corpse = 0
monster.speed = 320
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 20,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"LeidenHeal",
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{ name = "Enraged Carnisylvan", chance = 20, interval = 2000, count = 1 },
		{ name = "Enraged Carnisylvan", chance = 20, interval = 2000, count = 1 },
	},
}


monster.loot = {
	{ name = "gold coin", chance = 87970, maxCount = 212 },
	{ id = 3035, chance = 32840, maxCount = 58 }, 
	{ id = 3043, chance = 900, maxCount = 1 }, 
	{ id = 30061, chance = 25000, maxCount = 1 },
	{ id = 30060, chance = 25000, maxCount = 1 },
	{ id = 7643, chance = 25000, maxCount = 11 },
	{ id = 23373, chance = 25000, maxCount = 11 },
	{ id = 23374, chance = 25000, maxCount = 11 },
	{ id = 11587, chance = 2000, maxCount = 1 },
	{ id = 22516, chance = 25000, maxCount = 3 },
	{ id = 22721, chance = 50000, maxCount = 2 },
	{ id = 33306, chance = 250, maxCount = 1, unique = true }, -- MARBLE
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -550, maxDamage = -850, radius = 3, effect = CONST_ME_POFF, radius = 4, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -1400, range = 4, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_BLACKSMOKE, target = true },
	{ name = "death chain", interval = 2000, chance = 25, range = 6, minDamage = -1400, maxDamage = -2000, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 35,
	--	mitigation = ???,
		{ name = "ultimate healing", interval = 2000, chance = 20, minDamage = 600, maxDamage = 1200, target = false },
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 10 },
	{ type = COMBAT_MANADRAIN, percent = 10 },
	{ type = COMBAT_DROWNDAMAGE, percent = 10 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
