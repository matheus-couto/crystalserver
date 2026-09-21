local mType = Game.createMonsterType("Ignacius")
local monster = {}

monster.description = "Ignacius"
monster.experience = 35000
monster.outfit = {
	lookType = 152,
	lookHead = 132,
	lookBody = 132,
	lookLegs = 132,
	lookFeet = 132,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "blood"
monster.corpse = 19051
monster.speed = 200
monster.manaCost = 450

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 70,
	health = 20,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = true,
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
	{ text = "O fogo alimenta meu espirito.", yell = false },
	{ text = "Queime no inferno!", yell = false },
	{ text = "Voce nunca vai chegar a Zarabastan!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8828, chance = 1000000, maxCount = 1 }, -- trinket
	{ name = "small diamond", chance = 8550, maxCount = 9 },
	{ name = "small ruby", chance = 62210, maxCount = 12 },
	{ id = 3043, chance = 7250, maxCount = 1 },
	{ name = "magma monocle", chance = 4220 },
	{ name = "knife", chance = 9500 },
	{ name = "combat knife", chance = 4000 },
	{ name = "assassin star", chance = 4200, maxCount = 7 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -900 },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_FIREDAMAGE, minDamage = -780, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_REDSTAR, target = false },
	{ name = "extended fire chain", interval = 2500, chance = 20, minDamage = -750, maxDamage = -1230, range = 6, target = true },
	{ name = "combat", interval = 1500, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -1200, range = 3, radius = 5, effect = CONST_ME_FIREATTACK, target = false },
}

monster.defenses = {
	defense = 15,
	armor = 17,
	mitigation = 1.04,
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 75 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
