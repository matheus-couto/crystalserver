local mType = Game.createMonsterType("Bloodhand Pirate Marauder")
local monster = {}

monster.description = "a bloodhand pirate marauder"
monster.experience = 3000
monster.outfit = {
	lookType = 93,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1102 -- MUDAR
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Bloodhand Pirate Marauder - Trivallis.",
}

monster.health = 3150
monster.maxHealth = 3150
monster.race = "blood"
monster.corpse = 18202
monster.speed = 135
monster.manaCost = 490

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
	nearest = 100,
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
	{ text = "Plundeeeeer!", yell = false },
	{ text = "Hiyaa!", yell = false },
	{ text = "Give up!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ id = 2920, chance = 9880 }, -- torch
	{ name = "gold coin", chance = 77670, maxCount = 90 },
	{ name = "platinum coin", chance = 77670, maxCount = 4 },
	{ name = "royal spear", chance = 15140, maxCount = 2 },
	{ name = "plate armor", chance = 3000 },
	{ name = "tower shield", chance = 5000 },
	{ id = 5090, chance = 910 }, -- treasure map
	{ name = "rum flask", chance = 110 },
	{ id = 5792, chance = 190 }, -- die
	{ id = 239, chance = 33450, MaxCount = 1 },
	{ id = 7642, chance = 33450, MaxCount = 1 },
	{ name = "bandana", chance = 1400 },
	{ name = "pirate bag", chance = 730 },
	{ name = "empty goldfish bowl", chance = 100 },
	{ name = "hook", chance = 1120 },
	{ name = "eye patch", chance = 830 },
	{ name = "peg leg", chance = 1220 },
	{ name = "compass", chance = 15720 },
	{ id = 3030, chance = 9300, MaxCount = 4 },
	{ id = 5461, chance = 80 },
	{ name = "amulet of loss", chance = 50},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -800, range = 7, shootEffect = CONST_ANI_ROYALSPEAR, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 30,
	mitigation = 0.56,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -3 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
