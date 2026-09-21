local mType = Game.createMonsterType("Sea Demon")
local monster = {}

monster.description = "a sea demon"
monster.experience = 36800
monster.outfit = {
	lookType = 446,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 33300
monster.maxHealth = 33300
monster.race = "blood"
monster.corpse = 13801
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 50,
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
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 60,
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
	{ id = 3035, chance = 45000, maxCount = 36 },
	{ id = 3043, chance = 2000, maxCount = 1 },
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 238, chance = 25000, maxCount = 2},
	{ id = 239, chance = 25000, maxCount = 3},
	{ id = 7643, chance = 15000, maxCount = 1},
	{ id = 23373, chance = 15000, maxCount = 1},
	{ id = 23374, chance = 15000, maxCount = 2},
	{ id = 7642, chance = 25000, maxCount = 2},
	{ id = 5895, chance = 1000, maxCount = 1},
	{ id = 3027, chance = 6580, maxCount = 7},
	{ id = 3041, chance = 1000, maxCount = 1},
--	{ id = 43733, chance = 10 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -800 },
	{ name = "combat", interval = 2500, chance = 27, type = COMBAT_ICEDAMAGE, minDamage = -600, maxDamage = -1200, range = 7, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 1500, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -600, maxDamage = -900, range = 3, radius = 1, effect = CONST_ME_ICEATTACK, target = true },
	{ name = "combat", interval = 2500, chance = 20, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -300, range = 7, radius = 4, effect = CONST_ME_BUBBLES, target = false },
	{ name = "combat", interval = 1800, chance = 20, type = COMBAT_DROWNDAMAGE, minDamage = -500, maxDamage = -950, range = 7, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_WATERSPLASH, target = true },
}

monster.defenses = {
	defense = 40,
	armor = 40,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1100, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
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
