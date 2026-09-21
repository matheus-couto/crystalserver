local mType = Game.createMonsterType("Guinea Pig Gladiator")
local monster = {}

monster.description = "a guinea pig gladiator"
monster.experience = 4800
monster.outfit = {
	lookType = 131,
	lookHead = 78,
	lookBody = 3,
	lookLegs = 94,
	lookFeet = 114,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1108 -- MUDAR
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Guinea Pig Gladiator - Trivallis.",
}

monster.health = 4100
monster.maxHealth = 4100
monster.race = "blood"
monster.corpse = 18126
monster.speed = 150
monster.manaCost = 470

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "You are no match for me!", yell = false },
	{ text = "Feel my prowess.", yell = false },
	{ text = "Fight!", yell = false },
	{ text = "Take this!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 49500, maxCount = 30 },
	{ id = 3035, chance = 33000, maxCount = 8},
	{ id = 3264, chance = 22620 }, -- sword
	{ id = 3271, chance = 19620 },
	{ name = "mace", chance = 11160 },
	{ id = 3356, chance = 15200 },
	{ name = "steel shield", chance = 18400 },
	{ id = 3322, chance = 15300},
	{ name = "meat", chance = 19000 },
	{ name = "belted cape", chance = 13400 },
	{ id = 9057, chance = 23400, maxCount = 6 },
	{ id = 3557, chance = 22100},
	{ id = 11444, chance = 8000},
	{ id = 3428, chance = 12000},
	{ id = 3362, chance = 18000},
	{ id = 239, chance = 16000, maxCount = 2},
	{ id = 238, chance = 15000},
	{ id = 3267, chance = 33000},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -320 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -120, maxDamage = -300, range = 5, radius = 4, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -110, maxDamage = -250, effect = CONST_ME_MORTAREA, range = 1, target = true},
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -90, maxDamage = -300, effect = CONST_ME_SLASH, shootEffect = CONST_ANI_THROWINGKNIFE, range = 4, target = false}
}

monster.defenses = {
	defense = 35,
	armor = 44,
	mitigation = 0.78,
	{ name = "speed", interval = 2000, chance = 15, speedChange = 215, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
