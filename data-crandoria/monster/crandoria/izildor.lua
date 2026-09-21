local mType = Game.createMonsterType("Izildor")
local monster = {}

monster.description = "Izildor"
monster.experience = 30000000
monster.outfit = {
	lookType = 145,
	lookHead = 57,
	lookBody = 96,
	lookLegs = 23,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 800000
monster.maxHealth = 800000
monster.race = "blood"
monster.corpse = 0
monster.speed = 105
monster.manaCost = 0


monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 3000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 100,
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
	targetDistance = 4,
	runHealth = 800000,
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
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3043, chance = 100000, minCount = 1, maxCount = 4 },
	{ id = 3035, chance = 66666, maxCount = 35 },
	{ id = 7643, chance = 88100, maxCount = 6 },
	{ id = 238, chance = 84100, maxCount = 8 },
	{ id = 23373, chance = 84100, maxCount = 14 },
	{ id = 23375, chance = 84100, maxCount = 12 },
	{ id = 30059, chance = 55000, maxCount = 1 },
	{ id = 30060, chance = 55000, maxCount = 1 },
	{ id = 30061, chance = 55000, maxCount = 1 },
	{ id = 3079, chance = 55000, maxCount = 1 },
	{ id = 3420, chance = 25000, maxCount = 1 },
	{ id = 3389, chance = 100, maxCount = 1, unique = true }, -- sim, eu coloquei
	-- { id = 24873, chance = 5000, maxCount = 1, unique = true },
	{ id = 3035, chance = 100000, minCount = 10, maxCount = 73 },
	{ id = 22721, chance = 33333, minCount = 1, maxCount = 2 },
	{ id = 3414, chance = 15600 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -150, maxDamage = -1500 },
	{ name = "combat", interval = 1800, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -1900, range = 5, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "extended fire chain", interval = 2000, chance = 20, minDamage = -650, maxDamage = -2200, range = 5, target = true },
	{ name = "manadrain explosion", interval = 2000, chance = 20, minDamage = -350, maxDamage = -600, range = 5, target = true },
	{ name = "energy chain", interval = 2000, chance = 20, minDamage = -1650, maxDamage = -2200, range = 5, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 82,
	--	mitigation = ???,
	{ name = "speed", interval = 1000, chance = 30, speedChange = 120, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 35 },
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
