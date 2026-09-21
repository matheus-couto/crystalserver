local mType = Game.createMonsterType("Vladrukh")
local monster = {}

monster.description = "vladrukh"
monster.experience = 450000
monster.outfit = {
	lookType = 1862,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2642,
	bossRace = RARITY_ARCHFOE,
}

monster.events = {
	"vladrukhDeath",
}

monster.health = 450000 --unknown
monster.maxHealth = 450000 --unknown
monster.race = "undead"
monster.corpse = 51572
monster.speed = 85 --unknown
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 2,
	color = 132,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "crystal coin", chance = 7500, maxCount = 3 },
	{ name = "platinum coin", chance = 7500, maxCount = 138 },
	-- { name = "greater proficiency catalyst", chance = 6000 },
	{ name = "blood preservation", chance = 5500 },
	{ name = "supreme health potion", chance = 6000, maxCount = 5 },
	{ name = "ultimate mana potion", chance = 8000, maxCount = 29 },
	{ id = 238, chance = 8000, maxCount = 6 }, -- great mana potion
	{ name = "strong mana potion", chance = 8000, maxCount = 14 },
	{ name = "ultimate spirit potion", chance = 8000, maxCount = 4 },
	{ name = "great spirit potion", chance = 8000, maxCount = 15 },
	{ name = "skull belt", chance = 3500 },
	{ name = "giant emerald", chance = 3000 },
	{ id = 3039, chance = 3000 }, -- red gem
	{ id = 3037, chance = 3000 }, -- yellow gem
	{ id = 32622, chance = 1500 }, 
	{ id = 30061, chance = 1500 }, 
	{ name = "blood sceptre", chance = 400 },
	{ name = "blood crown", chance = 400},
	{ name = "norcferatu bloodhide", chance = 200},
	{ name = "norcferatu bloodstrider", chance = 200, unique = true},
	{ name = "norcferatu bonecloak", chance = 200},
	{ name = "norcferatu bonehood", chance = 200, unique = true},
	{ name = "norcferatu goretrampers", chance = 200},
	{ name = "norcferatu thornwraps", chance = 200, unique = true},
	{ name = "norcferatu tuskplate", chance = 200},
	{ name = "norcferatu skullguard", chance = 200, unique = true},
	{ name = "norcferatu fleshguards", chance = 200},
	{ name = "norcferatu fangstompers", chance = 200, unique = true},
}

-- missing spells
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -1000 },
	{ name = "blood pool wave", interval = 2000, chance = 15, minDamage = -600, maxDamage = -1600, range = 7, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -600, maxDamage = -1400, range = 6, radius = 6, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1300, radius = 5, range = 6, effect = CONST_ME_DRAWBLOOD, target = false },
	{ name = "vladrukh spikes", interval = 2000, chance = 10, minDamage = -500, maxDamage = 1200, range = 6, target = false },
	{ name = "vladrukh poison transform", interval = 3000, chance = 100, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 65,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 600, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType:register(monster)
