local mType = Game.createMonsterType("Goshnars Megalomania Ritual")
local monster = {}

monster.name = "Goshnar's Megalomania"

monster.description = "Goshnar's Megalomania"
monster.experience = 2000000
monster.outfit = {
	lookType = 1308,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
    "ritualSoulDeath"
}

monster.health = 800000
monster.maxHealth = 800000
monster.race = "undead"
monster.corpse = 33889
monster.speed = 165
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "dreadful harvester", chance = 20, interval = 5000, count = 2 },
		{ name = "aspect of power", chance = 10, interval = 5000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- { id = 30003, chance = 25000, maxCount = 1 },
	{ name = "crystal coin", chance = 55000, minCount = 70, maxCount = 75, unique = true },
	{ id = 3035, chance = 95000, minCount = 75, maxCount = 100 },
	{ id = 281, chance = 1150 }, -- giant shimmering pearl (green)
	{ name = "giant sapphire", chance = 10000, maxCount = 1, unique = true },
	{ name = "giant topaz", chance = 10000, maxCount = 1, unique = true },
	{ name = "violet gem", chance = 6000, maxCount = 1, unique = true },
	{ name = "blue gem", chance = 10000, maxCount = 3 },
	{ id = 3039, chance = 10000, maxCount = 3 }, -- red gem
	{ name = "green gem", chance = 10000, maxCount = 3, unique = true },
	{ name = "yellow gem", chance = 10000, maxCount = 3, unique = true },
	{ name = "white gem", chance = 6000, maxCount = 3 },
	{ name = "dragon figurine", chance = 10000, maxCount = 1, unique = true },
	{ name = "bullseye potion", chance = 15000, minCount = 2, maxCount = 5 },
	{ name = "mastermind potion", chance = 15000, minCount = 2, maxCount = 5 },
	{ name = "berserk potion", chance = 15000, minCount = 2, maxCount = 5 },
	{ name = "ultimate mana potion", chance = 18000, minCount = 25, maxCount = 55 },
	{ name = "supreme health potion", chance = 18000, minCount = 25, maxCount = 55 },
	{ name = "ultimate spirit potion", chance = 18000, minCount = 25, maxCount = 55 },
	{ name = "figurine of malice", chance = 400, unique = true },
	{ name = "figurine of cruelty", chance = 400, unique = true },
	{ name = "figurine of hatred", chance = 400, unique = true },
	{ name = "figurine of greed", chance = 400, unique = true },
	{ name = "figurine of spite", chance = 400, unique = true },
	{ name = "figurine of megalomania", chance = 400, unique = true },
	{ name = "megalomania's skull", chance = 400, unique = true },
	{ name = "megalomania's essence", chance = 400, unique = true },
	{ name = "bag you desire", chance = 5000, unique = true },
	{ id = 39136, chance = 10000, unique = true }, -- perdao real
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -8000 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -2950, maxDamage = -4400, range = 7, radius = 3, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -3000, maxDamage = -5500, length = 8, spread = 3, effect = CONST_ME_INSECTS, target = false },
	{ name = "singlecloudchain", interval = 6000, chance = 40, minDamage = -3300, maxDamage = -5500, range = 6, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -3300, maxDamage = -5200, length = 10, spread = 0, effect = CONST_ME_BLUE_GHOST, target = false },
	{ name = "boss break", interval = 2000, chance = 100, target = false},
}

monster.defenses = {
	defense = 160,
	armor = 160,
	mitigation = 8.40,
	{ name = "speed", interval = 1000, chance = 20, speedChange = 500, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 2250, maxDamage = 4250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
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
