local mType = Game.createMonsterType("Ancient Spawn of Morgathla")
local monster = {}

monster.description = "Ancient Spawn Of Morgathla"
monster.experience = 70000
monster.outfit = {
	lookType = 1055,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"morgathlaHealth",
}

monster.bosstiary = {
	bossRaceId = 1551,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 900000
monster.maxHealth = 900000
monster.race = "blood"
monster.corpse = 21004
monster.speed = 155
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4,
}

monster.strategiesTarget = {
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
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 3031, chance = 100000, maxCount = 198 }, -- gold coin
	{ id = 3035, chance = 67610, maxCount = 100 }, -- platinum coin
	{ id = 3043, chance = 65000, maxCount = 3},
	{ id = 9058, chance = 390 }, -- gold ingot
	{ id = 5911, chance = 3230 }, -- red piece of cloth
	{ id = 16119, chance = 45000, maxCount = 10 },
	{ id = 3041, chance = 45000, maxCount = 2 },
	{ id = 16121, chance = 45000, maxCount = 11 },
	{ id = 3038, chance = 45000, maxCount = 2 },
	{ id = 5892, chance = 25000, maxCount = 4 },
	{ id = 5904, chance = 25000, maxCount = 10 },
	{ id = 7440, chance = 25000, maxCount = 3 },
	{ id = 3039, chance = 45000, maxCount = 2 },
	{ id = 3042, chance = 65000, maxCount = 75 },
	{ id = 3033, chance = 45000, maxCount = 29 },
	{ id = 3028, chance = 25000, maxCount = 20 },
	{ id = 3032, chance = 25000, maxCount = 20 },
	{ id = 3030, chance = 25000, maxCount = 20 },
	{ id = 9057, chance = 25000, maxCount = 36 },
	{ id = 16120, chance = 25000, maxCount = 8 },
	{ id = 3037, chance = 25000, maxCount = 2 },
	{ id = 3328, chance = 25000 },
	{ id = 9631, chance = 20000 },
	{ id = 3440, chance = 10000 },
	{ id = 239, chance = 11480, maxCount = 30 }, -- great health potion
	{ id = 238, chance = 10060, maxCount = 30 }, -- great mana potion
	{ id = 3577, chance = 7230 }, -- meat
	{ name = "gold token", chance = 30000, maxCount = 2 },
	{ name = "silver token", chance = 30000, maxCount = 2 },
	{ id = 7428, chance = 5000 },
	{ id = 3339, chance = 5000 },
	{ id = 5891, chance = 4000 },
	{ id = 21981, chance = 4000 },
	{ id = 8084, chance = 5000 },
	{ id = 830, chance = 5000 },
	{ id = 811, chance = 5000 },
	{ id = 812, chance = 5000 },
	{ id = 8082, chance = 4000 },
	{ id = 13998, chance = 900 },
	{ id = 50176, chance = 900 },
	{ id = 12304, chance = 900 },
	{ id = 27655, chance = 800 },
	{ id = 3331, chance = 800 },
	{ id = 12509, chance = 500, unique = true },
	{ id = 27605, chance = 300 },
	{ id = 27657, chance = 300 },
	{ id = 8054, chance = 300 },
	{ id = 8053, chance = 300 },
	{ id = 8062, chance = 300 },
	{ id = 27656, chance = 300 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 100 },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_LIFEDRAIN, minDamage = -435, maxDamage = -900, range = 7, radius = 5, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_HITAREA, target = true },
	{ name = "combat", interval = 2000, chance = 8, type = COMBAT_PHYSICALDAMAGE, minDamage = -550, maxDamage = -2000, range = 7, shootEffect = CONST_ANI_WHIRLWINDAXE, effect = CONST_ME_EXPLOSIONAREA, target = true },
}

monster.defenses = {
	defense = 130,
	armor = 130,
	--	mitigation = ???,
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
