local mType = Game.createMonsterType("Lianna the Venomous Shadow")
local monster = {}

monster.description = "Lianna the Venomous Shadow"
monster.experience = 500000
monster.outfit = {
	lookType = 1298,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 121,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0
}

monster.events = {
	"liannaDeath",
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 300
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0
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
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Chaos will take it's place...", yell = false},
	{text = "Don't try to follow my shadow", yell = false},
	{text = "You should shiver!", yell = false},
	{text = "I'm thirsty for blood!", yell = false}
}

monster.loot = {
		-- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 3065, maxCount = 3 },
	{name = "crystal coin", chance = 1000000, minCount = 2, maxCount = 4},
	{name = "platinum coin", chance = 1000000, minCount = 26, maxCount = 44},
	{name = "great spirit potion", chance = 32220, maxCount = 7},
	{name = "blue gem", chance = 54560},
	{name = "golden armor", chance = 18000},
	{name = "golden legs", chance = 18000},
	{name = "mastermind shield", chance = 12000},
	{name = "boots of haste", chance = 28000},
	{name = "plate armor", chance = 68000},
	{name = "gold ingot", chance = 34560, maxCount = 3},
	-- {name = "violet gem", chance = 74560},
	{name = "ultimate mana potion", chance = 58322, maxCount = 11},
	{name = "ultimate health potion", chance = 44200, maxCount = 13},
	{name = "ultimate spirit potion", chance = 48500, maxCount = 12},
	{name = "supreme health potion", chance = 23500, maxCount = 8},
	{id = 3032, chance = 1000000, minCount = 4, maxCount = 14},
	{id = 3038, chance = 32000, maxCount = 1},
	{id = 812, chance = 32000},
	{id = 830, chance = 32000},
	-- {id = 3028, chance = 35000, maxCount = 6}, -- small diamond
	{id = 8084, chance = 25000},
	{id = 7457, chance = 25000},
	{id = 5904, chance = 10000, maxCount = 2},
	{id = 30060, chance = 35000, maxCount = 1},
	{id = 22516, chance = 25000, maxCount = 1},
	{id = 22721, chance = 25000, maxCount = 1},
	{id = 6499, chance = 60000, maxCount = 3},
	-- {id = 8102, chance = 100, unique = true}, -- emerald sword
	-- {id = 3387, chance = 100, unique = true}, -- demon helmet
	{id = 8054, chance = 100, unique = true}, -- earthborn titan armor
	{id = 19356, chance = 50, unique = true}, -- Triple Bolt Crossbow
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -3000},
	{name ="combat", interval = 3000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -850, maxDamage = -3200, range = 7, radius = 3, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_GREEN_RINGS, target = true},
	{ name = "death explosion", interval = 2000, chance = 20, minDamage = -1800, maxDamage = -4300, range = 8, target = false },
	{ name = "bakragore vortex", interval = 2000, chance = 20, minDamage = -1200, maxDamage = -3500, range = 7, target = false },
	{ name = "poison chain", interval = 2000, chance = 20, minDamage = -1550, maxDamage = -3100, range = 8, target = true},
	{name = "great poison ring", interval = 2000, chance = 25, minDamage = -1400, maxDamage = -2750, target = false},
	{ name = "check ip", interval = 20000, chance = 100, target = false },
	-- Chain: const_me-> CONST_ME_ICEATTACK, combat_t->COMBAT_ICEDAMAGE
}

monster.defenses = {
	defense = 75,
	armor = 100,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 5000, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.reflects = {
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -15},
	{type = COMBAT_DEATHDAMAGE , percent = 30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)