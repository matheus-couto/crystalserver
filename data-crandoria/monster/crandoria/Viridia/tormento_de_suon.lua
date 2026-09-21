local mType = Game.createMonsterType("Tormento de Suon")
local monster = {}

monster.description = "Tormento de Suon"
monster.experience = 5000000
monster.outfit = {
	lookType = 91,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "undead"
monster.corpse = 6031
monster.speed = 215
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 8
}

monster.bosstiary = {
	bossRaceId = 91,
	bossRace = RARITY_BANE
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 70,
	damage = 30,
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Behemoth", chance = 20, interval = 4000, count = 2},
		{name = "Behemoth", chance = 20, interval = 4000, count = 2},
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Quem ousa buscar pelo meu poder?", yell = false},
	{text = "Voce nao saira daqui com vida!", yell = false},
	{text = "Mortais nao podem suportar o poder dos deuses!", yell = false},
	{text = "Venha e sinta o cheiro da sua morte.", yell = false},
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000, condition = {type = CONDITION_POISON, totalDamage = 55, interval = 4000}},
	{name ="combat", interval = 3000, chance = 7, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -700, range = 1, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -900, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 3000, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -750, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_MORTAREA, target = false},
	{name ="speed", interval = 3000, chance = 25, speedChange = -650, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 50000},
	{name ="combat", interval = 2000, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -550, length = 8, spread = 3, effect = CONST_ME_YELLOW_RINGS, target = false}
}

monster.defenses = {
	defense = 30,
	armor = 25,
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_HEALING, minDamage = 200, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 1000, chance = 7, effect = CONST_ME_MAGIC_BLUE},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -17},
	{type = COMBAT_DEATHDAMAGE , percent = 35}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
