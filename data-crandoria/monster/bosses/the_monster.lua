local mType = Game.createMonsterType("The Monster")
local monster = {}

monster.description = "The Monster"
monster.experience = 300000
monster.outfit = {
	lookType = 1600
}

monster.health = 600000
monster.maxHealth = 600000
monster.race = "blood"
monster.corpse = 42247
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
}

monster.events = {
	"themonsterDeath",
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
	{ id = 4049, chance = 20000 },
	{name = "platinum coin", chance = 100000, maxCount = 33},
	{name = "ultimate health potion", chance = 50000, maxCount = 8},
	{name = "energy bar", chance = 100000},
	{name = "ultimate spirit potion", chance = 63310, maxCount = 14},
	{name = "supreme health potion", chance = 53240, maxCount = 6},
	{name = "ultimate mana potion", chance = 47480, maxCount = 20},
	{id= 3039, chance = 32370}, -- red gem
	{name = "yellow gem", chance = 28780},
	{name = "berserk potion", chance = 24460, maxCount = 10},
	{name = "blue gem", chance = 18710},
	{name = "mastermind potion", chance = 17990, maxCount = 10},
	{name = "green gem", chance = 17270},
	{name = "crystal coin", chance = 65270},
	{name = "bullseye potion", chance = 13670, maxCount = 10},
	{name = "violet gem", chance = 6470},
	{name = "giant sapphire", chance = 4320},
	{name = "giant emerald", chance = 4320},
	{name = "giant ruby", chance = 2880},
	{id = 40588, chance = 50},
	{id = 40589, chance = 50},
	{id = 40590, chance = 50},
	{id = 40591, chance = 50},
	{id = 40592, chance = 50},
	{id = 40593, chance = 50},
	{id = 40594, chance = 50},
	{id = 40595, chance = 50},
	{id = 40592, chance = 50},
	{ id = 39136, chance = 5000 }, -- perdao real
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -2900},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HOLYDAMAGE, minDamage = -700, maxDamage = -1900, range = 7, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYDAMAGE, target = true},
	{name ="combat", interval = 3000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -650, maxDamage = -1800, range = 7, radius = 4, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = true},
	{name ="energy chain", interval = 2000, chance = 25, minDamage = -850, maxDamage = -1500, range = 6, target = true}
}

monster.defenses = {
	defense = 18,
	armor = 24
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{name ="speed", interval = 5000, chance = 20, speedChange = 100, effect = CONST_ME_MAGIC_RED, target = false, duration = 30000},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = true}
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