local mType = Game.createMonsterType("Lost Bashmu")
local monster = {}

monster.description = "a lost bashmu"
monster.experience = 12500
monster.outfit = {
	lookType = 1408,
	lookHead = 0,
	lookBody = 132,
	lookLegs = 3,
	lookFeet = 79,
	lookAddons = 1,
	lookMount = 0,
}


monster.health = 16200
monster.maxHealth = 16200
monster.race = "blood"
monster.corpse = 36967
monster.speed = 190
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
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 1,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "platinum coin", chance = 70000, maxCount = 25 },
	{ name = "platinum coin", chance = 30000, maxCount = 25 },
	{ id = 3043, chance = 1290, maxCount = 1 },
	{ id = 29995, chance = 500, maxCount = 1 },
	{ name = "great spirit potion", chance = 14700, maxCount = 4 },
	{ name = "ultimate health potion", chance = 1300, maxCount = 6 },
	{ name = "blue crystal shard", chance = 9160, maxCount = 5 },
	{ name = "bashmu tongue", chance = 7840, maxCount = 3 },
	{ name = "bashmu feather", chance = 8620, maxCount = 2 },
	{ name = "green crystal shard", chance = 8666 },
	{ name = "cyan crystal fragment", chance = 6340 },
	{ id = 3039, chance = 4390, maxCount = 1 }, -- red gem
	{ name = "violet gem", chance = 4340, maxCount = 1 },
	{ name = "lightning legs", chance = 3230 },
	{ name = "diamond sceptre", chance = 3180 },
	{ name = "lightning pendant", chance = 3180 },
	{ name = "bashmu fang", chance = 4120 },
	{ name = "yellow gem", chance = 3070 },
	{ name = "war hammer", chance = 2540 },
	{ name = "violet crystal shard", chance = 3490 },
	{ name = "dragonbone staff", chance = 2430 },
	{ name = "amber staff", chance = 3270 },
	{ name = "green gem", chance = 4220 },
	{ name = "spellweaver's robe", chance = 2110 },
	{ name = "pair of iron fists", chance = 2010 },
	{ name = "skull staff", chance = 1260 },
	{ name = "crystal mace", chance = 1500 },
	{ name = "chaos mace", chance = 1530 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1400 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -1000, length = 4, spread = 0, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -1200, range = 3, radius = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -700, maxDamage = -1150, range = 7, shootEffect = CONST_ANI_EARTHARROW, target = true },
}

monster.defenses = {
	defense = 75,
	armor = 75,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 300, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
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
