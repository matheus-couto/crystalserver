local mType = Game.createMonsterType("Kollos Elite")
local monster = {}

monster.description = "a kollos elite"
monster.experience = 5900
monster.outfit = {
	lookType = 458,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 789
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 2,
	Locations = "Kollos Elite - Trivallis",
}

monster.health = 5500
monster.maxHealth = 5500
monster.race = "venom"
monster.corpse = 13937
monster.speed = 115
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
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
	{ text = "Kropp!", yell = false },
	{ text = "Flzlzlzlzlzlzlz!", yell = false },
}

monster.loot = {
	-- { id = 3250, chance = 900, maxCount = 1 },
	{ name = "small ruby", chance = 8180, maxCount = 5 },
	{ name = "gold coin", chance = 49000, maxCount = 100 },
	{ name = "gold coin", chance = 50000, maxCount = 97 },
	{ name = "platinum coin", chance = 66000, maxCount = 6 },
	{ id = 3098, chance = 3270 }, -- ring of healing
	{ name = "steel boots", chance = 530 },
	{ id = 238, chance = 18950, maxCount = 4 },
	{ id = 281, chance = 2600 }, -- giant shimmering pearl (green)
	{ name = "ultimate health potion", chance = 8000, maxCount = 3 },
	{ name = "gold ingot", chance = 8160 },
	{ name = "kollos shell", chance = 19390 },
	{ name = "compound eye", chance = 15720 },
	{ name = "calopteryx cape", chance = 560 },
	{ name = "carapace shield", chance = 510 },
	{ name = "hive scythe", chance = 900 },
	{ name = "buggy backpack", chance = 660 },
	{ name = "tarsal arrow", chance = 14210, maxCount = 8 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -400, range = 7, radius = 3, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_EXPLOSIONHIT, target = true },
}

monster.defenses = {
	defense = 35,
	armor = 52,
	mitigation = 1.71,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -7 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -5 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
