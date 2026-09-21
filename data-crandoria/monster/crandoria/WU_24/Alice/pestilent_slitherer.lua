local mType = Game.createMonsterType("Pestilent Slitherer")
local monster = {}

monster.description = "a pestilent slitherer"
monster.experience = 37250
monster.outfit = {
	lookType = 1275,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 29800
monster.maxHealth = 29800
monster.race = "undead"
monster.corpse = 32702
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 10,
	targetDistance = 1,
	runHealth = 1,
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
		{ id = 39136, chance = 135, maxCount = 1 },
		{ id = 3035, chance = 45000, maxCount = 36 },
		{ id = 3043, chance = 2000, maxCount = 1 },
		{ id = 3251, chance = 500, maxCount = 1 },
		{ id = 238, chance = 25000, maxCount = 2},
		{ id = 239, chance = 25000, maxCount = 3},
		{ id = 7643, chance = 15000, maxCount = 1},
		{ id = 23373, chance = 15000, maxCount = 1},
		{ id = 23374, chance = 15000, maxCount = 2},
		{ id = 7642, chance = 25000, maxCount = 2},
		{ id = 3037, chance = 2600, maxCount = 1},
		{ id = 21164, chance = 6000, maxCount = 1},
	--	{ id = 43733, chance = 10 }, -- rabbit token
	}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1300 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -650, maxDamage = -1400, range = 7, radius = 5, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_POISONAREA, target = true },
	{ name = "poison chain", interval = 2000, chance = 20, minDamage = -550, maxDamage = -1100, range = 5, target = true},
}

monster.defenses = {
	defense = 50,
	armor = 65,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 50 },
	{ type = COMBAT_FIREDAMAGE, percent = -15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
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
