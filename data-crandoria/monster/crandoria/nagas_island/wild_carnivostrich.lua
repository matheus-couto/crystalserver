local mType = Game.createMonsterType("Wild Carnivostrich")
local monster = {}

monster.description = "a wild carnivostrich"
monster.experience = 10200
monster.outfit = {
	lookType = 1605,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2341
monster.Bestiary = {
	class = "Bird",
	race = BESTY_RACE_BIRD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Ingol",
}

monster.health = 11250
monster.maxHealth = 11250
monster.race = "blood"
monster.corpse = 42226
monster.speed = 178
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 3,
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
	{ text = "Yooohhouuu!", yell = false },
	{ text = "GRROARR", yell = false },
	{ text = "Grrrrrrrr!", yell = false },
	{ text = "Yoooohhuuuu!!", yell = false },
}

monster.loot = {
--	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "platinum coin", chance = 80450, maxCount = 22 },
	{ name = "platinum coin", chance = 40450, maxCount = 42 },
	{ name = "small ruby", chance = 19390, maxCount = 8 },
	{ name = "small emerald", chance = 12330, maxCount = 8 },
	{ name = "ultimate mana potion", chance = 4910, maxCount = 2 },
	{ name = "ultimate health potion", chance = 4910, maxCount = 2 },
	{ name = "carnivostrich feather", chance = 4470, maxCount = 4 },
	{ name = "underworld rod", chance = 3420 },
	{ name = "wand of voodoo", chance = 3110 },
	{ name = "blue gem", chance = 4090 },
	{ name = "spellbook of mind control", chance = 1810 },
	{ name = "boots of haste", chance = 1120 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -900, condition = { type = CONDITION_POISON, totalDamage = 480, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -486, maxDamage = -780, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = true },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -735, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -550, maxDamage = -895, length = 7, spread = 0, effect = CONST_ME_BLACKSMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -480, maxDamage = -920, length = 7, spread = 0, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "energy chain", interval = 2000, chance = 20, minDamage = -402, maxDamage = -809, range = 3, target = true },
	{ name = "thunderstorm ring", interval = 2000, chance = 20, minDamage = -325, maxDamage = -615 },
}

monster.defenses = {
	defense = 50,
	armor = 63,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
