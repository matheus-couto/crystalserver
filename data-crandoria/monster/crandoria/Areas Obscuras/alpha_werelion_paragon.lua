local mType = Game.createMonsterType("Afflicted Alpha Werelion")
local monster = {}

monster.description = "an afflicted aplha werelion"
monster.experience = 20900
monster.outfit = {
	lookType = 1301,
	lookHead = 58,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 19800
monster.maxHealth = 19800
monster.race = "blood"
monster.corpse = 33825
monster.speed = 220
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "platinum coin", chance = 100000, maxCount = 5 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ name = "great spirit potion", chance = 100000, maxCount = 2 },
	{ name = "small enchanted ruby", chance = 6000, maxCount = 2 },
	{ name = "meat", chance = 5000, maxCount = 2 },
	{ name = "crystal sword", chance = 6000 },
	{ name = "lion's mane", chance = 6500 },
	{ name = "silver brooch", chance = 2500 },
	{ name = "small diamond", chance = 2500, maxCount = 4 },
	{ name = "war hammer", chance = 2500 },
	{ name = "doublet", chance = 2500 },
	{ name = "dark shield", chance = 2500 },
	{ name = "titan axe", chance = 2000 },
	{ name = "spiked squelcher", chance = 2000 },
	{ name = "glorious axe", chance = 2000 },
	{ name = "spirit cloak", chance = 2000 },
	{ name = "onyx chip", chance = 2000 },
	{ name = "coral brooch", chance = 2000 },
	{ name = "ivory carving", chance = 2000 },
	{ name = "rainbow quartz", chance = 2000 },
	{ name = "noble axe", chance = 1000 },
	{ name = "white silk flower", chance = 500 },
	{ name = "lion figurine", chance = 130 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -650 },
	{ name = "werelion wave", interval = 2000, chance = 20, minDamage = -350, maxDamage = -550, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HOLYDAMAGE, minDamage = -480, maxDamage = -720, range = 3, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_HOLYDAMAGE, minDamage = -330, maxDamage = -490, range = 3, shootEffect = CONST_ANI_HOLY, target = true },
}

monster.defenses = {
	defense = 85,
	armor = 99,
	mitigation = 0.98,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 55 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
