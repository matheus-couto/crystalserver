local mType = Game.createMonsterType("Evil Santa")
local monster = {}

monster.description = "Evil Santa"
monster.experience = 50000000
monster.outfit = {
	lookType = 160,
	lookHead = 94,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 94,
    	lookAddons = 3
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 350
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

monster.events = {
	"apocalypseDeath",
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
	{text = "BOW TO THE POWER OF THE RUTHLESS SEVEN!", yell = true},
	{text = "DESTRUCTION!", yell = true},
	{text = "CHAOS!", yell = true},
	{text = "DEATH TO ALL!", yell = true}
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{name = "black pearl", chance = 35000, maxCount = 35},
	{name = "boots of haste", chance = 54000},
	{id = 3076, chance = 22500}, -- crystal ball
	{name = "crystal necklace", chance = 21500},
	{id = 3007, chance = 15500}, -- crystal ring
	{name = "demon shield", chance = 55500},
	{name = "devil helmet", chance = 51000},
	{name = "dragon hammer", chance = 54500},
	{id = 3051, chance = 13500}, -- energy ring
	{name = "fire axe", chance = 47000},
	{name = "giant sword", chance = 32500},
	{name = "platinum coin", chance = 1000000, maxCount = 100},
	{name = "crystal coin", chance = 1000000, maxCount = 50},
	{name = "gold ring", chance = 58000},
	{name = "golden legs", chance = 55000},
	{name = "giant ruby", chance = 51500},
	{name = "giant sapphire", chance = 51500},
	{name = "giant emerald", chance = 51500},
	{name = "mastermind shield", chance = 57500},
	{name = "silver dagger", chance = 55500},
	{name = "skull staff", chance = 75000},
	{name = "talon", chance = 74000, maxCount = 27}, 
	{name = "thunder hammer", chance = 55500, unique = true},
	{id = 3002, chance = 5100}, -- voodoo doll
	{name = "white pearl", chance = 12500, maxCount = 35},
	{id = 6508, chance = 75000},
	{id = 6507, chance = 50000},
	{id = 6506, chance = 25000},
	{id = 26186, chance = 75000},
	{id = 36875, chance = 50000},
	{id = 9099, chance = 50000},
	{id = 5890, chance = 50000, minCount = 5, maxCount = 12},
	{id = 5878, chance = 50000, minCount = 5, maxCount = 12},
	{id = 5877, chance = 50000, minCount = 5, maxCount = 12},
	{id = 5879, chance = 50000, minCount = 1, maxCount = 3},
	{id = 11492, chance = 50000, minCount = 5, maxCount = 12},
	{id = 9685, chance = 50000, minCount = 5, maxCount = 12},
	{id = 5912, chance = 50000, minCount = 2, maxCount = 4},
	{id = 5911, chance = 50000, minCount = 2, maxCount = 4},
	{id = 5914, chance = 50000, minCount = 2, maxCount = 4},
	{id = 5910, chance = 50000, minCount = 2, maxCount = 4},
	{id = 5909, chance = 50000, minCount = 2, maxCount = 4},
	{id = 5913, chance = 50000, minCount = 2, maxCount = 4},
	{id = 16244, chance = 15000},
	{id = 2993, chance = 5000},
	{id = 23677, chance = 25000},
	{id = 6526, chance = 1000000, minCount = 3, maxCount = 5},
	{id = 3030, chance = 50000, minCount = 5, maxCount = 15},
	{id = 3033, chance = 50000, minCount = 5, maxCount = 15},
	{id = 9057, chance = 50000, minCount = 5, maxCount = 15},
	{id = 3029, chance = 50000, minCount = 5, maxCount = 15},
	{id = 3032, chance = 50000, minCount = 5, maxCount = 15},
	-- {id = 9220, chance = 1000000, unique = true},
	-- {id = 37052, chance = 250, maxCount = 1},
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{name = "Dragon Lord", chance = 20, interval = 2000, count = 1},
		{name = "Dragon Lord", chance = 20, interval = 2000, count = 1}
	}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -300},
	{name ="combat", interval = 1000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -250, radius = 9, effect = CONST_ME_MORTAREA, target = false},
	{name ="speed", interval = 1000, chance = 15, speedChange = -200, minDamage = -100, maxDamage = -200, radius = 6, effect = CONST_ME_REDSMOKE, target = false, duration = 60000},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -100, maxDamage = -200, radius = 5, effect = CONST_ME_HITAREA, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -300, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name = "flame guardian vortex", interval = 2000, chance = 10, minDamage = -100, maxDamage = -200, range = 5, target = false },
	{name = "bakragore vortex", interval = 2000, chance = 10, minDamage = -100, maxDamage = -200, range = 5, target = false },
}

monster.defenses = {
	defense = 145,
	armor = 188,
	{name ="combat", interval = 3000, chance = 5, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 8, speedChange = 480, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
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
