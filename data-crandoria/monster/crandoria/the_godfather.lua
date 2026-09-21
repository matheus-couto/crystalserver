local mType = Game.createMonsterType("The Godfather")
local monster = {}

monster.description = "the godfather"
monster.experience = 3000000
monster.outfit = {
	lookType = 1079,
	lookHead = 95,
	lookBody = 3,
	lookLegs = 3,
	lookFeet = 125,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 800000
monster.maxHealth = 800000
monster.race = "blood"
monster.corpse = 6305
monster.speed = 155
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
	nearest = 50,
	health = 10,
	random = 30,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 80,
	health = 10,
	random = 10,
	damage = 10,
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
	staticAttackChance = 70,
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

monster.summon = {
	maxSummons = 5,
	summons = {
		{name = "Black Dragon", chance = 10, interval = 2000, count = 2},
	}
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "crystal coin", chance = 52234, maxCount = 4},
	{ name = "platinum coin", chance = 76234, maxCount = 29},
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 30000, maxCount = 8 },
	{ name = "ultimate health potion", chance = 30000, maxCount = 11 },
	{ name = "ultimate spirit potion", chance = 30000, maxCount = 9 },
	{ name = "small diamond", chance = 30000, maxCount = 8 },
	{ name = "small emerald", chance = 30000, maxCount = 12 },
	{ name = "small enchanted amethyst", chance = 20000, maxCount = 6 },
	-- { id = 3251, chance = 500, maxCount = 1 },
	{ name = "damaged armor plates", chance = 5350, maxCount = 3 },
	{ name = "knight armor", chance = 12000 },
	{ name = "spiked squelcher", chance = 18200 },
	{ name = "dragon shield", chance = 18500},
	{ name = "dragon lance", chance = 19520},
	{ name = "dragon scale mail", chance = 18500},
	-- { id = 35909, chance = 150},
	-- { id = 8099, chance = 100},
	-- { id = 44179, chance = 100},
	{ id = 12811, chance = 50, unique = true },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -3350 },
	{ name = "extended energy chain", interval = 2000, chance = 25, minDamage = -2300, maxDamage = -4000, target = true, range = 6},
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_ENERGYDAMAGE, minDamage = -2350, maxDamage = -6150, range = 6, length = 7, effect = CONST_ME_ENERGYAREA, target = false},
	{ name = "combat", interval = 1500, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -2460, maxDamage = -4080, range = 5, radius = 6, effect = CONST_ME_REDSMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -2450, maxDamage = -6400, target = true, radius = 1, effect = CONST_ME_BIG_SCRATCH},
	{ name = "death ring", interval = 3000, chance = 10, minDamage = -3500, maxDamage = -6500, targe = false, range = 8},
	{ name = "godfather explosion", interval = 2000, chance = 20, minDamage = -2500, maxDamage = -4500, targe = false, range = 8}

}

monster.defenses = {
	defense = 72,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 6000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 20, speedChange = 220, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
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
