local mType = Game.createMonsterType("The Blazing Rose")
local monster = {}

monster.description = "The Blazing Rose"
monster.experience = 100000
monster.outfit = {
	lookType = 1068,
	lookHead = 114,
	lookBody = 113,
	lookLegs = 76,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1600,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "undead"
monster.corpse = 28794
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	rewardBoss = true,
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

monster.events = {
	"asuraFireDeath",
}

monster.loot = {
		{ id = 39136, chance = 125, maxCount = 1 },
		{ id = 3035, chance = 100000, maxCount = 8 }, -- platinum coin
		{ name = "crystal coin", chance = 4670, maxCount = 1 },
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
		{ id = 3039, chance = 3800 }, -- red gem
		{ id = 6299, chance = 1100 }, -- death ring
		{ id = 6499, chance = 22110 }, -- demonic essence
		{ id = 8043, chance = 2200 }, -- focus cape
		{ id = 21974, chance = 11400 }, -- golden lotus brooch
		{ id = 826, chance = 1980 }, -- magma coat
		{ id = 3078, chance = 2820 }, -- mysterious fetish
		{ id = 3574, chance = 3170 }, -- mystic turban
		{ id = 21981, chance = 2110 }, -- oriental shoes
		{ id = 21975, chance = 11460 }, -- peacock feather fan
		{ id = 5911, chance = 3070 }, -- red piece of cloth
		{ id = 3016, chance = 2330 }, -- ruby necklace
		{ id = 5944, chance = 20140 }, -- soul orb
		{ id = 8074, chance = 620 }, -- spellbook of mind control
		{ id = 3071, chance = 1440 }, -- wand of inferno
	}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -950 },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -580, maxDamage = -1180, range = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 1000, chance = 32, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -1175, length = 3, spread = 3, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -580, maxDamage = -1020, radius = 5, range = 7, effect = CONST_ME_FIREAREA, target = true }
}

monster.defenses = {
	defense = 33,
	armor = 28,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
