local mType = Game.createMonsterType("Ironhook Pirate Corsair")
local monster = {}

monster.description = "a ironhook pirate corsair"
monster.experience = 8000
monster.outfit = {
	lookType = 98,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1103 -- MUDAR
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 100,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Ironhook Pirate Corsair - Trivallis.",
}

monster.health = 7500
monster.maxHealth = 7500
monster.race = "blood"
monster.corpse = 18194
monster.speed = 119
monster.manaCost = 775

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
	{ text = "Hiyaa!", yell = false },
	{ text = "Give up!", yell = false },
	{ text = "Plundeeeeer!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "piggy bank", chance = 150 },
	{ name = "gold coin", chance = 50000, maxCount = 88 },
	{ name = "sabre", chance = 10000 },
	{ name = "assassin star", chance = 5400, maxCount = 6 },
	{ name = "plate armor", chance = 2550 },
	{ name = "dark shield", chance = 1900 },
	{ name = "pirate boots", chance = 320 },
	{ name = "rum flask", chance = 230 },
	{ id = 5813, chance = 130 }, -- skull candle
	{ name = "pirate backpack", chance = 930 },
	{ name = "pirate hat", chance = 1550 },
	{ name = "hook", chance = 900 },
	{ name = "eye patch", chance = 800 },
	{ name = "peg leg", chance = 900 },
	{ name = "great health potion", chance = 5820 },
	{ name = "compass", chance = 15050 },
	{ id = 3035, chance = 43500, maxCount = 9},
	{ id = 3043, chance = 200, maxCount = 1},
	{ id = 238, chance = 6800, maxCount = 1},
	{ id = 11492, chance = 2500, maxCount = 1},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -280, maxDamage = -900, range = 3, shootEffect = CONST_ANI_REDSTAR, target = false },
	{ name = "pirate corsair skill reducer", interval = 2000, chance = 5, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 48,
	mitigation = 1.46,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
