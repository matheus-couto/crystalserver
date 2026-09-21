local mType = Game.createMonsterType("Eddgar")
local monster = {}

monster.description = "Eddgar"
monster.experience = 500000000
monster.outfit = {
	lookType = 268,
	lookHead = 58,
	lookBody = 2,
	lookLegs = 114,
	lookFeet = 95,
    	lookAddons = 0,
}

monster.health = 3000000
monster.maxHealth = 3000000
monster.race = "undead"
monster.corpse = 111
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
	nearest = 40,
	health = 10,
	random = 30,
	damage = 20,
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
	{ id = 3043, chance = 100000, maxCount = 28 },
	{ id = 3555, chance = 2000, maxCount = 1, unique = true },
	{ id = 3035, chance = 100000, maxCount = 85 },
	{ id = 22720, chance = 100000, minCount = 14, maxCount = 25 },
	{ id = 22516, chance = 100000, minCount = 14, maxCount = 25 },
	{ id = 22724, chance = 100000, minCount = 14, maxCount = 25 },
	{ id = 22706, chance = 10000, maxCount = 1 },
	{ id = 34109, chance = 2000, maxCount = 1 },
	{ id = 22739, chance = 25000, maxCount = 1, unique = true },
	{ id = 31633, chance = 10000, maxCount = 1, unique = true },
	{ id = 36827, chance = 15000, maxCount = 1, unique = true },
	{ id = 9099, chance = 50000, maxCount = 1 },
	{ id = 10290, chance = 3000, maxCount = 1 },
	{ id = 3422, chance = 5000, maxCount = 1, unique = true },
	{ id = 3555, chance = 500, maxCount = 1, unique = true },
	{ id = 3414, chance = 75000, maxCount = 1 },
	{ id = 3366, chance = 10000, maxCount = 1 },
	{ id = 3364, chance = 5000, maxCount = 1 },
	{ id = 39136, chance = 10000, maxCount = 1 },
	{ id = 20138, chance = 500, maxCount = 1 },
	{ id = 40535, chance = 500, maxCount = 1 },
	{ id = 22724, chance = 50000, maxCount = 3 },
	{ id = 22721, chance = 50000, maxCount = 3 },
	{ id = 22516, chance = 50000, maxCount = 3 },
	{ id = 3386, chance = 50000, maxCount = 1 },
	{ id = 3079, chance = 50000, maxCount = 1 },
	{ id = 8778, chance = 20000, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250 },
	{ name = "combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -300, range = 7, radius = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_BLACKSMOKE, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -300, range = 7, shootEffect = CONST_ANI_POISON, target = false },
	{ name = "undead dragon curse", interval = 2000, chance = 15, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -200, length = 8, spread = 3, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "drunk", interval = 4000, chance = 30, radius = 6, effect = CONST_ME_SOUND_RED, target = false, duration = 30000 },
	{ name = "bakragore vortex", interval = 2000, chance = 20, minDamage = -185, maxDamage = -250, range = 7, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 45,
	{ name = "combat", interval = 5000, chance = 15, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1500, effect = CONST_ME_MAGIC_RED, target = false },
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

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
