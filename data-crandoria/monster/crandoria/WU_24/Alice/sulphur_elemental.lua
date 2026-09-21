local mType = Game.createMonsterType("Sulphur Elemental")
local monster = {}

monster.description = "a sulphur elemental"
monster.experience = 39420
monster.outfit = {
	lookType = 1119,
	lookHead = 97,
	lookBody = 3,
	lookLegs = 97,
	lookFeet = 97,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 34100
monster.maxHealth = 34100
monster.race = "blood"
monster.corpse = 32125
monster.speed = 195
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
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
	rewardBoss = false,
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
	{ id = 3364, chance = 800, maxCount = 1},
	{ id = 8063, chance = 1000, maxCount = 1},
--	{ id = 43733, chance = 10 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", type = COMBAT_PHYSICALDAMAGE, interval = 2000, minDamage = 0, maxDamage = -1257 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -650, maxDamage = -1200, radius = 3, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1500, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -535, maxDamage = -1250, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "werecrocodile fire ring", interval = 1800, chance = 20, minDamage = -500, maxDamage = -1180, target = false },
}

monster.defenses = {
	defense = 5,
	armor = 10,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 35 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 45 },
}

-- monster.heals = {
-- 	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
-- }

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
