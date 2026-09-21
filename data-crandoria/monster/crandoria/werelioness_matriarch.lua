local mType = Game.createMonsterType("Werelioness Matriarch")
local monster = {}

monster.description = "a werelioness matriarch"
monster.experience = 5600
monster.outfit = {
	lookType = 1301,
	lookHead = 0,
	lookBody = 2,
	lookLegs = 0,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 5500
monster.maxHealth = 5500
monster.race = "blood"
monster.corpse = 34185
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 20,
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
	runHealth = 5,
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ name = "gold coin", chance = 100000, maxCount = 60 },
	{ name = "small enchanted sapphire", chance = 6000, maxCount = 3 },
	{ name = "black pearl", chance = 5000, maxCount = 3 },
	{ name = "ham", chance = 5000, maxCount = 4 },
	{ name = "meat", chance = 5000, maxCount = 2 },
	{ name = "soul orb", chance = 5000, maxCount = 2 },
	{ name = "white pearl", chance = 1500, maxCount = 4 },
	{ name = "ankh", chance = 5000 },
	{ name = "crystal sword", chance = 6000 },
	{ name = "serpent sword", chance = 6000 },
	{ name = "rapier", chance = 6000 },
	{ name = "lion's mane", chance = 6000 },
	{ name = "lightning headband", chance = 2500 },
	{ name = "steel helmet", chance = 2000 },
	{ name = "doublet", chance = 1500 },
	{ name = "ivory carving", chance = 2000 },
	{ name = "magma legs", chance = 700 },
	{ name = "crown helmet", chance = 800 },
	{ name = "white silk flower", chance = 250 },
	{ name = "lion figurine", chance = 130 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -450 },
	{ name = "combat", interval = 2200, chance = 12, type = COMBAT_HOLYDAMAGE, minDamage = -350, maxDamage = -490, range = 3, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2100, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -250, maxDamage = -450, range = 3, shootEffect = CONST_ANI_HOLY, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -280, maxDamage = -390, length = 4, spread = 1, effect = CONST_ME_FIREAREA, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 49,
	mitigation = 0.91,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 140, maxDamage = 180, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 55 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
