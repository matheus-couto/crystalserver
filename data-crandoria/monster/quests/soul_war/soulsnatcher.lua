-- local mType = Game.createMonsterType("Soulsnatcher")
-- local monster = {}

-- monster.description = "a soulsnatcher"
-- monster.experience = 0
-- monster.outfit = {
-- 	lookType = 1268,
-- 	lookHead = 0,
-- 	lookBody = 95,
-- 	lookLegs = 0,
-- 	lookFeet = 95,
-- 	lookAddons = 0,
-- 	lookMount = 0,
-- }


-- monster.health = 10000
-- monster.maxHealth = 10000
-- monster.race = "undead"
-- monster.corpse = 0
-- monster.speed = 240
-- monster.manaCost = 0

-- monster.changeTarget = {
-- 	interval = 3000,
-- 	chance = 35,
-- }

-- monster.changeTarget2 = {
-- 	interval = 5000,
-- 	chance = 8,
-- }

-- monster.strategiesTarget = {
-- 	nearest = 70,
-- 	health = 10,
-- 	random = 10,
-- 	damage = 10,
-- }

-- monster.strategiesTarget2 = {
-- 	nearest = 100,
-- }

-- monster.flags = {
-- 	summonable = false,
-- 	attackable = true,
-- 	hostile = true,
-- 	convinceable = false,
-- 	pushable = false,
-- 	rewardBoss = false,
-- 	illusionable = false,
-- 	canPushItems = true,
-- 	canPushCreatures = true,
-- 	staticAttackChance = 90,
-- 	targetDistance = 1,
-- 	runHealth = 0,
-- 	healthHidden = false,
-- 	isBlockable = false,
-- 	canWalkOnEnergy = true,
-- 	canWalkOnFire = true,
-- 	canWalkOnPoison = true,
-- }

-- monster.light = {
-- 	level = 0,
-- 	color = 0,
-- }

-- monster.voices = {
-- 	interval = 5000,
-- 	chance = 10,
-- }

-- monster.loot = {}

-- monster.attacks = {
-- 	{ name = "melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -1500 },
-- 	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -1000, maxDamage = -1500, range = 6, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYAREA, target = true },
-- 	{ name = "lifedrain beam", interval = 2000, chance = 25, minDamage = -1000, maxDamage = -1500, target = false },
-- 	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -900, radius = 5, effect = CONST_ME_ENERGYAREA, target = false },
-- }

-- monster.defenses = {
-- 	defense = 40,
-- 	armor = 79,
-- 	mitigation = 2.22,
-- }

-- monster.elements = {
-- 	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
-- 	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
-- 	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
-- 	{ type = COMBAT_FIREDAMAGE, percent = 0 },
-- 	{ type = COMBAT_LIFEDRAIN, percent = 0 },
-- 	{ type = COMBAT_MANADRAIN, percent = 0 },
-- 	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
-- 	{ type = COMBAT_ICEDAMAGE, percent = 0 },
-- 	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
-- 	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
-- }

-- monster.immunities = {
-- 	{ type = "paralyze", condition = true },
-- 	{ type = "outfit", condition = false },
-- 	{ type = "invisible", condition = true },
-- 	{ type = "bleed", condition = false },
-- }

-- mType:register(monster)
