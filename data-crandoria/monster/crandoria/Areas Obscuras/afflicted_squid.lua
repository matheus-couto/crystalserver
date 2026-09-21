local mType = Game.createMonsterType("Afflicted Squid")
local monster = {}

monster.description = "an afflicted squid"
monster.experience = 26672
monster.outfit = {
	lookType = 1059,
	lookHead = 17,
	lookBody = 41,
	lookLegs = 77,
	lookFeet = 57,
	lookAddons = 0,
	lookMount = 0,
}



monster.health = 33000
monster.maxHealth = 33000
monster.race = "undead"
monster.corpse = 28582
monster.speed = 215
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
	{ text = "tzzzz tzzzzz tzzzzz", yell = false },
	{ text = "tzuuuumme tzuuummmmee", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "violet crystal shard", chance = 25000, maxCount = 4 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ name = "platinum coin", chance = 100000, maxCount = 12 },
	{ name = "glowing rune", chance = 5000, maxCount = 4 },
	{ name = "instable proto matter", chance = 5100, maxCount = 4 },
	{ name = "energy ball", chance = 6000, maxCount = 4 },
	{ name = "energy bar", chance = 5000, maxCount = 4 },
	{ name = "energy drink", chance = 5000, maxCount = 4 },
	{ name = "odd organ", chance = 5000, maxCount = 4 },
	{ name = "frozen lightning", chance = 5500, maxCount = 4 },
	{ id = 28568, chance = 5000, maxCount = 3 }, -- inkwell
	{ name = "small ruby", chance = 5000, maxCount = 4 },
	{ name = "violet gem", chance = 1200, maxCount = 4 },
	{ name = "blue crystal splinter", chance = 5000, maxCount = 4 },
	{ name = "cyan crystal fragment", chance = 1200, maxCount = 4 },
	{ name = "ultimate mana potion", chance = 5000, maxCount = 4 },
	{ name = "piece of dead brain", chance = 1200, maxCount = 4 },
	{ name = "wand of defiance", chance = 1000 },
	{ name = "lightning headband", chance = 1000 },
	{ name = "lightning pendant", chance = 1000 },
	{ name = "might ring", chance = 1300 },
	{ name = "slime heart", chance = 1200, maxCount = 4 },
	{ id = 23544, chance = 1000 }, -- collar of red plasma
	{ id = 23542, chance = 1000 }, -- collar of blue plasma
	{ id = 23543, chance = 800 }, -- collar of green plasma
	{ id = 23533, chance = 1000 }, -- ring of red plasma
	{ id = 23529, chance = 1000 }, -- ring of blue plasma
	{ id = 23531, chance = 1000 }, -- ring of green plasma
	{ id = 10138, chance = 200 }, -- ring of green plasma
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -550 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -670, range = 7, shootEffect = CONST_ANI_ENERGY, target = false },
	{ name = "combat", interval = 2000, chance = 23, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -705, radius = 3, effect = CONST_ME_ENERGYAREA, target = false },
}

monster.defenses = {
	defense = 40,
	armor = 78,
	mitigation = 2.16,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
