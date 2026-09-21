local mType = Game.createMonsterType("Afflicted Frosthorn")
local monster = {}

monster.description = "an afflicted frosthorn"
monster.experience = 51800
monster.outfit = {
	lookType = 842,
	lookHead = 0,
	lookBody = 86,
	lookLegs = 0,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 56500
monster.maxHealth = 56500
monster.race = "undead"
monster.corpse = 33905
monster.speed = 285
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
	canWalkOnFire = true,
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
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{name = "platinum coin", chance = 11000, maxCount = 44},
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ id = 3043, chance = 1000, maxCount = 1 },
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
	{name ="melee", interval = 2000, chance = 100, minDamage = -400, maxDamage = -800},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -350, maxDamage = -900, range = 7, shootEffect = CONST_ANI_ICE, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -390, maxDamage = -880, range = 7, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -300, maxDamage = -975, length = 3, spread = 2, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_ICEDAMAGE, minDamage = -380, maxDamage = -1080, range = 7, radius = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICETORNADO, target = false}
}

monster.defenses = {
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 380, maxDamage = 595, effect = CONST_ME_MAGIC_BLUE, target = false },
	defense = 40,
	armor = 78
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
