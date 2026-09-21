local mType = Game.createMonsterType("Bruxa Insana")
local monster = {}

monster.description = "a bruxa insana"
monster.experience = 8000
monster.outfit = {
	lookType = 54,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 6500
monster.maxHealth = 6500
monster.race = "undead"
monster.corpse = 18254
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 8,
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 4,
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ id = 3043, chance = 500, maxCount = 1 },
	{ id = 3594, chance = 1150, minCount = 1, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -400, condition = { type = CONDITION_POISON, totalDamage = 500, interval = 4000 } },
	{ name = "combat", interval = 1500, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -525, range = 6, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true },
	{ name = "death chain", interval = 2500, chance = 25, minDamage = -200, maxDamage = -500, range = 6, target = true },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -300, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = false },
	{ name = "outfit", interval = 3500, chance = 20, range = 7, radius = 4, effect = CONST_ME_MAGIC_BLUE, target = true, duration = 4000, outfitMonster = "skeleton" },
	{ name = "outfit", interval = 3500, chance = 20, range = 7, radius = 4, effect = CONST_ME_MAGIC_BLUE, target = true, duration = 4000, outfitMonster = "ghoul" },
	{ name = "outfit", interval = 3500, chance = 20, range = 7, radius = 4, effect = CONST_ME_MAGIC_BLUE, target = true, duration = 4000, outfitMonster = "ghost" },
}

monster.defenses = {
	defense = 43,
	armor = 63,
	mitigation = 0.88,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 60 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
