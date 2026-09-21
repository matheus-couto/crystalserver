local mType = Game.createMonsterType("Knight of the Holy Flame")
local monster = {}

monster.description = "a knight of the holy flame"
monster.experience = 16750
monster.outfit = {
	lookType = 1071,
	lookHead = 95,
	lookBody = 95,
	lookLegs = 94,
	lookFeet = 125,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 20220
monster.maxHealth = 20220
monster.race = "ink"
monster.corpse = 28737
monster.speed = 230
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
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "platinum coin", chance = 89960, maxCount = 32 },
	{ name = "flask of demonic blood", chance = 3000, maxCount = 3 },
	{ name = "small ruby", chance = 2000, maxCount = 4 },
	{ id = 3307, chance = 3000 }, -- scimitar
	{ name = "magma coat", chance = 2000 },
	{ name = "demon shield", chance = 1000 },
	{ name = "mercenary sword", chance = 1000 },
	{ name = "magma monocle", chance = 1500 },
	{ id = 6299, chance = 1200 }, -- death ring
	{ id = 3049, chance = 1800 }, -- stealth ring
	{ name = "shadow sceptre", chance = 8990 },
	{ name = "knight armor", chance = 1980 },
	{name = "burning heart", chance = 5000, maxCount = 1},
	{name = "royal helmet", chance = 1200, maxCount = 1},
	{ name = "small topaz", chance = 4580, maxCount = 3 },
	{ id = 9636, chance = 4200, maxCount = 1}
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -850 },
	{ name = "combat", interval = 1500, chance = 12, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -950, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -850, length = 5, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -775, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "werecrocodile fire ring", interval = 2000, chance = 20, minDamage = -320, maxDamage = -980, target = false},
}

monster.defenses = {
	defense = 48,
	armor = 99,
	mitigation = 2.28,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 40 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
