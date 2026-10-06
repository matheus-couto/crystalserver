local mType = Game.createMonsterType("Apocalypse")
local monster = {}

monster.description = "Apocalypse"
monster.experience = 10000000
monster.outfit = {
	lookType = 12,
	lookHead = 38,
	lookBody = 114,
	lookLegs = 0,
	lookFeet = 94,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 350
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	{id = 3025, chance = 13500}, -- ancient amulet
	{id = 3116, chance = 19000}, -- big bone
	{name = "black pearl", chance = 15000, maxCount = 35},
	{name = "boots of haste", chance = 14000},
	{id = 3076, chance = 22500}, -- crystal ball
	{name = "crystal necklace", chance = 21500},
	{id = 3007, chance = 15500}, -- crystal ring
	{name = "demon shield", chance = 15500},
	{name = "devil helmet", chance = 11000},
	{name = "dragon hammer", chance = 34500},
	{id = 3051, chance = 13500}, -- energy ring
	{name = "fire axe", chance = 17000},
	{name = "giant sword", chance = 12500},
	{name = "platinum coin", chance = 69900, maxCount = 100},
	{name = "platinum coin", chance = 68800, maxCount = 100},
	{name = "crystal coin", chance = 47700, maxCount = 12},
	{name = "crystal coin", chance = 36600, maxCount = 15},
	{name = "gold ring", chance = 28000},
	{name = "golden legs", chance = 15000},
	{name = "giant ruby", chance = 31500},
	{name = "giant sapphire", chance = 31500},
	{name = "giant emerald", chance = 31500},
	{name = "mastermind shield", chance = 17500},
	{name = "silver dagger", chance = 15500},
	{name = "skull staff", chance = 25000},
	{name = "talon", chance = 14000, maxCount = 27}, 
	{name = "teddy bear", chance = 10500},
	{name = "thunder hammer", chance = 3500},
	{id = 3002, chance = 5100}, -- voodoo doll
	{name = "white pearl", chance = 12500, maxCount = 35},
	{id = 28915, chance = 150, maxCount = 1},
	{id = 28917, chance = 150, maxCount = 1},
	-- {id = 37052, chance = 250, maxCount = 1},
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{name = "Infernal Demon", chance = 20, interval = 2000, count = 1},
		{name = "Infernal Demon", chance = 20, interval = 2000, count = 1}
	}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 230, attack = 240, minDamage = -1350, maxDamage = -5000},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -8800, radius = 9, effect = CONST_ME_MORTAREA, target = false},
	{name ="speed", interval = 1000, chance = 18, speedChange = -800, minDamage = -5000, maxDamage = -8800, radius = 6, effect = CONST_ME_REDSMOKE, target = false, duration = 60000},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -2900, maxDamage = -6150, radius = 5, effect = CONST_ME_HITAREA, target = false},
	{name ="combat", interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -2500, maxDamage = -4400, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -2500, radius = 10, effect = CONST_ME_ENERGYAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -5800, maxDamage = -9200, length = 8, spread = 3, effect = CONST_ME_BLUE_ENERGY_SPARK, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 5000, chance = 18, minDamage = -2000, maxDamage = -6000, effect = CONST_ME_HITBYPOISON, target = false},
	{name ="combat", interval = 2000, chance = 6, type = COMBAT_LIFEDRAIN, minDamage = -2900, maxDamage = -6000, radius = 14, effect = CONST_ME_MAGIC_GREEN, target = false}
}

monster.defenses = {
	defense = 145,
	armor = 188,
	{name ="combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 3000, maxDamage = 10000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 8, speedChange = 480, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 100},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -15},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
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
