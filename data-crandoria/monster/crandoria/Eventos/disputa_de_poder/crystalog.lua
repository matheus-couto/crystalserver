local mType = Game.createMonsterType("Crystalog")
local monster = {}

monster.description = "Crystalog"
monster.experience = 150000000
monster.outfit = {
	lookType = 1541,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 1500000
monster.maxHealth = 1500000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 200
monster.manaCost = 0

monster.events = {
	"bossDisputaKill",
}

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 50,
	health = 10,
	random = 30,
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

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Icecold Book", chance = 30, interval = 2000, count = 2}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ id = 3043, chance = 100000, minCount = 8, maxCount = 22 },
	{ id = 3043, chance = 5000, maxCount = 1 },
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -3000},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -2850, maxDamage = -4500, range = 7, radius = 6, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -2890, maxDamage = -4500, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -2400, maxDamage = -4180, range = 8, radius = 5, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 1800, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -3850, maxDamage = -6400, radius = 8, spread = 3, length = 8, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -2900, maxDamage = -5150, range = 7, radius = 5, effect = CONST_ME_ICEAREA, target = false},
	{name ="ice chain", interval = 2000, chance = 20, minDamage = -1500, maxDamage = -2800, range = 7},
	{ name = "condition", type = CONDITION_FREEZING, interval = 2000, chance = 5, minDamage = -1000, maxDamage = -3160, radius = 3, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "condition", type = CONDITION_FREEZING, interval = 2000, chance = 5, minDamage = -1000, maxDamage = -3160, length = 8, spread = 3, effect = CONST_ME_ICEAREA, target = false },
}

monster.defenses = {
	defense = 65,
	armor = 155,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 2500, maxDamage = 5000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 4000, chance = 80, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
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
