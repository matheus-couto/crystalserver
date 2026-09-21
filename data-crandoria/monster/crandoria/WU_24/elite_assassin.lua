local mType = Game.createMonsterType("Elite Assassin")
local monster = {}

monster.description = "an elite assassin"
monster.experience = 8750
monster.outfit = {
	lookType = 134,
	lookHead = 95,
	lookBody = 95,
	lookLegs = 95,
	lookFeet = 113,
	lookAddons = 1,
	lookMount = 0,
}


monster.health = 9800
monster.maxHealth = 9800
monster.race = "blood"
monster.corpse = 18153
monster.speed = 185
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 5,
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
	{ name = "platinum coin", chance = 32450, maxCount = 11 },
	{ id = 3043, chance = 500 },
	{ id = 3043, chance = 500 },
	{ name = "combat knife", chance = 4000 },
	{ name = "viper star", chance = 4200, maxCount = 7 },
	{ name = "small diamond", chance = 2200, maxCount = 3 },
	{ name = "small ruby", chance = 1850, maxCount = 4 },
	{ name = "small emerald", chance = 1480, maxCount = 5},
	{ id = 30031, chance = 900, maxCount = 1 },
	{ name = "golden armor", chance = 1200, maxCount = 1 },
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -500 },
	{ name = "combat", interval = 2100, type = COMBAT_PHYSICALDAMAGE, chance = 20, minDamage = 0, maxDamage = -550, shotEffect = CONST_ANI_REDSTAR, target = false },
	{ name = "zulazza the corruptor paralyze", interval = 2500, chance = 5, minDamage = -390, maxDamage = -580 },
}

monster.defenses = {
	defense = 30,
	armor = 55,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
