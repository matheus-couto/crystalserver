local mType = Game.createMonsterType("Frosthorn")
local monster = {}

monster.description = "a frosthorn"
monster.experience = 21800
monster.outfit = {
	lookType = 842,
	lookHead = 0,
	lookBody = 86,
	lookLegs = 0,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 26500
monster.maxHealth = 26500
monster.race = "undead"
monster.corpse = 33905
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 8
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
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 3065, maxCount = 3 },
	{name = "platinum coin", chance = 11000, maxCount = 44},
	{name = "glowing rune", chance = 800, maxCount = 3},
	{name = "small sapphire", chance = 900, maxCount = 4},
	{name = "frosty heart", chance = 11000, maxCount = 4},
	{id = 7441, chance = 20000}, -- ice cube
	{name = "ultimate health potion", chance = 10003, maxCount = 4},
	{name = "supreme health potion", chance = 10003, maxCount = 2},
	{name = "ultimate mana potion", chance = 10003, maxCount = 4},
	{name = "glacier mask", chance = 1000},
	{name = "glacier robe", chance = 1000},
	{name = "glacier kilt", chance = 1000},
	{name = "crystalline armor", chance = 400},
	{name = "piece of dead brain", chance = 5000, maxCount = 3}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -400, maxDamage = -700},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -350, maxDamage = -900, range = 7, shootEffect = CONST_ANI_ICE, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -290, maxDamage = -780, range = 7, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -775, length = 3, spread = 2, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -380, maxDamage = -980, range = 7, radius = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICETORNADO, target = false}
}

monster.defenses = {
	defense = 40,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 380, maxDamage = 595, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
