local mType = Game.createMonsterType("The Ancient Shell")
local monster = {}

monster.description = "The Ancient Shell"
monster.experience = 5000000
monster.outfit = {
	lookTypeEx = 13335,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 800000
monster.maxHealth = 800000
monster.race = "blood"
monster.corpse = 33905
monster.speed = 185
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 1000,
	chance = 10,
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 4,
	color = 215,
}

monster.summon = {
	maxSummons = 5,
	summons = {
		{ name = "ocean's burster", chance = 50, interval = 4000, count = 1 },
		{ name = "sea demon", chance = 50, interval = 4000, count = 1 },
		{ name = "water abomination", chance = 50, interval = 4000, count = 2 },
	},
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
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 238, chance = 25000, maxCount = 12},
	{ id = 239, chance = 25000, maxCount = 13},
	{ id = 7643, chance = 15000, maxCount = 10},
	{ id = 23373, chance = 15000, maxCount = 10},
	{ id = 23374, chance = 15000, maxCount = 12},
	{ id = 7642, chance = 25000, maxCount = 11},
--	{ id = 43733, chance = 1000 }, -- rabbit token
	{ id = 39136, chance = 4000 }, -- perdao real
	{ id = 39135, chance = 100000 }, -- perola de morseman 
	{ id = 35909, chance = 100, maxCount = 1},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -2500 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_ICEDAMAGE, minDamage = -2300, maxDamage = -2840, range = 7, radius = 4, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "giant ice ring", interval = 2000, chance = 20, minDamage = -2800, maxDamage = -3750, range = 6, target = false },
	{ name = "combat", interval = 1500, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = 3730, range = 7, radius = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 1800, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -4000, maxDamage = -6000, range = 6, length = 5, spread = 3, effect = CONST_ME_SMALLPLANTS, target = false },

}

monster.defenses = {
	defense = 60,
	armor = 180,
	--	mitigation = ???,
	{ name = "combat", interval = 4000, chance = 10, type = COMBAT_HEALING, minDamage = 4000, maxDamage = 8000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
