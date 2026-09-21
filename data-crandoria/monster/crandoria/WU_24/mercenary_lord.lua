local mType = Game.createMonsterType("Mercenary Lord")
local monster = {}

monster.description = "a mercenary lord"
monster.experience = 11000
monster.outfit = {
	lookType = 1316,
	lookHead = 57,
	lookBody = 43,
	lookLegs = 43,
	lookFeet = 116,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 15100
monster.maxHealth = 15100
monster.race = "blood"
monster.corpse = 33969
monster.speed = 150
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
	targetDistance = 5,
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
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 22000, maxCount = 11 },
	{ name = "strong mana potion", chance = 33000, maxCount = 1 },
	{ name = "ultimate health potion", chance = 8000 },
	{ id = 238, chance = 33000 },
	{ name = "bread", chance = 9000 },
	{ name = "dark mushroom", chance = 3000 },
	{ name = "swamplair armor", chance = 2100 },
	{ id = 11549, chance = 10000 },
	{ id = 40535, chance = 250 }
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 1500, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -450, maxDamage = -700, range = 7, shootEffect = CONST_ANI_INFERNALBOLT, target = true },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -800, range = 7, radius = 4, shootEffect = CONST_ANI_DIAMONDARROW, effect = CONST_ME_HITAREA, target = true },
	{ name = "combat", interval = 4000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -900, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 86,
	armor = 50,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
