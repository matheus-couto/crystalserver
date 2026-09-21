local mType = Game.createMonsterType("Weakened Frozen King")
local monster = {}

monster.description = "Weakened Frozen King"
monster.experience = 200000000
monster.outfit = {
	lookType = 1337,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 3000000
monster.maxHealth = 3000000
monster.race = "undead"
monster.corpse = 6068
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 10000,
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
	runHealth = 20000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Frost Troll", chance = 100, interval = 2000, count = 4}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "YOUR HOT BLOOD CANT STOP MY COLD HEART", yell = false},
	{text = "IS THAT THE BEST YOU HAVE TO OFFER, IDIOTS?", yell = true},
	{text = "THIS IS NOT A GAME, THIS IS A BATTLE!", yell = true}
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{id = 3007, chance = 8333}, -- crystal ring
	{id = 3043, chance = 32000, maxCount = 4}, -- crystal coin
	{id = 3043, chance = 22000, maxCount = 6}, -- crystal coin
	{name = "white pearl", chance = 25000, maxCount = 15},
	{name = "black pearl", chance = 11111, maxCount = 14},
	{name = "small diamond", chance = 25000, maxCount = 5},
	{name = "small sapphire", chance = 25000, maxCount = 10},
	{name = "small emerald", chance = 25000, maxCount = 10},
	{name = "small amethyst", chance = 25000, maxCount = 17},
	{name = "talon", chance = 12500, maxCount = 7},
	{name = "platinum coin", chance = 100000, maxCount = 69},
	{name = "green gem", chance = 20000},
	{name = "blue gem", chance = 14285},
	{name = "might ring", chance = 12500},
	{id = 3049, chance = 12500}, -- stealth ring
	{id = 3098, chance = 20000}, -- ring of healing
	{name = "golden armor", chance = 18333},
	{name = "magic plate armor", chance = 8333},
	{name = "golden boots", chance = 50},
	{id = 6299, chance = 25000}, -- death ring
	{name = "ultimate mana potion", chance = 20000, maxCount = 18},
	{name = "supreme health potion", chance = 20000, maxCount = 16},
	{name = "glacier kilt", chance = 18333},
	{name = "ultimate spirit potion", chance = 25000, maxCount = 18},
	{name = "ultimate health potion", chance = 25000, maxCount = 16},
	{name = "oceanborn leviathan armor", chance = 16666},
	{name = "frozen plate", chance = 4333},
	{name = "spellbook of warding", chance = 20000},
	{name = "spellbook of mind control", chance = 11111},
	{name = "spellbook of lost souls", chance = 10666},
	{name = "spellscroll of prophecies", chance = 15000},
	{name = "spellbook of dark mysteries", chance = 10000},
	-- {id = 35909, chance = 10, maxCount = 1},
	{ id = 39136, chance = 100000, maxCount = 3 }, -- perdao real
	{ id = 26186, chance = 55000, maxCount = 1 },
	{ id = 20138, chance = 15000, maxCount = 1 },
	{ id = 21154, chance = 20000, maxCount = 1 },
	{ id = 22739, chance = 20000, maxCount = 1 },
	{ id = 36827, chance = 15000, maxCount = 1 },
	{ id = 31633, chance = 10000, maxCount = 1 },
	{ id = 35909, chance = 5000, maxCount = 1 }, -- chaotic gamble
	-- { id = 21872, chance = 35000, maxCount = 1 },
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1550},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -150, maxDamage = -500, range = 7, radius = 6, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -350, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDSWORD, target = true},
	{name ="combat", interval = 1000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -120, maxDamage = -450, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -80, maxDamage = -250, range = 8, radius = 5, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 1800, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -450, radius = 8, spread = 3, length = 8, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 3000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -400, range = 7, radius = 4, effect = CONST_ME_ICEAREA, target = false},
	{name ="ice chain", interval = 2000, chance = 20, minDamage = -180, maxDamage = -350, range = 7}
}

monster.defenses = {
	defense = 65,
	armor = 155,
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 4000, chance = 80, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -25},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
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
