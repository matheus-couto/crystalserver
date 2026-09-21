local mType = Game.createMonsterType("Black Dragon")
local monster = {}

monster.description = "a black dragon"
monster.experience = 18300
monster.outfit = {
	lookType = 927,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 17350
monster.maxHealth = 17350
monster.race = "undead"
monster.corpse = 6305
monster.speed = 165
monster.manaCost = 0

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
	staticAttackChance = 70,
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
	{ text = "FCHHHHHHH!", yell = true },
	{ text = "I SENSE FEAR", yell = true },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "black pearl", chance = 22780, maxCount = 4 },
	{ name = "small sapphire", chance = 28370, maxCount = 6 },
	{ name = "gold coin", chance = 35500, maxCount = 100 },
	{ name = "gold coin", chance = 55500, maxCount = 98 },
	{ name = "platinum coin", chance = 59000, maxCount = 19 },
	{ name = "crystal coin", chance = 1000, maxCount = 1 },
	{ name = "life crystal", chance = 2500 },
	{ name = "war axe", chance = 1290 },
	{ name = "golden armor", chance = 1260 },
	{ name = "magic plate armor", chance = 800 },
	{ name = "royal helmet", chance = 2020 },
	{ name = "power bolt", chance = 15190, maxCount = 15 },
	{ name = "hardened bone", chance = 16180, maxCount = 2 },
	{ id = 6299, chance = 1150 }, -- death ring
	{ name = "demonic essence", chance = 12460 },
	{ name = "assassin star", chance = 26650, maxCount = 5 },
	{ name = "dragon slayer", chance = 1860 },
	{ name = "dragonbone staff", chance = 6000 },
	{ name = "ultimate mana potion", chance = 21490, maxCount = 2 },
	{ name = "ultimate health potion", chance = 21200, maxCount = 3 },
	{ name = "divine plate", chance = 430 },
	{ name = "skullcracker armor", chance = 290 },
	{ name = "gold ingot", chance = 570 },
	{ name = "unholy bone", chance = 33380 },
	{ id = 24978, chance = 3700, maxCount = 1},
	{ name = "spellweaver's robe", chance = 1360 }
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -880 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -490, range = 1, effect = CONST_ME_BIG_SCRATCH, target = true },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -225, maxDamage = -780, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -990, length = 8, spread = 3, effect = CONST_ME_BLACKSMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -700, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "big energy ring", interval = 2000, chance = 15, minDamage = -300, maxDamage = -890, range = 7, target = false },
	{ name = "energy chain", interval = 2000, chance = 14, minDamage = -600, maxDamage = -1000, range = 3, target = true }

}

monster.defenses = {
	defense = 40,
	armor = 40,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
