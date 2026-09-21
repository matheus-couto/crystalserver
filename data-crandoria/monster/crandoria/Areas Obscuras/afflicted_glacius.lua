local mType = Game.createMonsterType("Afflicted Glacius")
local monster = {}

monster.description = "an afflicted glacius"
monster.experience = 26200
monster.outfit = {
	lookType = 565,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 34400
monster.maxHealth = 34400
monster.race = "venom"
monster.corpse = 18982
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 15
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
	{text = "Tchhh!", yell = false},
	{text = "Slurp!", yell = false}
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{id = 3035, chance = 100000, maxCount = 15}, -- platinum coin
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{id = 19371, chance = 3000}, -- glass of goo
	{id = 19372, chance = 3000}, -- goo shell
	{id = 3037, chance = 10000}, -- yellow gem
	{id = 3038, chance = 10000}, -- green gem
	{id = 7643, chance = 10000, maxCount = 3}, -- ultimate health potion
	{id = 7642, chance = 10000, maxCount = 3}, -- great spirit potion
	{id = 238, chance = 10000, maxCount = 3}, -- great mana potion
	{id = 3032, chance = 10000, maxCount = 5}, -- small emerald
	{id = 9057, chance = 10000, maxCount = 5}, -- small topaz
	{id = 5910, chance = 1000}, -- green piece of cloth
	{id = 5911, chance = 1000}, -- red piece of cloth
	{id = 5914, chance = 1000}, -- yellow piece of cloth
	{id = 8084, chance = 800}, -- springsprout rod
	{id = 8063, chance = 1000}, -- paladin armor
	{id = 9667, chance = 100000}, -- boggy dreads
	{id = 21194, chance = 10000} -- slime heart
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -580},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -900, length = 6, spread = 3, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -290, maxDamage = -780, length = 4, spread = 3, effect = CONST_ME_MAGIC_GREEN, target = false},
	{name ="combat", interval = 2000, chance = 24, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -550, radius = 5, effect = CONST_ME_GREEN_RINGS, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 13, minDamage = -360, maxDamage = -540, radius = 5, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="shlorg paralyze", interval = 2000, chance = 11, target = false}
}

monster.defenses = {
	defense = 15,
	armor = 10,
	{name ="combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 95, maxDamage = 150, effect = CONST_ME_MAGIC_RED, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_FIREDAMAGE, percent = 80},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
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
