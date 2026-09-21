local mType = Game.createMonsterType("Vein Parasite")
local monster = {}

monster.description = "a vein parasite"
monster.experience = 39500
monster.outfit = {
	lookType = 564,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 29230
monster.maxHealth = 29230
monster.race = "blood"
monster.corpse = 18978
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 0
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
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
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3035, chance = 45000, maxCount = 36 },
	{ id = 3043, chance = 2000, maxCount = 1 },
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 238, chance = 25000, maxCount = 2},
	{ id = 239, chance = 25000, maxCount = 3},
	{ id = 7643, chance = 15000, maxCount = 1},
	{ id = 23373, chance = 15000, maxCount = 1},
	{ id = 23374, chance = 15000, maxCount = 2},
	{ id = 7642, chance = 25000, maxCount = 2},
	{ id = 8084, chance = 1800, maxCount = 1},
	{ id = 3039, chance = 2000, maxCount = 1}
--	{ id = 43733, chance = 10 }, -- rabbit token
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -280, maxDamage = -1000},
	{name ="combat", interval = 2100, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -1300, radius = 5, effect = CONST_ME_POISONAREA, target = false},
	{name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 15, minDamage = -400, maxDamage = -600, radius = 4, effect = CONST_ME_DRAWBLOOD, target = false},
	{name = "combat", type = CONDITION_DEATHDAMAGE, interval = 2000, chance = 2000, minDamage = -800, maxDamage = -1400, range = 6, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{name ="white pale paralyze", interval = 2000, chance = 20, target = false}
}

monster.defenses = {
	defense = 11,
	armor = 8,
	{name ="white pale summon", interval = 2000, chance = 12, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -5},
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
