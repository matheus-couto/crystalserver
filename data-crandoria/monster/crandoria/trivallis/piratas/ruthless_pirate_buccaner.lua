local mType = Game.createMonsterType("Ruthless Pirate Buccaneer")
local monster = {}

monster.description = "a ruthless pirate buccaneer"
monster.experience = 5200
monster.outfit = {
	lookType = 97,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1107 -- MUDAR
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Ruthless Pirate Buccaneer - Trivallis.",
}

monster.health = 4800
monster.maxHealth = 4800
monster.race = "blood"
monster.corpse = 18190
monster.speed = 145
monster.manaCost = 595

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
	{ text = "Give up!", yell = false },
	{ text = "Hiyaa", yell = false },
	{ text = "Plundeeeeer!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ id = 2920, chance = 10190 }, -- torch
	{ name = "gold coin", chance = 67740, maxCount = 59 },
	{ name = "platinum coin", chance = 47740, maxCount = 8 },
	{ name = "worn leather boots", chance = 9900 },
	{ name = "relic sword", chance = 2100 },
	{ name = "throwing knife", chance = 9000, maxCount = 8 },
	{ name = "knight armor", chance = 3130 },
	{ name = "tower shield", chance = 3850 },
	{ id = 5090, chance = 1000 }, -- treasure map
	{ name = "rum flask", chance = 120 },
	{ id = 5792, chance = 80 }, -- die
	{ name = "pirate backpack", chance = 930 },
	{ name = "pirate shirt", chance = 1400 },
	{ name = "hook", chance = 850 },
	{ name = "eye patch", chance = 820 },
	{ name = "peg leg", chance = 750 },
	{ name = "great health potion", chance = 8000, maxCount = 2 },
	{ name = "compass", chance = 15780 },
	{ id = 3043, chance = 600, maxCount = 1},
	{ id = 3028, chance = 3800, maxCount = 6},
	{ id = 3391, chance = 3500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -175, maxDamage = -550, range = 4, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -600, range = 2, effect = CONST_ME_SLASH, target = true },
}

monster.defenses = {
	defense = 48,
	armor = 45,
	mitigation = 1.04,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
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
