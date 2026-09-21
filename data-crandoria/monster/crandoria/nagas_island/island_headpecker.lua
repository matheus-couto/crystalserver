local mType = Game.createMonsterType("Island Headpecker")
local monster = {}

monster.description = "an island headpecker"
monster.experience = 11000
monster.outfit = {
	lookType = 1557,
	lookHead = 85,
	lookBody = 1,
	lookLegs = 85,
	lookFeet = 105,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 12150
monster.maxHealth = 12150
monster.race = "blood"
monster.corpse = 39319
monster.speed = 217
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 70,
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
--	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "Crystal Coin", chance = 35160 },
	{ name = "Headpecker Beak", chance = 14360 },
	{ name = "Headpecker Feather", chance = 9620, minCount = 1, maxCount = 5 },
	{ name = "Furry Club", chance = 8560 },
	{ id = 3595, chance = 6950, minCount = 1, maxCount = 3 }, -- Carrot
	{ name = "Knife", chance = 4260 },
	{ name = "Spike Sword", chance = 4040 },
	{ name = "War Hammer", chance = 4290 },
	{ name = "Titan Axe", chance = 2720 },
	{ name = "Blue Gem", chance = 3560 },
	{ name = "Wand of Starstorm", chance = 1980 },
	{ name = "Gold Ingot", chance = 1910 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 },
	{ name = "combat", interval = 2500, chance = 37, type = COMBAT_EARTHDAMAGE, minDamage = -820, maxDamage = -1300, range = 1, effect = CONST_ME_BLACKSMOKE, target = true },
	{ name = "combat", interval = 4200, chance = 35, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -1350, length = 4, spread = 3, effect = CONST_ME_SLASH, target = false },
	{ name = "headpecker explosion", interval = 3500, chance = 35, minDamage = -750, maxDamage = -1050 },
}

monster.defenses = {
	defense = 100,
	armor = 68,
	mitigation = 2.05,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
