-- local mType = Game.createMonsterType("Aspect of Power")
-- local monster = {}

-- monster.description = "an aspect of power"
-- monster.experience = 0
-- monster.outfit = {
-- 	lookType = 1297,
-- 	lookHead = 0,
-- 	lookBody = 0,
-- 	lookLegs = 0,
-- 	lookFeet = 0,
-- 	lookAddons = 0,
-- 	lookMount = 0,
-- }

-- monster.health = 20000
-- monster.maxHealth = 20000
-- monster.race = "blood"
-- monster.corpse = 33949
-- monster.speed = 235
-- monster.manaCost = 0

-- -- monster.events = {
-- -- 	"aspectsDeath",
-- -- }

-- monster.changeTarget = {
-- 	interval = 4000,
-- 	chance = 35,
-- }

-- monster.changeTarget2 = {
-- 	interval = 4000,
-- 	chance = 0,
-- }

-- monster.strategiesTarget = {
-- 	nearest = 70,
-- 	health = 10,
-- 	random = 10,
-- 	damage = 10,
-- }

-- monster.strategiesTarget2 = {
-- 	nearest = 70,
-- 	health = 10,
-- 	damage = 10,
-- 	random = 10,
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
-- 	-- { name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
-- 	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -800 },
-- 	{ name = "combat", interval = 1700, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -950, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, target = true },
-- 	{ name = "combat", interval = 1700, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -850, length = 4, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
-- 	{ name = "combat", interval = 1700, chance = 35, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -1550, radius = 3, effect = CONST_ME_MORTAREA, target = false },
-- 	{ name = "outfit", interval = 1000, chance = 5, radius = 8, effect = CONST_ME_LOSEENERGY, target = false, duration = 5000, outfitMonster = "goshnar's hatred" },
-- 	{ name = "outfit", interval = 1000, chance = 5, radius = 8, effect = CONST_ME_LOSEENERGY, target = false, duration = 5000, outfitMonster = "goshnar's greed" },
-- 	{ name = "outfit", interval = 1000, chance = 5, radius = 8, effect = CONST_ME_LOSEENERGY, target = false, duration = 5000, outfitMonster = "goshnar's malice" },
-- 	{ name = "outfit", interval = 1000, chance = 5, radius = 8, effect = CONST_ME_LOSEENERGY, target = false, duration = 5000, outfitMonster = "goshnar's spite" },
-- 	-- { name = "aspect transform", interval = 4000, chance = 100 },
-- }

-- monster.defenses = {
-- 	defense = 50,
-- 	armor = 50,
-- 	mitigation = 1.04,
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
-- 	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
-- }

-- monster.immunities = {
-- 	{ type = "paralyze", condition = true },
-- 	{ type = "outfit", condition = false },
-- 	{ type = "invisible", condition = true },
-- 	{ type = "bleed", condition = false },
-- }

-- mType:register(monster)
