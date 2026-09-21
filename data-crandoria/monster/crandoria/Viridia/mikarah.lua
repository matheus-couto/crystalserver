local mType = Game.createMonsterType("Mikarah")
local monster = {}

monster.description = "Mikarah"
monster.experience = 500000
monster.outfit = {
	lookType = 91
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "fire"
monster.corpse = 6031
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 40
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
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ id = 3043, chance = 55000, minCount = 1, maxCount = 2 },
	{ id = 3035, chance = 75000, minCount = 35, maxCount = 56 },
	{ id = 3035, chance = 75000, minCount = 15, maxCount = 42 },
	{ id = 3042, chance = 10000, minCount = 1, maxCount = 2 },
	{ id = 9649, chance = 75000, minCount = 1, maxCount = 5 },
	{ id = 3334, chance = 150, maxCount = 1, unique = true },
	{ id = 20205, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 22728, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 14081, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 9663, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 28567, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 22730, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 23507, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 22053, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 10302, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 17458, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 25702, chance = 5000, minCount = 1, maxCount = 3 },
	{ id = 25694, chance = 5000, minCount = 1, maxCount = 3 },

}

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "ancient scarab", chance = 10, interval = 2000, count = 1 },
		{ name = "giant spider", chance = 10, interval = 2000, count = 1 },
		{ name = "dragon lord", chance = 5, interval = 2000, count = 1 },
	},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 230, attack = 240},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1500, radius = 9, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1500, radius = 9, effect = CONST_ME_MORTAREA, target = false},
}

monster.defenses = {
	defense = 155,
	armor = 188,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 8, speedChange = 480, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -25},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 100},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
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
