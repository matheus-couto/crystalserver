local mType = Game.createMonsterType("Cannibal Iks Warrior")
local monster = {}

monster.description = "a cannibal iks warrior"
monster.experience = 9600
monster.outfit = {
	lookType = 1587,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 12550
monster.maxHealth = 12550
monster.race = "blood"
monster.corpse = 42053
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
	{ text = "Chaahrrr!", yell = false },
	{ text = "Hrmmmh!", yell = false },
	{ text = "Cathach!!", yell = false },
	{ text = "Chaahrrr!", yell = false },
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
--	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "platinum coin", chance = 66000, maxCount = 47 },
	{ id = 3043, chance = 10200, maxCount = 1 },
	{ name = "brown crystal splinter", chance = 25500 },
	{ name = "green crystal splinter", chance = 20060 },
	{ name = "small enchanted sapphire", chance = 15100 },
	{ name = "plate shield", chance = 8720 },
	{ name = "onyx chip", chance = 11060, maxCount = 2 },
	{ name = "opal", chance = 9260 },
	{ name = "small emerald", chance = 9820 },
	{ name = "war hammer", chance = 5620 },
	{ name = "ultimate health potion", chance = 8180, maxCount = 2 },
	{ name = "small ruby", chance = 6300, maxCount = 2 },
	{ name = "rotten feather", chance = 3170 },
	{ name = "ritual tooth", chance = 2330 },
	{ name = "gold-brocaded cloth", chance = 1190 },
	{ name = "broken iks sandals", chance = 80 },
	{ name = "broken iks cuirass", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1050, effect = CONST_ME_PURPLEENERGY },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1000, length = 7, spread = 0, effect = 216, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -960, range = 1, radius = 0, effect = CONST_ME_EXPLOSIONHIT, target = true },
}

monster.defenses = {
	defense = 25,
	armor = 60,
	mitigation = 1.32,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 20 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
