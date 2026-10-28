local mType = Game.createMonsterType("Tamru the Black")
local monster = {}

monster.description = "Tamru the Black"
monster.experience = 16800
monster.outfit = {
	lookType = 1646,
	lookHead = 95,
	lookBody = 95,
	lookLegs = 57,
	lookFeet = 132,
	lookAddons = 3,
}


monster.health = 15500
monster.maxHealth = 15500
monster.race = "blood"
monster.corpse = 44043
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	rewardBoss = true,
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
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {

	{ name = "Platinum Coin", chance = 59350, maxCount = 32 },
	{id = 43901, chance = 150},
	{name = "blue robe", chance = 20000},
	{id = 43732, chance = 12000, maxCount = 1},
	{id = 43739, chance = 20000, maxCount = 1},
	{id = 3028, chance = 20000, maxCount = 1},
	{id = 3037, chance = 20000, maxCount = 1},
	{id = 22083, chance = 5000, maxCount = 1},
	{id = 43736, chance = 8000, maxCount = 1},
	{id = 43730, chance = 12000, maxCount = 2},
	{name = "noble axe", chance = 20000, maxCount = 1},
	{name = "crystal mace", chance = 12000},
	-- { id = 22721, chance = 50000 }, -- gold token

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{name = "combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -145, maxDamage = -400, range = 3, effect = CONST_ME_ENERGYHIT, target = false},
	{name = "combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -310, maxDamage = -800, radius = 5, range = 5, shooteffect = CONST_ANI_LARGEROCK, effect = CONST_ME_STONE_STORM, target = true},
	{name = "energy ring", interval = 1000, chance = 8, minDamage = -200, maxDamage = -550, range = 4, target = false},
	{name = "giant ice ring", interval = 2000, chance = 18, minDamage = -220, maxDamage = -540, range = 6, target = false},
	{name = "mana drain chain", interval = 2000, chance = 16, minDamage = -300, maxDamage = -650, target = true}

}

monster.defenses = {
	defense = 60,
	armor = 78,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 50 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
