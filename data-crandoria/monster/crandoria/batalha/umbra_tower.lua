local mType = Game.createMonsterType("Umbra Tower")
local monster = {}

monster.name = ""
monster.description = "an umbra tower"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 2107,
	lookMount = 0,
}

monster.faction = FACTION_DEEPLING
monster.enemyFactions = { FACTION_DEATHLING }

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 320

monster.events = {
	"umbraTowerDeath",
}

monster.changeTarget = {
	interval = 4000,
	chance = 100,
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
	targetDistance = 7,
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
	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_AGONYDAMAGE, minDamage = -200, maxDamage = -500, range = 7, shootEffect = CONST_ANI_ARROW, effect = CONST_ME_AGONY, target = false },

}

monster.defenses = {

	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_HEALING, minDamage = 20, maxDamage = 20, effect = CONST_ME_MAGIC_BLUE, target = false },
	defense = 0,
	armor = 50,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
