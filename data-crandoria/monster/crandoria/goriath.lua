local mType = Game.createMonsterType("Goriath")
local monster = {}

monster.description = "Goriath"
monster.experience = 4000000
monster.outfit = {
	lookType = 862,
	lookHead = 114,
	lookBody = 38,
	lookLegs = 75,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 850000
monster.maxHealth = 850000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 225
monster.manaCost = 0

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
	{name = "platinum coin", chance = 100000, maxCount = 45},
	{name = "piggy bank", chance = 100000},
	{name = "energy bar", chance = 100000},
	{name = "silver token", chance = 50000, maxCount = 2},
	{name = "gold token", chance = 50000, maxCount = 3},
	{name = "ultimate spirit potion", chance = 63310, maxCount = 14},
	{name = "supreme health potion", chance = 53240, maxCount = 6},
	{name = "ultimate spirit potion", chance = 47480, maxCount = 20},
	{name = "huge chunk of crude iron", chance = 40290},
	{id= 3039, chance = 32370}, -- red gem
	{name = "yellow gem", chance = 28780},
	{name = "berserk potion", chance = 24460, maxCount = 10},
	{name = "bullseye potion", chance = 13670, maxCount = 10},
	{name = "chaos mace", chance = 13670},
	{name = "gold ingot", chance = 12950},
	{id = 23544, chance = 10070}, -- collar of red plasma
	{id = 23542, chance = 9350}, -- collar of blue plasma
	{id = 23531, chance = 8630}, -- ring of green plasma
	{name = "ring of the sky", chance = 8630},
	{id = 23543, chance = 7910}, -- collar of green plasma
	{name = "violet gem", chance = 6470},
	{name = "magic sulphur", chance = 6470},
	{id = 23529, chance = 5040}, -- ring of blue plasma
	{id = 23533, chance = 5040}, -- ring of red plasma
	{name = "dragon figurine", chance = 5040},
	{name = "giant sapphire", chance = 4320},
	{name = "giant emerald", chance = 4320},
	{id = 3341, chance = 180}, -- arcane staff
	{name = "giant ruby", chance = 2880},
	{name = "abyss hammer", chance = 860},
	{id= 3364, chance = 32370},
	{id= 3366, chance = 32370},
	{id= 3554, chance = 32370},
	{id= 5913, chance = 32370, maxCount = 5},
	{id= 3555, chance = 50},
	{id= 3387, chance = 170},
	{id = 12669, chance = 150 },
	-- { id = 37052, chance = 100 },
	-- {id = 35909, chance = 150, maxCount = 1},
	{ id = 12811, chance = 200, unique = true },
	{id = 39707, chance = 250, unique = true },
	-- {id = 19358, chance = 100, maxCount = 1}
}

monster.summon = {
	maxSummons = 3,
	summons = {
		{name = "Black Hydra", chance = 20, interval = 2000, count = 1}
	}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -1200, maxDamage = -3000},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -3000, maxDamage = -8600, radius = 4, range = 5, effect = CONST_ME_STONES, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -3200, maxDamage = -6400, range = 4, radius = 3, effect = CONST_ME_BLACKSMOKE, target = true},
	{name = "goriath explosion", interval = 1500, chance = 15, minDamage = -3500, maxDamage = -6700, effect = CONST_ME_MORTAREA, effect = CONST_ME_GHOSTLY_SCRATCH},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -3400, maxDamage = -5200, range = 7, length = 7, spread = 3, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -1500, maxDamage = -3000, range = 6, length = 10, spread = 3, effect = CONST_ME_DRAWBLOOD, target = false},
	{name = "great poison ring", interval = 2000, chance = 15, minDamage = -2800, maxDamage = -4500, range = 6, targe = false},
	{name = "manadrain ring", interval = 2000, chance = 15, minDamage = -3500, maxDamage = -6700 }
}

monster.defenses = {
	defense = 36,
	armor = 44
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 50},
	{type = COMBAT_ENERGYDAMAGE, percent = -15},
	{type = COMBAT_EARTHDAMAGE, percent = 80},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
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
