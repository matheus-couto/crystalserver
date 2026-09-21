local mType = Game.createMonsterType("Crandoria Warmaster")
local monster = {}

monster.name = ""
monster.description = "a crandoria warmaster"
monster.experience = 0
monster.outfit = {
	lookType = 512,
	lookHead = 84,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 84,
	lookAddons = 3,
	lookMount = 0,
}

monster.faction = FACTION_DEATHLING
monster.enemyFactions = { FACTION_DEEPLING }

monster.health = 1500
monster.maxHealth = 1500
monster.race = "blood"
monster.corpse = 0
monster.speed = 150
monster.manaCost = 320

monster.events = {
	"crandoriaMonsterDeath3",
}

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
	health = 0,
	random = 0,
	damage = 0,
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
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -120 },
	{ name = "combat", interval = 4000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -100, range = 3, radius = 3, effect = CONST_ME_HITAREA, target = false },

}

monster.defenses = {
	defense = 30,
	armor = 30,
	-- mitigation = 0,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
