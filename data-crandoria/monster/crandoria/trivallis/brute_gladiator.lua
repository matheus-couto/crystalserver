local mType = Game.createMonsterType("Brute Burning Gladiator")
local monster = {}

monster.name = "Brute Burning Gladiator"

monster.description = "a brute burning gladiator"
monster.experience = 16200
monster.outfit = {
	lookType = 541,
	lookHead = 95,
	lookBody = 113,
	lookLegs = 3,
	lookFeet = 3,
	lookAddons = 2,
	lookMount = 0,
}

monster.raceId = 1780
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Brute Burning Gladiator - Trivallis.",
}

monster.health = 14000
monster.maxHealth = 14000
monster.race = "blood"
monster.corpse = 31646
monster.speed = 145
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
	staticAttackChance = 70,
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
	-- -- { id = 3250, chance = 1875, maxCount = 1 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ id = 3043, chance = 1300, maxCount = 1},
	{ name = "fafnar symbol", chance = 10600 },
	{ name = "dragon necklace", chance = 5700 },
	{ name = "lightning pendant", chance = 6100 },
	{ name = "magma amulet", chance = 4700 },
	{ name = "strange talisman", chance = 3000 },
	{ name = "magma boots", chance = 3700 },
	{ id = 31331, chance = 3400 }, -- empty honey glass
	{ name = "elven amulet", chance = 3100 },
	{ name = "lightning legs", chance = 3000 },
	{ name = "lightning headband", chance = 2100 },
	{ name = "lightning boots", chance = 1900 },
	{ name = "spellweaver's robe", chance = 950 },
	{ id = 31369, chance = 770 }, -- gryphon mask
	{ name = "sea horse figurine", chance = 240 },
	{ id = 3366, chance = 200 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -650 },
	{ name = "firering", interval = 2000, chance = 15, minDamage = -360, maxDamage = -590, target = false },
	{ name = "firex", interval = 2000, chance = 15, minDamage = -350, maxDamage = -590, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -620, radius = 2, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -380, maxDamage = -550, length = 3, spread = 0, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 92,
	mitigation = 2.45,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
