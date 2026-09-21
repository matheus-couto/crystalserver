local mType = Game.createMonsterType("Savage Omnivora")
local monster = {}

monster.description = "a savage omnivora"
monster.experience = 12750
monster.outfit = {
	lookType = 717,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 9200
monster.maxHealth = 9200
monster.race = "blood"
monster.corpse = 21995
monster.speed = 175
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3031, chance = 97000, maxCount = 242 }, -- gold coin
	{ id = 3035, chance = 14900, maxCount = 42 }, -- gold coin
	{ id = 3578, chance = 18200, maxCount = 2 }, -- fish
	{ id = 16124, chance = 4000, maxCount = 4 }, -- blue crystal splinter
	{ id = 16123, chance = 4000, maxCount = 3 }, -- brown crystal splinter
	{ id = 16122, chance = 6210, maxCount = 5 }, -- green crystal splinter
	{ id = 3582, chance = 1200 }, -- ham
	{ id = 3723, chance = 1900 }, -- white mushroom
	{ id = 3297, chance = 4780 }, -- serpent sword
	{ id = 814, chance = 1700 }, -- terra amulet
	{ id = 813, chance = 2560 }, -- terra boots
	{ id = 811, chance = 4560 }, -- terra mantle
	{ id = 3069, chance = 3430 }, -- necrotic rod
	{ id = 8072, chance = 2320 }, -- spellbook of enlightenment
	{ id = 12311, chance = 25 }, -- carrot on a stick
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -650 },
	{ name = "speed", interval = 4000, chance = 20, speedChange = -350, range = 7, shootEffect = CONST_ANI_POISON, target = true, duration = 12000 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -280, maxDamage = -500, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -500, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 38,
	mitigation = 0.99,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
