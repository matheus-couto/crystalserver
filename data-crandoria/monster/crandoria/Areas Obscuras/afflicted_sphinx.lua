local mType = Game.createMonsterType("Afflicted Sphinx")
local monster = {}

monster.description = "an afflicted sphinx"
monster.experience = 22500
monster.outfit = {
	lookType = 1188,
	lookHead = 0,
	lookBody = 39,
	lookLegs = 0,
	lookFeet = 3,
	lookAddons = 1,
	lookMount = 0,
}



monster.health = 26500
monster.maxHealth = 26500
monster.race = "blood"
monster.corpse = 31386
monster.speed = 210
monster.manaCost = 0

-- monster.faction = FACTION_ANUMA
-- monster.enemyFactions = { FACTION_FAFNAR, FACTION_PLAYER }

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
	runHealth = 10,
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
	-- { id = 3250, chance = 900, maxCount = 1 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "platinum coin", chance = 100000, maxCount = 3 },
	{ name = "sphinx feather", chance = 9300 },
	{ name = "magma amulet", chance = 7000 },
	{ id = 31438, chance = 5500 }, -- sphinx tiara
	{ name = "magma boots", chance = 3600 },
	{ name = "lightning pendant", chance = 3500 },
	{ name = "lightning headband", chance = 3100 },
	{ name = "wand of starstorm", chance = 2900 },
	{ name = "wand of defiance", chance = 1800 },
	{ name = "magma monocle", chance = 1400 },
	{ name = "magma legs", chance = 1300 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -600, length = 6, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -450, range = 5, radius = 3, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -500, radius = 3, effect = CONST_ME_ENERGYAREA, target = false },
}

monster.defenses = {
	defense = 82,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
