local mType = Game.createMonsterType("Goshnar's Megalomania 3")
local monster = {}

monster.name = "Goshnar's Megalomania"
monster.description = "Goshnar's Megalomania"
monster.experience = 200000
monster.outfit = {
	lookType = 1337,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "undead"
monster.corpse = 33889
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 10,
}

monster.events = {
	"megalomaniaDeath",
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "crystal coin", chance = 55000, minCount = 70, maxCount = 75 },
	{ id = 281, chance = 1150 }, -- giant shimmering pearl (green)
	{ name = "giant sapphire", chance = 10000, maxCount = 1 },
	{ name = "giant topaz", chance = 10000, maxCount = 1 },
	{ name = "violet gem", chance = 6000, maxCount = 1 },
	{ name = "blue gem", chance = 10000, maxCount = 3 },
	{ id = 3039, chance = 10000, maxCount = 3 }, -- red gem
	{ name = "green gem", chance = 10000, maxCount = 3 },
	{ name = "yellow gem", chance = 10000, maxCount = 3 },
	{ name = "white gem", chance = 6000, maxCount = 3 },
	{ name = "dragon figurine", chance = 10000, maxCount = 1 },
	{ name = "bullseye potion", chance = 15000, minCount = 10, maxCount = 25 },
	{ name = "mastermind potion", chance = 15000, minCount = 10, maxCount = 25 },
	{ name = "berserk potion", chance = 15000, minCount = 10, maxCount = 25 },
	{ name = "ultimate mana potion", chance = 18000, minCount = 50, maxCount = 100 },
	{ name = "supreme health potion", chance = 18000, minCount = 50, maxCount = 100 },
	{ name = "ultimate spirit potion", chance = 18000, minCount = 50, maxCount = 100 },
	{ name = "figurine of malice", chance = 400 },
	{ name = "figurine of cruelty", chance = 400 },
	{ name = "figurine of hatred", chance = 400 },
	{ name = "figurine of greed", chance = 400 },
	{ name = "figurine of spite", chance = 400 },
	{ name = "figurine of megalomania", chance = 400 },
	{ name = "megalomania's skull", chance = 400 },
	{ name = "megalomania's essence", chance = 400 },
	{ name = "bag you desire", chance = 200 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, minDamage = 0, maxDamage = -3000 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -4000, range = 12, length = 7, spread = 5, effect = CONST_ME_MORTAREA, target = false},
	{ name = "megalomania changeback", interval = 7000, chance = 1000, range = 15, target = false},
	{ name = "fear", interval = 2000, chance = 25, target = true },
	{ name = "megalomania ghost wave", interval = 1500, chance = 100, range = 15, target = false },
	{ name = "megalomania mark", interval = 20000, chance = 100, target = false },
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
