local mType = Game.createMonsterType("Weakened Many Faces")
local monster = {}

monster.description = "a weakened many faces"
monster.experience = 10000
monster.outfit = {
	lookType = 1296,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 22000
monster.maxHealth = 22000
monster.race = "undead"
monster.corpse = 33805
monster.speed = 215
monster.manaCost = 0

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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
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
	{ text = "I have a head start.", yell = false },
	{ text = "Look into my eyes! No, the other ones!", yell = false },
	{ text = "The mirrors can't contain the night!", yell = false },
}

monster.loot = {
	-- -- { id = 3250, chance = 1975, maxCount = 1 },
	{ name = "crystal coin", chance = 7671 },
	{ name = "ultimate health potion", chance = 1492, maxCount = 7 },
	{ name = "apron", chance = 799 },
	{ name = "hailstorm rod", chance = 761 },
	{ name = "stone skin amulet", chance = 578 },
	{ name = "green gem", chance = 571 },
	{ name = "northwind rod", chance = 563 },
	{ name = "sacred tree amulet", chance = 556 },
	{ name = "violet gem", chance = 510 },
	{ name = "blue gem", chance = 502 },
	{ id = 23533, chance = 487 }, -- ring of red plasma
	{ id = 33932, chance = 350 }, -- head many faces
	{ name = "glacier shoes", chance = 251 },
	{ name = "glacier robe", chance = 213 },
	{ name = "gruesome fan", chance = 61 },
	{ name = "glacial rod", chance = 61 },
--	{ id = 34109, chance = 2 }, -- bag you desire
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900 },
	{ name = "combat", interval = 4000, chance = 33, type = COMBAT_ICEDAMAGE, minDamage = -520, maxDamage = -800, range = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 5000, chance = 44, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -850, range = 7, radius = 5, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 9500, chance = 59, type = COMBAT_HOLYDAMAGE, minDamage = -750, maxDamage = -900, radius = 4, effect = CONST_ME_HOLYAREA, target = false },
	{ name = "extended holy chain", interval = 10000, chance = 59, minDamage = -550, maxDamage = -900, range = 7 },
}

monster.defenses = {
	defense = 85,
	armor = 65,
	mitigation = 2.34,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = -30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
