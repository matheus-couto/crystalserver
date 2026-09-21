local mType = Game.createMonsterType("Secret Flower Asura")
local monster = {}

monster.description = "a secret flower asura"
monster.experience = 13500
monster.outfit = {
	lookType = 150,
	lookHead = 95,
	lookBody = 121,
	lookLegs = 94,
	lookFeet = 1,
	lookAddons = 1,
	lookMount = 0,
}



monster.health = 10200
monster.maxHealth = 10200
monster.race = "blood"
monster.corpse = 36982
monster.speed = 170
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
	{ text = "Sense the poison from my flowers!", yell = false },
	{ text = "This needles will make you scream!", yell = false },
	{ text = "Nature is ruthless!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 100000, maxCount = 12 }, -- platinum coin
	{ name = "crystal coin", chance = 2670, maxCount = 1 },
	{ id = 6558, chance = 30110 }, -- flask of demonic blood
	{ id = 238, chance = 16560, maxCount = 2 }, -- great mana potion
	{ id = 3033, chance = 6810, maxCount = 2 }, -- small amethyst
	{ id = 3028, chance = 7500, maxCount = 2 }, -- small diamond
	{ id = 3032, chance = 18010, maxCount = 2 }, -- small emerald
	{ name = "small enchanted ruby", chance = 9440, maxCount = 3 },
	{ id = 3030, chance = 11890, maxCount = 2 }, -- small ruby
	{ id = 9057, chance = 8560, maxCount = 2 }, -- small topaz
	{ name = "royal star", chance = 4050, maxCount = 3 },
	{ id = 3041, chance = 1300 }, -- blue gem
	{ id = 3038, chance = 4800 }, -- green gem
	{ id = 3052, chance = 1100 }, -- life ring
	{ id = 6499, chance = 22110 }, -- demonic essence
	{ id = 8043, chance = 2200 }, -- focus cape
	{ id = 21974, chance = 11400 }, -- golden lotus brooch
	{ id = 3078, chance = 2820 }, -- mysterious fetish
	{ id = 21981, chance = 2110 }, -- oriental shoes
	{ id = 21975, chance = 11460 }, -- peacock feather fan
	{ id = 5910, chance = 3070 }, -- green piece of cloth
	{ id = 5944, chance = 20140 }, -- soul orb
	{ id = 8074, chance = 620 }, -- spellbook of mind control
	{ id = 8052, chance = 1040 }, -- swamplair armor
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -580, condition = { type = CONDITION_POISON, totalDamage = 800, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -150, maxDamage = -400, range = 7, length = 6, effect = CONST_ME_ENERGYAREA, target = false }, -- mana drain beam
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -350, maxDamage = -580, length = 5, spread = 3, range = 5, effect = CONST_ME_GREEN_RINGS, target = false }, -- poison wave
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -550, range = 6, effect = CONST_ME_HITAREA, shootEffect = CONST_ANI_LEAFSTAR, target = true }, -- holy ball
	{ name = "speed", interval = 2000, chance = 15, speedChange = -400, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 15000 }, -- smoke berserk
}

monster.defenses = {
	defense = 55,
	armor = 48,
	mitigation = 1.46,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 200, maxDamage = 450, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
