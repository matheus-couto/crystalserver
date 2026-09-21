local mType = Game.createMonsterType("Crystal Guardian")
local monster = {}

monster.description = "a crystal guardian"
monster.experience = 8100
monster.outfit = {
	lookType = 304,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 7000
monster.maxHealth = 7000
monster.race = "venom"
monster.corpse = 8887
monster.speed = 80
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 3,
	color = 35,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "INTRUDER ALARM!", yell = true },
	{ text = "klonk klonk klonk", yell = false },
	{ text = "Rrrtttarrrttarrrtta", yell = false },
	{ text = "Awaiting orders.", yell = false },
	{ text = "Secret objective complete.", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ id = 3043, chance = 20000, maxCount = 1 }, 
	{ name = "small diamond", chance = 10000, maxCount = 2 },
	{ name = "gold coin", chance = 43000, maxCount = 100 },
	{ name = "gold coin", chance = 50000, maxCount = 40 },
	{ name = "might ring", chance = 370 },
	{ name = "life crystal", chance = 1890 },
	{ name = "iron ore", chance = 2001 },
	{ name = "bonebreaker", chance = 130 },
	{ name = "berserk potion", chance = 820 },
	{ id = 238, chance = 3470 },
	{ name = "great health potion", chance = 4100 },
	{ name = "great spirit potion", chance = 1830 },
	{ name = "gear wheel", chance = 2007 },
	{ id = 9066, chance = 2270 }, -- crystal pedestal
	{ name = "gear crystal", chance = 2270 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -740 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -525, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -800, range = 8, radius = 4, effect = CONST_ME_HITAREA, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 35,
	mitigation = 1.32,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 400, maxDamage = 450, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
