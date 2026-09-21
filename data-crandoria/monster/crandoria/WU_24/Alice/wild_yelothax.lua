local mType = Game.createMonsterType("Wild Yielothax")
local monster = {}

monster.description = "a wild yielothax"
monster.experience = 39250
monster.outfit = {
	lookType = 408,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 717
monster.Bestiary = {
	class = "Extra Dimensional",
	race = BESTY_RACE_EXTRA_DIMENSIONAL,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Na dimensao da Rainha de Copas",
}

monster.health = 32500
monster.maxHealth = 32500
monster.race = "venom"
monster.corpse = 12595
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10,
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
	canPushCreatures = true,
	staticAttackChance = 75,
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
	{ text = "IIEEH!! Iiih iih ih iiih!!!", yell = false },
	{ text = "Bsssssssm Bssssssm Bsssssssssssm!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 45000, maxCount = 36 },
	{ id = 3043, chance = 2000, maxCount = 1 },
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 238, chance = 25000, maxCount = 2},
	{ id = 239, chance = 25000, maxCount = 3},
	{ id = 7643, chance = 15000, maxCount = 1},
	{ id = 23373, chance = 15000, maxCount = 1},
	{ id = 23374, chance = 15000, maxCount = 2},
	{ id = 7642, chance = 25000, maxCount = 2},
--	{ id = 43733, chance = 10 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = -500, maxDamage = -1000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -890, length = 5, range = 8, spread = 3, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_MANADRAIN, minDamage = -250, maxDamage = -450, length = 4, range = 6, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 1500, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -350, maxDamage = -1300, radius = 5, range = 6, effect = CONST_ME_MORTAREA, target = false },

}

monster.defenses = {
	defense = 30,
	armor = 30,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 350, maxDamage = 800, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
