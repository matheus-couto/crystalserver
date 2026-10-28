local mType = Game.createMonsterType("Hellsin")
local monster = {}

monster.description = "Hellsin"
monster.experience = 50000000
monster.outfit = {
	lookType = 1931,
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "undead"
monster.corpse = 36847
monster.speed = 200
monster.manaCost = 0

monster.events = {
	"hellsinHealth",
	"hellsinDeath",
}

monster.changeTarget = {
	interval = 3000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 20
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
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 3043, chance = 100000, minCount = 8, maxCount = 26 },
	{ id = 3035, chance = 100000, minCount = 58, maxCount = 88 },
	{ id = 3031, chance = 100000, minCount = 48, maxCount = 100 },
	{ id = 8778, chance = 100000, unique = true },
	{ id = 23375, chance = 65000, minCount = 8, maxCount = 26 },
	{ id = 23373, chance = 65000, minCount = 8, maxCount = 26 },
	{ id = 23374, chance = 65000, minCount = 8, maxCount = 26 },
	{ id = 22721, chance = 100000, minCount = 3, maxCount = 5 },
	{ id = 22516, chance = 100000, minCount = 3, maxCount = 5 },
	{ id = 22720, chance = 100000, minCount = 1, maxCount = 5 },
	{ id = 3057, chance = 35000 },
	{ id = 3360, chance = 25000 },
	{ id = 3364, chance = 25000 },
	{ id = 3079, chance = 25000 },
	{ id = 3554, chance = 25000 },
	{ id = 3320, chance = 25000 },
	{ id = 827, chance = 25000 },
	{ id = 821, chance = 25000 },
	{ id = 818, chance = 25000 },
	{ id = 826, chance = 25000 },
	{ id = 3280, chance = 25000 },
	{ id = 3034, chance = 25000, minCount = 8, maxCount = 26 },
	{ id = 3030, chance = 25000, minCount = 8, maxCount = 26 },
	{ id = 30059, chance = 25000 },
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 20, minDamage = -600, maxDamage = -2000},
	{name = "bakragore vortex", interval = 2000, chance = 10, minDamage = -1000, maxDamage = -3000, range = 5, target = false },
	{name ="combat", interval = 1500, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1800, maxDamage = -3000, radius = 6, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -2500, maxDamage = -4500, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name = "fire cross", interval = 2000, chance = 15, minDamage = -1800, maxDamage = -2300, target = false},
	{name = "flame guardian vortex", interval = 4000, chance = 20, minDamage = -1800, maxDamage = -2500}
}

monster.defenses = {
	defense = 90,
	armor = 90,
	{name ="combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 30},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent =  0},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
