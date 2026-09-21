local mType = Game.createMonsterType("Crandoria Totem")
local monster = {}

monster.name = ""
monster.description = "a crandoria totem"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 16572,
	lookMount = 0,
}

monster.faction = FACTION_DEATHLING
monster.enemyFactions = { FACTION_DEEPLING }

monster.health = 2000
monster.maxHealth = 2000
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 320

monster.events = {
	"crandoriaTotemDeath",
}

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 20,
	health = 0,
	random = 0,
	damage = 80,
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

}

monster.defenses = {

	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_HEALING, minDamage = 2, maxDamage = 2, effect = CONST_ME_MAGIC_BLUE, target = false },
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
