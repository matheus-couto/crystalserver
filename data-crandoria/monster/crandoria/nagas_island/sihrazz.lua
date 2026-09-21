local mType = Game.createMonsterType("Sihrazz Shadow")
local monster = {}

monster.description = "Sihrazz Shadow"
monster.experience = 200000
monster.outfit = {
	lookType = 1538,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 80
monster.maxHealth = 80
monster.race = "blood"
monster.corpse = 39217
monster.speed = 230
monster.manaCost = 0

monster.events = {
	"rebelNagaKill",
}

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
	staticAttackChance = 90,
	targetDistance = 4,
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
	-- -- { id = 3250, chance = 1975, maxCount = 1 },
	{ name = "Platinum Coin", chance = 75420, minCount = 12, maxCount = 28 },
	{ name = "Crystal Coin", chance = 90000, minCount = 1, maxCount = 5 },
	{ name = "Violet Crystal Shard", chance = 54580, minCount = 12, maxCount = 22 },
	{ name = "Corrupt Naga Scales", chance = 87720 },
	{ name = "platinum coin", chance = 50000, maxCount = 53 },
	{ name = "platinum coin", chance = 50000, maxCount = 53 },
	{ name = "naga earring", chance = 1000000 },
	{ name = "naga armring", chance = 1000000 },
	{ id = 3007, chance = 51330 }, -- crystal ring
	{ name = "blue crystal shard", chance = 1880 },
	{ name = "ornate crossbow", chance = 20630 },
	{ id = 8050, chance = 3000 }, -- cryst. armor
	{ id = 16096, chance = 15000 }, -- wand of defiance
	{ id = 3057, chance = 30000 }, -- aol
	{ id = 3053, chance = 50000 }, -- time ring
	{ id = 3048, chance = 50000 }, -- m ring
	{ name = "emerald bangle", chance = 55630 },
	{ name = "silver brooch", chance = 310 },
	{ id = 17514, chance = 1000, unique = true }, -- kit encant
	{ id = 4050, chance = 250, unique = true }, -- caixa pandora
	{ id = 33309, chance = 10000, unique = true }, -- gema antiga
	{ id = 33306, chance = 5000, unique = true }, -- gema de onyx
	{ id = 33307, chance = 2500, unique = true }, -- gema arco-iris
	{ id = 33311, chance = 1500, unique = true }, -- gema lunar

}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -2500, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_PURPLEENERGY, target = true },
	{ name = "nagadeath", interval = 2000, chance = 30, target = false, minDamage = -1500, maxDamage = -2800 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -1950, radius = 14, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "death explosion", interval = 2000, chance = 15, minDamage = -2050, maxDamage = -3380, range = 8, target = false },
	{ name = "nagadeathattack", interval = 3000, chance = 30, target = true, minDamage = -1600, maxDamage = -3000 },
}

monster.defenses = {
	defense = 80,
	armor = 50,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
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
