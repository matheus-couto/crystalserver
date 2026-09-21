local mType = Game.createMonsterType("Cannibal Iks Spearman")
local monster = {}

monster.description = "a cannibal iks spearman"
monster.experience = 10200
monster.outfit = {
	lookType = 1588,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 10700
monster.maxHealth = 10700
monster.race = "blood"
monster.corpse = 42057
monster.speed = 195
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
	{ text = "Pucataaan!", yell = false },
	{ text = "Mahrrrca!", yell = false },
	{ text = "Puccahtaaan!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
--	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "gold coin", chance = 100000, maxCount = 382 },
	{ name = "platinum coin", chance = 66000, maxCount = 47 },
	{ id = 3043, chance = 10200, maxCount = 1 },
	{ name = "violet crystal shard", chance = 19870 },
	{ name = "green crystal splinter", chance = 16350 },
	{ name = "ultimate spirit potion", chance = 6360, maxCount = 2 },
	{ name = "small sapphire", chance = 11940 },
	{ name = "royal spear", chance = 5960, maxCount = 2 },
	{ id = 3007, chance = 1760 }, -- crystal ring
	{ name = "rotten feather", chance = 1910 },
	{ name = "ritual tooth", chance = 1840 },
	{ name = "gold-brocaded cloth", chance = 960 },
	-- { name = "broken iks spear", chance = 110 },
	{ name = "broken iks headpiece", chance = 75 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1175 },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -1030, range = 4, shootEffect = CONST_ANI_ENCHANTEDSPEAR, target = true },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -510, maxDamage = -975, radius = 2, effect = CONST_ME_EXPLOSIONHIT, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -650, range = 5, radius = 1, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
}

monster.defenses = {
	defense = 30,
	armor = 40,
	mitigation = 0.99,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
