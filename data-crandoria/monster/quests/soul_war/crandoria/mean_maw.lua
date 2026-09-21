-- local mType = Game.createMonsterType("Mean Maw")
-- local monster = {}

-- monster.description = "a mean maw"
-- monster.experience = 0
-- monster.outfit = {
-- 	lookType = 1294,
-- 	lookHead = 0,
-- 	lookBody = 0,
-- 	lookLegs = 0,
-- 	lookFeet = 0,
-- 	lookAddons = 0,
-- 	lookMount = 0
-- }


-- monster.health = 24000
-- monster.maxHealth = 24000
-- monster.race = "undead"
-- monster.corpse = 33797
-- monster.speed = 220
-- monster.manaCost = 0

-- monster.changeTarget = {
-- 	interval = 1000,
-- 	chance = 75,
-- }

-- monster.changeTarget2 = {
-- 	interval = 1000,
-- 	chance = 75,
-- }

-- monster.strategiesTarget = {
-- 	nearest = 97,
-- 	health = 0,
-- 	random = 1,
-- 	damage = 0,
-- }

-- monster.strategiesTarget2 = {
-- 	nearest = 97,
-- 	health = 0,
-- 	random = 1,
-- 	damage = 0,
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
-- 	canPushCreatures = false,
-- 	staticAttackChance = 90,
-- 	targetDistance = 1,
-- 	runHealth = 0,
-- 	healthHidden = false,
-- 	isBlockable = false,
-- 	canWalkOnEnergy = true,
-- 	canWalkOnFire = true,
-- 	canWalkOnPoison = true
-- }

-- monster.light = {
-- 	level = 0,
-- 	color = 0
-- }

-- monster.voices = {
-- 	interval = 5000,
-- 	chance = 10,
-- }

-- monster.loot = {}

-- monster.attacks = {
-- 	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000},
-- 	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -820, length = 8, spread = 5, effect = CONST_ME_DRAWBLOOD, target = false},
-- 	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -350, maxDamage = -1200, length = 6, effect = CONST_ME_DRAWBLOOD, target = false},
-- }

-- monster.defenses = {
-- 	defense = 80,
-- 	armor = 100
-- }

-- monster.elements = {
-- 	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
-- 	{type = COMBAT_ENERGYDAMAGE, percent = 0},
-- 	{type = COMBAT_EARTHDAMAGE, percent = 0},
-- 	{type = COMBAT_FIREDAMAGE, percent = 0},
-- 	{type = COMBAT_LIFEDRAIN, percent = 0},
-- 	{type = COMBAT_MANADRAIN, percent = 0},
-- 	{type = COMBAT_DROWNDAMAGE, percent = 0},
-- 	{type = COMBAT_ICEDAMAGE, percent = 0},
-- 	{type = COMBAT_HOLYDAMAGE , percent = 0},
-- 	{type = COMBAT_DEATHDAMAGE , percent = 0}
-- }

-- monster.immunities = {
-- 	{type = "paralyze", condition = true},
-- 	{type = "outfit", condition = true},
-- 	{type = "invisible", condition = true},
-- 	{type = "bleed", condition = false}
-- }

-- mType:register(monster)
