local mType = Game.createMonsterType("The Lily of Night")
local monster = {}

monster.description = "The Lily of Night"
monster.experience = 150000
monster.outfit = {
	lookType = 1068,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 90,
	lookFeet = 79,
	lookAddons = 2,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1602,
	bossRace = RARITY_ARCHFOE,
}

monster.events = {
	"asuraMidnightDeath",
}

monster.health = 150000
monster.maxHealth = 150000
monster.race = "undead"
monster.corpse = 28802
monster.speed = 205
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

monster.loot = {
		{ id = 39136, chance = 35, maxCount = 1 },
		{ name = "violet gem", chance = 1390 },
		{ name = "crystal coin", chance = 5760, maxCount = 1 },
		{ name = "royal star", chance = 4090, maxCount = 3 },
		{ id = 3035, chance = 100000, maxCount = 8 }, -- platinum coin
		{ id = 7368, chance = 9210, maxCount = 5 }, -- assassin star
		{ id = 3027, chance = 9870, maxCount = 2 }, -- black pearl
		{ id = 6558, chance = 20540 }, -- flask of demonic blood
		{ id = 6499, chance = 10730 }, -- demonic essence
		{ id = 3028, chance = 15630, maxCount = 2 }, -- small diamond
		{ id = 3032, chance = 7750, maxCount = 2 }, -- small emerald
		{ id = 3030, chance = 7830, maxCount = 2 }, -- small ruby
		{ id = 3029, chance = 12690, maxCount = 2 }, -- small sapphire
		{ id = 9057, chance = 8120, maxCount = 2 }, -- small topaz
		{ id = 239, chance = 19960, maxCount = 2 }, -- great health potion
		{ id = 3026, chance = 8170, maxCount = 2 }, -- white pearl
		{ id = 7404, chance = 980 }, -- assassin dagger
		{ id = 3041, chance = 1020 }, -- blue gem
		{ id = 3567, chance = 900 }, -- blue robe
		{ id = 9058, chance = 900 }, -- gold ingot
		{ id = 21974, chance = 12440 }, -- golden lotus brooch
		{ id = 3069, chance = 3610 }, -- necrotic rod
		{ id = 21981, chance = 1820 }, -- oriental shoes
		{ id = 21975, chance = 12790 }, -- peacock feather fan
		{ id = 8061, chance = 930 }, -- skullcracker armor
		{ id = 3017, chance = 10060 }, -- silver brooch
		{ id = 3054, chance = 2020 }, -- silver amulet
		{ id = 5944, chance = 10020 }, -- soul orb
		{ id = 8074, chance = 900 }, -- spellbook of mind control
		{ id = 3403, chance = 2290 }, -- tribal mask
		{ id = 8082, chance = 990 }, -- underworld rod
		{ id = 3037, chance = 900 }, -- yellow gem
		{ id = 3007, chance = 930 }, -- crystal ring
		{ name = "small enchanted amethyst", chance = 1441, maxCount = 3 },
	}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -1200 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -980, range = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_POFF, target = false },
	{ name = "combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -780, maxDamage = -1390, length = 3, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "death ring", interval = 2000, chance = 20, minDamage = -800, maxDamage = -1400, target = false},
	{ name = "extended energy chain", interval = 2000, chance = 20, minDamage = -800, maxDamage = -1200, target = true}
}

monster.defenses = {
	defense = 33,
	armor = 28,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
