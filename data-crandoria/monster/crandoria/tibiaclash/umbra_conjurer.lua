local mType = Game.createMonsterType("Umbra Conjurer")
local monster = {}

monster.name = ""
monster.description = "an umbra conjurer"
monster.experience = 0
monster.outfit = {
	lookType = 432,
	lookHead = 0,
	lookBody = 113,
	lookLegs = 114,
	lookFeet = 113,
	lookAddons = 3,
	lookMount = 0,
}

monster.faction = FACTION_DEEPLING
monster.enemyFactions = { FACTION_DEATHLING }

monster.health = 450
monster.maxHealth = 450
monster.race = "blood"
monster.corpse = 0
monster.speed = 140
monster.manaCost = 320

monster.events = {
	"umbraMonsterDeath2",
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
	targetDistance = 3,
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
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -25, maxDamage = -45, range = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -50, maxDamage = -100, range = 3, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -50, maxDamage = -100, range = 3, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = false },

}

monster.defenses = {
	defense = 0,
	armor = 0,
	-- mitigation = 0,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
