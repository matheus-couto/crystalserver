local mType = Game.createMonsterType("Afflicted Werelion")
local monster = {}

monster.description = "an afflicted werelion"
monster.experience = 18200
monster.outfit = {
	lookType = 1301,
	lookHead = 58,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 10,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 15800
monster.maxHealth = 15800
monster.race = "blood"
monster.corpse = 33825
monster.speed = 210
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
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ name = "great spirit potion", chance = 100000, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 5000, maxCount = 2 },
	{ name = "meat", chance = 5000, maxCount = 2 },
	{ name = "crystal sword", chance = 5000 },
	{ name = "lion's mane", chance = 5000 },
	{ name = "silver brooch", chance = 1500 },
	{ name = "small diamond", chance = 1500, maxCount = 2 },
	{ name = "war hammer", chance = 1500 },
	{ name = "doublet", chance = 1500 },
	{ name = "dark shield", chance = 1500 },
	{ name = "titan axe", chance = 1500 },
	{ name = "spiked squelcher", chance = 1500 },
	{ name = "glorious axe", chance = 1500 },
	{ name = "spirit cloak", chance = 1500 },
	{ name = "onyx chip", chance = 1500 },
	{ name = "coral brooch", chance = 1500 },
	{ name = "ivory carving", chance = 1500 },
	{ name = "rainbow quartz", chance = 1500 },
	{ name = "noble axe", chance = 500 },
	{ name = "white silk flower", chance = 500 },
	{ name = "lion figurine", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "werelion wave", interval = 2000, chance = 20, minDamage = -250, maxDamage = -350, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -200, maxDamage = -610, range = 3, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -270, maxDamage = -480, range = 3, shootEffect = CONST_ANI_HOLY, target = true },
}

monster.defenses = {
	defense = 40,
	armor = 38,
	mitigation = 0.91,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 100, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 45 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
