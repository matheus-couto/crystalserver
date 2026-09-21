local mType = Game.createMonsterType("Maliz")
local monster = {}

monster.description = "Maliz"
monster.experience = 0
monster.outfit = {
	lookType = 34,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"DragonPackDeath"
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 5973
monster.speed = 86
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
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
	targetDistance = 1,
	runHealth = 300,
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
	{ text = "FCHHHHH", yell = true },
	{ text = "GROOAAARRR", yell = true },
}

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	-- { name = "death chain", interval = 2000, chance = 20, minDamage = -1000, maxDamage = -3000, range = 7 },
	{ name = "combat", interval = 2000, chance = 15, minDamage = -1000, maxDamage = -2500, length = 9, spread = 7, effect = CONST_ME_BIGPLANTS, range = 7 },
	{ name = "combat", interval = 2000, chance = 15, minDamage = -1000, maxDamage = -2500, length = 9, spread = 7, effect = CONST_ME_GREEN_RINGS, range = 7 },
	{ name = "earth ring", interval = 2000, chance = 15, minDamage = -800, maxDamage = -1800, range = 7 },
	{ name = "dragonpack spells", interval = 2000, chance = 20, range = 7 },
}

monster.defenses = {
	defense = 50,
	armor = 35,
	mitigation = 0.99,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 400, maxDamage = 700, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.heals = {
	{ type = COMBAT_EARTHDAMAGE, percent = 1000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
