local mType = Game.createMonsterType("Blizzard Dragon")
local monster = {}

monster.description = "a blizzard dragon"
monster.experience = 3700
monster.outfit = {
	lookType = 947,
	lookHead = 0,
	lookBody = 9,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 1381
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 2,
	Locations = "Blizzard Dragon - Dracantus.",
}

monster.events = {
	"TheFirstDragonDragonTaskDeath",
}

monster.health = 4000
monster.maxHealth = 4000
monster.race = "undead"
monster.corpse = 25185
monster.speed = 106
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 5,
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3031, chance = 96850, maxCount = 216 }, -- gold coin
	{ id = 3035, chance = 56850, maxCount = 6 },
	{ id = 3583, chance = 80020, maxCount = 3 }, -- dragon ham
	{ id = 762, chance = 78200, maxCount = 12 }, -- shiver arrow
	{ id = 238, chance = 40200, maxCount = 3 }, -- great mana potion
	{ id = 3029, chance = 52100, maxCount = 3 }, -- small sapphire
	{ id = 24937, chance = 22680 }, -- dragon blood
	{ id = 24938, chance = 14400 }, -- dragon tongue
	{ id = 3051, chance = 19900 }, -- energy ring
	{ id = 829, chance = 3900 }, -- glacier mask
	{ id = 2903, chance = 21700 }, -- golden mug
	{ id = 3067, chance = 23700 }, -- hailstorm rod
	{ id = 7441, chance = 43400 }, -- ice cube
	{ id = 815, chance = 540 }, -- glacier amulet
	{ id = 823, chance = 1000 },
	{ id = 824, chance = 1000 },
	{ id = 819, chance = 1000 },
	{ id = 3061, chance = 540 }, -- life crystal
	{ id = 7290, chance = 2290 }, -- shard
	{ id = 3386, chance = 530 }, -- dragon scale mail
	{ id = 30061, chance = 400, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "speed", interval = 2000, chance = 18, minDamage = 0, maxDamage = -400, range = 7, radius = 4, effect = CONST_ME_ICETORNADO, target = true, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -150, maxDamage = -400, range = 7, radius = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_LIFEDRAIN, minDamage = -150, maxDamage = -270, length = 8, spread = 3, effect = CONST_ME_POFF, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 22,
	{ name = "combat", interval = 2000, chance = 16, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 60 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
