local mType = Game.createMonsterType("Elder Forest Fury")
local monster = {}

monster.description = "an elder forest fury"
monster.experience = 330
monster.outfit = {
	lookType = 569,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 670
monster.maxHealth = 670
monster.race = "blood"
monster.corpse = 19042
monster.speed = 130
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "To arms, sisters!", yell = false },
	{ text = "Feel the wrath of mother forest!", yell = false },
	{ text = "By the power of Greenskull!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "gold coin", chance = 87250, maxCount = 68 },
	{ name = "crossbow", chance = 8750 },
	{ name = "bolt", chance = 48270, maxCount = 15 },
	{ name = "meat", chance = 38930 },
	{ name = "piercing bolt", chance = 14900, maxCount = 5 },
	{ name = "elvish bow", chance = 950 },
	{ name = "small emerald", chance = 4470 },
	{ name = "elven hoof", chance = 11030 },
	{ name = "venison", chance = 13210 },
	{ name = "terra rod", chance = 3210 },
	{ name = "bullseye potion", chance = 1210 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -165 },
	{ name = "combat", interval = 1500, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -140, range = 7, radius = 4, shootEffect = CONST_ANI_HUNTINGSPEAR, effect = CONST_ME_MAGIC_GREEN, target = true },
	{ name = "forest fury skill reducer", interval = 2000, chance = 20, range = 5, target = false },
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -20, maxDamage = -40, range = 5, shootEffect = CONST_ANI_POISON, target = false },
}

monster.defenses = {
	defense = 20,
	armor = 22,
	mitigation = 0.80,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
