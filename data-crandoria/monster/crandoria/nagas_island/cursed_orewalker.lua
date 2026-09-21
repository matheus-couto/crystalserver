local mType = Game.createMonsterType("Cursed Orewalker")
local monster = {}

monster.description = "a cursed orewalker"
monster.experience = 11450
monster.outfit = {
	lookType = 490,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 12100
monster.maxHealth = 12100
monster.race = "undead"
monster.corpse = 15911
monster.speed = 200
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
	nearest = 80,
	random = 20,
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
	staticAttackChance = 80,
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
	{ text = "CLONK!", yell = true },
}

monster.loot = {
--	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 50000, maxCount = 100 },
	{ name = "platinum coin", chance = 40, maxCount = 98 },
	{ name = "platinum coin", chance = 100000, maxCount = 45 },
	{ name = "yellow gem", chance = 3030 },
	{ id = 3097, chance = 4660 }, -- dwarven ring
	{ name = "knight legs", chance = 3910 },
	{ name = "crown armor", chance = 2370 },
	{ name = "crown helmet", chance = 2890 },
	{ name = "iron ore", chance = 15000 },
	{ name = "magic sulphur", chance = 4000 },
	{ name = "titan axe", chance = 3600 },
	{ name = "glorious axe", chance = 2870 },
	{ name = "ultimate health potion", chance = 15600, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 14000, maxCount = 2 },
	{ id = 238, chance = 14000, maxCount = 4 },
	{ name = "crystalline armor", chance = 1560 },
	{ name = "small topaz", chance = 16500, maxCount = 6 },
	{ name = "shiny stone", chance = 13700 },
	{ name = "sulphurous stone", chance = 20700 },
	{ name = "wand of defiance", chance = 2300 },
	{ name = "green crystal shard", chance = 10000 },
	{ name = "blue crystal splinter", chance = 18000, maxCount = 2 },
	{ name = "cyan crystal fragment", chance = 16000 },
	{ name = "pulverized ore", chance = 20500 },
	{ name = "vein of ore", chance = 18000 },
	{ name = "prismatic bolt", chance = 15500, maxCount = 9 },
	{ name = "crystal crossbow", chance = 400 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1300 },
	{ name = "orewalker wave", interval = 2000, chance = 15, minDamage = -796, maxDamage = -1100, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -1500, length = 6, spread = 3, effect = CONST_ME_GROUNDSHAKER, target = false },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 20, minDamage = -800, maxDamage = -1280, radius = 3, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = true },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -800, radius = 2, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },
}

monster.defenses = {
	defense = 45,
	armor = 79,
	mitigation = 2.31,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 45 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 25 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
