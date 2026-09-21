local mType = Game.createMonsterType("The Abomination of Hearts")
local monster = {}

monster.description = "The Abomination of Hearts"
monster.experience = 20000000
monster.outfit = {
	lookType = 365,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 250000
monster.maxHealth = 1000000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 200
monster.manaCost = 0

monster.events = {
	"QueenOfHeartsTransform",
}

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
	rewardBoss = true,
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
	maxSummons = 4,
	summons = {
		{ name = "Chaos Demon", chance = 25, interval = 4000, count = 1 },
		{ name = "Voidborn", chance = 25, interval = 4000, count = 1 },
		{ name = "Doom Seeker", chance = 25, interval = 4000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 5,
	{ text = "GRRRRRRRAAAAH", yell = true },
	{ text = "MORR IORRRRR MAAAAH!", yell = true },
	{ text = "IHH AAAAAARRRRRGH", yell = false },
}

monster.loot = {
	{ id = 33892, chance = 250, maxCount = 1},
	{ id = 3043, chance = 1000000, maxCount = 12},
	{ id = 3035, chance = 100000, maxCount = 92},
	{ id = 3393, chance = 10, maxCount = 1 },
	{ id = 3251, chance = 100000, maxCount = 1 },
	{id = 22721, chance = 100000, minCount = 1, maxCount = 4},
	{ name = "ultimate mana potion", chance = 100000, maxCount = 26 },
	{ name = "ultimate health potion", chance = 100000, maxCount = 38},
	{ name = "ultimate spirit potion", chance = 100000, maxCount = 32},
	{ id = 12811, chance = 100, maxCount = 1},
	{id = 12669, chance = 150 },
	{id = 39707, chance = 250, unique = true },
--	{ id = 43733, chance = 20000 }, -- rabbit token
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -3000 },
	{ name = "combat", interval = 1500, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -1900, maxDamage = -5080, range = 1, effect = CONST_ME_BIG_SCRATCH, target = true },
	{ name = "combat", interval = 5000, chance = 100, type = COMBAT_AGONYDAMAGE, minDamage = -3500, maxDamage = -6000, range = 7, radius = 7, effect = CONST_ME_BLACK_BLOOD, target = false },
	{name ="anomaly break", interval = 3000, chance = 40, target = false},
	{name ="boss break", interval = 3000, chance = 40, target = false},
	{ name = "combat", interval = 2200, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -3600, maxDamage = -6050, radius = 10, effect = CONST_ME_GHOSTLY_SCRATCH, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -750, range = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 20000 },

}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 4500, chance = 25, type = COMBAT_HEALING, minDamage = 5000, maxDamage = 8000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 670, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
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
