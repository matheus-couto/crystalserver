local mType = Game.createMonsterType("The Vermin Queen")
local monster = {}

monster.description = "The Vermin Queen"
monster.experience = 10000000
monster.outfit = {
	lookTypeEx = 14049
}

monster.health = 1250000
monster.maxHealth = 1250000
monster.race = "fire"
monster.corpse = 13940
monster.speed = 0
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
	{ id = 3035, chance = 100000, maxCount = 86 },
	{ id = 3043, chance = 20000, maxCount = 6 },
	{ id = 3043, chance = 100000, maxCount = 5 },
--	{ id = 43733, chance = 1000 }, -- rabbit token
	{ id = 39136, chance = 4000 }, -- perdao real
	{ id = 8054, chance = 500, maxCount = 1},
	{ id = 35909, chance = 100, maxCount = 1},
	{ id = 8827, chance = 10000, maxCount = 1 }, -- perdao real
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Queen Sentinel", chance = 15, interval = 2000, count = 2}
	}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -3000},
	{ name = "vermin queen wave", interval = 1000, chance = 100, minDamage = -2500, maxDamage = -4500, range = 8, target = false },
	{ name = "Stun Pulse", interval = 2000, chance = 20, minDamage = -2500, maxDamage = -4800, range = 4, target = false},
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -2800, maxDamage = -4250, range = 6, target = true},
	{ name = "poison chain", interval = 2000, chance = 20, minDamage = -2800, maxDamage = -4250, range = 6, target = true},
	{name ="combat", interval = 1000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -3500, radius = 9, effect = CONST_ME_MORTAREA, target = false},
	{name ="speed", interval = 1000, chance = 12, speedChange = -1050, radius = 6, effect = CONST_ME_POISONAREA, target = false, duration = 30000},

}

monster.defenses = {
	defense = 145,
	armor = 188,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 4000, maxDamage = 6000, effect = CONST_ME_MAGIC_BLUE, target = false},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -20},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 5},
	{type = COMBAT_DEATHDAMAGE , percent = 5}
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
