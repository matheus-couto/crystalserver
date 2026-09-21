local mType = Game.createMonsterType("Ancient Wyrm")
local monster = {}

monster.description = "the Ancient Wyrm"
monster.experience = 100000
monster.outfit = {
	lookType = 928,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "undead"
monster.corpse = 6305
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 5,
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
	rewardBoss = true,
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
}

monster.loot = {
	{ id = 3043, chance = 50000, maxCount = 8 },
	{ id = 3043, chance = 50000, maxCount = 5 },
	{ id = 3035, chance = 50000, maxCount = 85 },
	{ id = 22720, chance = 1000000, minCount = 2, maxCount = 4 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -3500 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -2200, maxDamage = -4650, range = 7, radius = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_BLACKSMOKE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -2630, maxDamage = -6805, range = 7, shootEffect = CONST_ANI_FIRE, target = false },
	{ name = "undead dragon curse", interval = 2000, chance = 15, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -1300, maxDamage = -4780, length = 8, spread = 3, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "bakragore vortex", interval = 2000, chance = 20, minDamage = -2200, maxDamage = -3650, range = 7, target = false },
}

monster.defenses = {
	defense = 124,
	armor = 92,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 3450, maxDamage = 5550, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
