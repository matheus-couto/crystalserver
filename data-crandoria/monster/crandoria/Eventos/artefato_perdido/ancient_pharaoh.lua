local mType = Game.createMonsterType("Ancient Pharaoh")
local monster = {}

monster.description = "an ancient pharaoh"
monster.experience = 10000
monster.outfit = {
	lookType = 87,

}

monster.health = 10000
monster.maxHealth = 10000
monster.race = "undead"
monster.corpse = 6031
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
}

monster.strategiesTarget = {
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
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Mummy", chance = 30, interval = 2000, count = 2 },
		{ name = "Bonebeast", chance = 30, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 3043, chance = 2000, maxCount = 1 },
	{ id = 3035, chance = 13200, maxCount = 22 },
	{ id = 19149, chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 1000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -650, maxDamage = -1500, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 3000, chance = 17, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "drunk", interval = 3000, chance = 11, radius = 6, effect = CONST_ME_POISONAREA, target = false, duration = 25000 },
	{ name = "speed", interval = 1000, chance = 25, speedChange = -350, length = 7, spread = 3, effect = CONST_ME_POISONAREA, target = false, duration = 30000 },
	-- poison
	{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 30, minDamage = -35, maxDamage = -35, radius = 5, effect = CONST_ME_HITBYPOISON, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 50,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 100, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 40 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
