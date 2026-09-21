local mType = Game.createMonsterType("Chaos Demon")
local monster = {}

monster.description = "a chaos demon"
monster.experience = 57000
monster.outfit = {
	lookType = 12,
	lookHead = 2,
	lookBody = 57,
	lookLegs = 84,
	lookFeet = 84,
	lookAddons = 1,
	lookMount = 0,
}


monster.health = 42150
monster.maxHealth = 42150
monster.race = "fire"
monster.corpse = 6068
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 10000,
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
	canPushCreatures = true,
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 100,
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

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "Demon", chance = 33, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3251, chance = 500, maxCount = 1 },
	{ id = 3035, chance = 45000, maxCount = 48 },
	{ id = 3043, chance = 4500, maxCount = 1 },
	{ name = "platinum coin", chance = 76234, maxCount = 29},
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 30000, maxCount = 8 },
	{ name = "ultimate health potion", chance = 30000, maxCount = 11 },
	{ name = "ultimate spirit potion", chance = 30000, maxCount = 9 },
	{ name = "small diamond", chance = 30000, maxCount = 8 },
	{ name = "small emerald", chance = 30000, maxCount = 12 },
	{ name = "small enchanted amethyst", chance = 20000, maxCount = 6 },
	{ id = 3251, chance = 500, maxCount = 1 },
--	{ id = 43733, chance = 20 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -600, maxDamage = -1450 },
	{ name = "big energy ring", interval = 1800, chance = 20, minDamage = -700, maxDamage = -1580, range = 7, target = false },
	{ name = "combat", interval = 3000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -680, maxDamage = -1450, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -500, range = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -350, maxDamage = -620, radius = 3, effect = CONST_ME_ENERGYAREA, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1100, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 470, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -5 },
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
