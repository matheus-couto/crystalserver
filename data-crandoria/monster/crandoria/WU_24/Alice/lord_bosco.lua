local mType = Game.createMonsterType("Lord Bosco")
local monster = {}

monster.description = "Lord Bosco"
monster.experience = 5000000
monster.outfit = {
	lookType = 1260,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 750000
monster.maxHealth = 750000
monster.race = "undead"
monster.corpse = 32109
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
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
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "sulphur elemental", chance = 15, interval = 2000, count = 1 },
		{ name = "vein parasite", chance = 15, interval = 2000, count = 1 },
		{ name = "wild yelothax", chance = 15, interval = 2000, count = 1 },
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
--	{ id = 43733, chance = 1000 }, -- rabbit token
	{ id = 39136, chance = 4000 }, -- perdao real
	{ id = 12235, chance = 100000 }, -- dedao do Lord Bosco
	{ id = 40590, chance = 500, maxCount = 1},
	{ id = 35909, chance = 100, maxCount = 1},
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -2500, maxDamage = -4500 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -1500, maxDamage = -2500, range = 7, radius = 5, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_GROUNDSHAKER, target = true },
	{ name = "Stun Pulse", interval = 2000, chance = 20, minDamage = -2000, maxDamage = -2900,  range = 6, target = false },
	{ name = "poison chain", interval = 2000, chance = 20, minDamage = -2300, maxDamage = -3700, range = 6, target = true },
	{ name = "boss break", interval = 2000, chance = 100, target = false},
	{name ="anomaly break", interval = 2000, chance = 40, target = false},
	
}

monster.defenses = {
	defense = 160,
	armor = 160,
	mitigation = 5.40,
	{ name = "speed", interval = 1000, chance = 20, speedChange = 500, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 1250, maxDamage = 3250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 45 },
	{ type = COMBAT_FIREDAMAGE, percent = 45 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 5 },
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
