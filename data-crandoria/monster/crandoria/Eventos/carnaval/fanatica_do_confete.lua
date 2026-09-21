local mType = Game.createMonsterType("Fanatica do Confete")
local monster = {}

monster.description = "a fanatica do confete"
monster.experience = 8250
monster.outfit = {
	lookType = 1597,
	lookHead = 78,
	lookBody = 77,
	lookLegs = 0,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 5500
monster.maxHealth = 5500
monster.race = "blood"
monster.corpse = 6068
monster.speed = 135
monster.manaCost = 0

monster.raceId = 380
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Fanatica do Confete - Evento de Carnaval.",
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
	{ id = 239, chance = 16500, maxCount = 2},
	{ id = 33309, chance = 50 },
	{ id = 33306, chance = 40 },
	{ id = 33307, chance = 30 },
	{ id = 39707, chance = 30 },
	{ id = 11682, chance = 50, maxCount = 1 },
	{ id = 32002, chance = 50 },
	{ id = 32045, chance = 150, maxCount = 1 },
	{ id = 32044, chance = 100, maxCount = 1 },
	{ id = 29346, chance = 100, maxCount = 1 },
	{ id = 29288, chance = 50 },
	{ id = 11547, chance = 50 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -120, maxDamage = -350, range = 5, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_FIREWORK_YELLOW, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -300, radius = 3, range = 4, effect = CONST_ME_FIREWORK_YELLOW, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -100, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000 },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	mitigation = 1.60,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 75, maxDamage = 150, effect = CONST_ME_MAGIC_BLUE, target = false },
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
