local mType = Game.createMonsterType("Fanatico da Folia")
local monster = {}

monster.description = "a fanatico da folia"
monster.experience = 9000
monster.outfit = {
	lookType = 695,
	lookHead = 91,
	lookBody = 85,
	lookLegs = 0,
	lookFeet = 71,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 6000
monster.maxHealth = 6000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 135
monster.manaCost = 0

monster.raceId = 382
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Fanatico da Folia - Evento de Carnaval.",
}

-- monster.events = {
-- 	"fanaticoKill",
-- }

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
	{ text = "Carnavaaaaal!", yell = false },
	{ text = "Sente essa batida!", yell = false },
	{ text = "Vamboraaa!", yell = false },
}

monster.loot = {
	-- -- { id = 3250, chance = 1975, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3031, chance = 100000, minCount = 35, maxCount = 100 },
	{ id = 3035, chance = 55000, minCount = 3, maxCount = 8 },
	{ id = 33309, chance = 50 },
	{ id = 7642, chance = 18500, maxCount = 2},
	{ id = 33307, chance = 30 },
	{ id = 39707, chance = 30 },
	{ id = 11460, chance = 75, maxCount = 2 },
	{ id = 32002, chance = 50 },
	{ id = 39037, chance = 75, maxCount = 1 },
	{ id = 29345, chance = 100, maxCount = 1 },
	{ id = 29289, chance = 50 },
	{ id = 11551, chance = 50 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -360 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -400, range = 7, radius = 4, effect = CONST_ME_FIREWORK_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -120, maxDamage = -350, range = 5, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2000, chance = 12, type = COMBAT_MANADRAIN, minDamage = -75, maxDamage = -200, length = 8, spread = 3, effect = CONST_ME_FIREWORK_BLUE, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	mitigation = 1.60,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 75, maxDamage = 180, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
