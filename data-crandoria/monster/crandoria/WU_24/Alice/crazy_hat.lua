local mType = Game.createMonsterType("Crazy Hat")
local monster = {}

monster.description = "Crazy Hat"
monster.experience = 10000000
monster.outfit = {
	lookType = 132,
	lookHead = 0,
	lookBody = 94,
	lookLegs = 114,
	lookFeet = 94,
	lookAddons = 3,
	lookMount = 0,
}



monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "blood"
monster.corpse = 6560
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 20,
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
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
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
	{ text = "May the embrace of darkness kill you!", yell = false },
	{ text = "I'm the one and only mistress of shadows!", yell = false },
	{ text = "Blackout!", yell = false },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ id = 3035, chance = 100000, maxCount = 86 },
	{ id = 3043, chance = 20000, maxCount = 6 },
	{ id = 3043, chance = 100000, maxCount = 5 },
--	{ id = 43733, chance = 1000 }, -- rabbit token
	{ id = 39136, chance = 4000 }, -- perdao real
	{ id = 396, chance = 100000 }, -- crazy hat's beard
	{ id = 35909, chance = 100, maxCount = 1},
}


monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -1800 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -1200, maxDamage = -1500, radius = 8, effect = CONST_ME_MORTAREA, target = false },
	{ name = "crazy hat explosions", interval = 2500, chance = 100, minDamage = -2500, maxDamage = -3500, target = false, range = 7 },
	{ name = "death chain", interval = 2000, chance = 25, range = 6, minDamage = -1400, maxDamage = -3000, target = true },
	{ name = "Crazy Hat Teleporter", interval = 15000, chance = 100, range = 8 },
	{ name = "boss break", interval = 2000, chance = 100, target = false},
}

monster.defenses = {
	defense = 65,
	armor = 55,
	--	mitigation = ???,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 3500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 1 },
	{ type = COMBAT_DEATHDAMAGE, percent = 80 },
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
