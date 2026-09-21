local mType = Game.createMonsterType("The Flame Guardian")
local monster = {}

monster.name = "The Flame Guardian"
monster.description = "The Flame Guardian"
monster.experience = 3000000
monster.outfit = {
	lookType = 1152,
	lookAddons = 3,
}

monster.health = 750000
monster.maxHealth = 750000
monster.race = "blood"
monster.corpse = 6323
monster.speed = 190
monster.manaCost = 0

monster.events = {
	"flameGuardianDeath",
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
	staticAttackChance = 70,
	targetDistance = 1,

	healthHidden = false,

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
	{ text = "Things are starting to get hot in here!", yell = false },
	{ text = " Come on! Embrace the fire. ", yell = false },
	{ text = " You can't defeat the Holy Flame!", yell = false },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "crystal coin", chance = 100000, maxCount = 22 },
	{name = "fiery heart", chance = 50000, maxCount = 8},
	{ name = "bullseye potion", chance = 24490, maxCount = 5 },
	{ name = "berserk potion", chance = 22449, maxCount = 5 },
	{ name = "mastermind potion", chance = 18367, maxCount = 5 },
	{name = "ultimate health potion", chance = 74300, minCount = 6, maxCount = 14,},
	{name = "ultimate spirit potion", chance = 74300, minCount = 6, maxCount = 10,},
	{name = "ultimate mana potion", chance = 74300, minCount = 6, maxCount = 14,},
	{ name = "giant amethyst", chance = 6122 },
	{id = 818, chance = 45100},
	{id = 821, chance = 45100},
	{id = 826, chance = 45100},
	{id = 827, chance = 45100},
	{ name = "giant ruby", chance = 14082 },
	{ name = "giant emerald", chance = 14082 },
	{ name = "giant sapphire", chance = 12041 },
	{ name = "giant topaz", chance = 12041 },
	{ name = "magic plate armor", chance = 12000},
	{id = 3554, chance = 33400},
	{id = 16115, chance = 22100},
	{id = 3280, chance = 55200},
	{id = 3320, chance = 55200},
	{id = 9301, chance = 56800},
	{id = 23533, chance = 5040}, -- ring of red plasma
	{id = 23544, chance = 10070}, -- collar of red plasma
	{id = 22721, chance = 100000, minCount = 1, maxCount = 3},
	{id = 12669, chance = 150 },
	-- {id = 35909, chance = 50, maxCount = 1},
	-- {id = 5924, chance = 50, maxCount = 1},
	{ id = 39136, chance = 5000 }, -- perdao real
	{ id = 8053, chance = 5000 }, -- fireborn armor
	{ id = 12811, chance = 50 },
	{ id = 19149, chance = 200 },
	
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{name = "Knight of the Holy Flame", chance = 20, interval = 3000, count = 1}
	}
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -3950 },
	{ name = "timira fire ring", interval = 2000, chance = 15, minDamage = -2560, maxDamage = -4925 },
	{ name = "death chain", interval = 2000, chance = 10, minDamage = -1490, maxDamage = -1925, range = 3, target = true },
	{ name = "mana drain chain", interval = 2500, chance = 20, minDamage = -810, maxDamage = -1130 },
	{name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -1450, maxDamage = -4580, radius = 4, effect = CONST_ME_FIREAREA, target = false},
	{name = "great fire ring", interval = 2000, chance = 10, minDamage = -2890, maxDamage = -5950, targe = false},
	{name = "fire cross", interval = 2000, chance = 15, minDamage = -2800, maxDamage = -5300, target = false},
	{name = "flame guardian vortex", interval = 4000, chance = 20, minDamage = -1800, maxDamage = -3500}
	

}

monster.defenses = {
	defense = 68,
	armor = 95,
	mitigation = 2.07,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 50 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
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
