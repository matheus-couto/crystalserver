local mType = Game.createMonsterType("Elite Hero")
local monster = {}

monster.description = "a elite hero"
monster.experience = 1800
monster.outfit = {
	lookType = 73,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 736
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Elite Hero - Trivallis.",
}

monster.health = 1900
monster.maxHealth = 1900
monster.race = "blood"
monster.corpse = 18134
monster.speed = 140
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
	nearest = 80,
	health = 10,
	damage = 10,
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
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Protect the gold!", yell = false },
	{ text = "You will not take our masters gold.", yell = false },
	{ text = "You are so weak...", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 2815, chance = 45000 }, -- scroll
	{ id = 2949, chance = 1640 }, -- lyre
	{ name = "piggy bank", chance = 80 },
	{ id = 3003, chance = 2190 }, -- rope
	{ id = 3035, chance = 52190, maxCount = 4 },
	{ name = "wedding ring", chance = 4910 },
	{ name = "gold coin", chance = 69500, maxCount = 100 },
	{ name = "might ring", chance = 670 },
	{ name = "two handed sword", chance = 2500 },
	{ name = "war hammer", chance = 1270 },
	{ name = "fire sword", chance = 850 },
	{ name = "bow", chance = 13300 },
	{ name = "crown armor", chance = 690 },
	{ name = "crown legs", chance = 760 },
	{ name = "crown helmet", chance = 550 },
	{ name = "crown shield", chance = 380 },
	{ name = "arrow", chance = 26000, maxCount = 18 },
	{ name = "green tunic", chance = 10000 },
	{ name = "scarf", chance = 2110 },
	{ name = "meat", chance = 8200, maxCount = 3 },
	{ name = "grapes", chance = 19850 },
	{ name = "red rose", chance = 20450 },
	{ name = "red piece of cloth", chance = 2506 },
	{ name = "sniper arrow", chance = 14400, maxCount = 7 },
	{ name = "great health potion", chance = 1420, maxCount = 2 },
	{ name = "small notebook", chance = 930 },
	{ name = "scroll of heroic deeds", chance = 6000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -200, range = 7, shootEffect = CONST_ANI_ARROW, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 35,
	mitigation = 1.32,
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 40 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
