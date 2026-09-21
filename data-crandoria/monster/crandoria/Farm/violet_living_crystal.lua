local mType = Game.createMonsterType("Violet Living Crystal")
local monster = {}

monster.description = "a violet living crystal"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 14961,
}


monster.health = 100
monster.maxHealth = 100
monster.race = "undead"
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 8
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
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
}

monster.attacks = {
}

monster.defenses = {
	defense = 150,
	armor = 150,
	--	mitigation = ???,
	{ name = "combat", interval = 10000, chance = 100, type = COMBAT_HEALING, minDamage = 1, maxDamage = 1, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 99},
	{type = COMBAT_ENERGYDAMAGE, percent = 99},
	{type = COMBAT_EARTHDAMAGE, percent = 99},
	{type = COMBAT_FIREDAMAGE, percent = 99},
	{type = COMBAT_LIFEDRAIN, percent = 99},
	{type = COMBAT_MANADRAIN, percent = 99},
	{type = COMBAT_DROWNDAMAGE, percent = 99},
	{type = COMBAT_ICEDAMAGE, percent = 99},
	{type = COMBAT_HOLYDAMAGE , percent = 99},
	{type = COMBAT_DEATHDAMAGE , percent = 99}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = true}
}

mType:register(monster)
