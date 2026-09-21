local mType = Game.createMonsterType("Doom Seeker")
local monster = {}

monster.description = "a doom seeker"
monster.experience = 58200
monster.outfit = {
	lookType = 1276,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 42000
monster.maxHealth = 42000
monster.race = "undead"
monster.corpse = 32737
monster.speed = 145
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 60000,
	chance = 0,
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
	staticAttackChance = 95,
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
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3251, chance = 500, maxCount = 1 },	
	{ id = 3035, chance = 45000, maxCount = 48 },
	{ id = 3043, chance = 4500, maxCount = 1 },
		{ id = 39136, chance = 135, maxCount = 1 },
	{ name = "platinum coin", chance = 76234, maxCount = 39},
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 10000, maxCount = 2 },
	{ name = "ultimate health potion", chance = 10000, maxCount = 2 },
	{ name = "ultimate spirit potion", chance = 10000, maxCount = 2 },
	{ name = "small diamond", chance = 3000, maxCount = 8 },
	{ name = "small emerald", chance = 3000, maxCount = 12 },
	{ name = "small enchanted amethyst", chance = 2000, maxCount = 6 },
	{ name = "knight armor", chance = 12000 },
	{ name = "dragon scale mail", chance = 8500},
	-- { id = 35909, chance = 150},
	{ id = 8099, chance = 100},
	-- { id = 44179, chance = 100},
--	{ id = 43733, chance = 20 }, -- rabbit token
}


monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -600, maxDamage = -1650, condition = { type = CONDITION_POISON, totalDamage = 4000, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -800, maxDamage = -1400, radius = 4, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "drunk", interval = 2000, chance = 20, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, range = 6, minDamage = -500, maxDamage = -1600, effect = CONST_ME_MORTAREA, target = false },
}

monster.defenses = {
	defense = 170,
	armor = 160,
	--	mitigation = ???,
	{ name = "speed", interval = 10000, chance = 40, speedChange = 210, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 20000 },
	{ name = "combat", interval = 4000, chance = 20, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
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
