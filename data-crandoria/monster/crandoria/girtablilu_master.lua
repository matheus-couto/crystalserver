local mType = Game.createMonsterType("Girtablilu Master")
local monster = {}

monster.description = "a girtablilu master"
monster.experience = 18800
monster.outfit = {
	lookType = 1407,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 113,
	lookFeet = 114,
	lookAddons = 2,
	lookMount = 0
}

monster.health = 16500
monster.maxHealth = 16500
monster.race = "blood"
monster.corpse = 36800
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
	{text = "Tip tap tip tap!", yell = false}
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{name = "platinum coin", chance = 70000, maxCount = 25},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{name = "ultimate health potion", chance = 15360, maxCount = 4},
	{name = "gold ingot", chance = 14130, maxCount = 2},
	{name = "green crystal shard", chance = 6420, maxCount = 3},
	{name = "red crystal fragment", chance = 5830, maxCount = 3},
	{name = "girtablilu warrior carapace", chance = 4650, maxCount = 1},
	{name = "cyan crystal fragment", chance = 4530, maxCount = 3},
	{name = "scorpion charm", chance = 5240},
	{name = "green gem", chance = 5060},
	{name = "violet gem", chance = 5410},
	{name = "blue crystal shard", chance = 3880, maxCount = 3},
	{name = "crowbar", chance = 2830},
	{name = "diamond sceptre", chance = 2590},
	{name = "violet crystal shard", chance = 4470},
	{name = "yellow gem", chance = 4350},
	{name = "ice rapier", chance = 4240},
	{name = "magma coat", chance = 4180},
	{name = "epee", chance = 4120},
	{name = "dragonbone staff", chance = 4000},
	{name = "knight axe", chance = 4000},
	{name = "beastslayer axe", chance = 1940},
	{name = "green crystal fragment", chance = 1710},
	{name = "blue gem", chance = 1530},
	{id = 3039, chance = 1530}, -- red gem
	{name = "blue robe", chance = 1060},
	{name = "blue robe", chance = 1060},
	{name = "focus cape", chance = 1060},
	{id = 36972, chance = 1530}, -- red gem
	{id = 17823, chance = 4500, maxCount = 2}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -650},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -850, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -350, maxDamage = -650, range = 5, shootEffect = CONST_ANI_POISONARROW, target = true},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -600, length = 3, spread = 2, effect = CONST_ME_GREEN_RINGS, target = false}
}

monster.defenses = {
	defense = 76,
	armor = 76,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 250, maxDamage = 750, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -15},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = -15},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
