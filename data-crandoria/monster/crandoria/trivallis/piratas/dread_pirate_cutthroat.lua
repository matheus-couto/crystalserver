local mType = Game.createMonsterType("Dread Pirate Cutthroat")
local monster = {}

monster.description = "a dread pirate cutthroat"
monster.experience = 5000
monster.outfit = {
	lookType = 96,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1106 -- MUDAR
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Dread Pirate Cutthroat - Trivallis.",
}

monster.health = 4400
monster.maxHealth = 4400
monster.race = "blood"
monster.corpse = 18198
monster.speed = 130
monster.manaCost = 0

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

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 78000, maxCount = 90 },
	{ name = "platinum coin", chance = 53000, maxCount = 11 },
	{ name = "plate legs", chance = 4000 },
	{ name = "steel shield", chance = 2800 },
	{ id = 5090, chance = 1000 }, -- treasure map
	{ name = "rum flask", chance = 90 },
	{ name = "light shovel", chance = 2000 },
	{ id = 5792, chance = 110 }, -- die
	{ name = "pirate knee breeches", chance = 1280 },
	{ name = "pirate bag", chance = 1000 },
	{ name = "hook", chance = 950 },
	{ name = "eye patch", chance = 850 },
	{ name = "peg leg", chance = 900 },
	{ name = "compass", chance = 15120 },
	{ id = 3043, chance = 500, maxCount = 1},
	{ id = 3032, chance = 5200, maxCount = 6},
	{ id = 3155, chance = 2000, maxCount = 3},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800, condition = { type = CONDITION_POISON, totalDamage = 10, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -280, maxDamage = -900, range = 3, radius = 1, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_EXPLOSIONAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -500, range = 3, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 15,
	mitigation = 0.72,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
