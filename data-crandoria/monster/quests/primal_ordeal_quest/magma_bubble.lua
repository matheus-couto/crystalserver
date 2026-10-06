local mType = Game.createMonsterType("Magma Bubble")
local monster = {}

monster.description = "magma bubble"
monster.experience = 2500000
monster.outfit = {
	lookType = 1413,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 650000
monster.maxHealth = 650000
monster.race = "undead"
monster.corpse = 36847
monster.speed = 200
monster.manaCost = 0

monster.events = {
	"magmabubbleDeath",
}


monster.changeTarget = {
	interval = 3000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 20
}

monster.bosstiary = {
	bossRaceId = 2242,
	bossRace = RARITY_ARCHFOE,
	-- storageCooldown = Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleTimer,
	storageCooldown = 14300,
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
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ id = 3043, chance = 10000 },
	{ name = "crystal coin",chance = 1000000, maxCount = 25},
	{ name = "ultimate mana potion", chance = 75000, maxCount = 24},
	{ name = "ultimate health potion",chance = 75000, maxCount = 24},
	{ name = "bullseye potion",chance = 35000, maxCount = 5},
	{ name = "berserk potion",chance = 35000, maxCount = 5},
	{ name = "mastermind potion",chance = 35000, maxCount = 5},
	{ name = "giant amethyst", chance = 26122},
	{ name = "giant ruby", chance = 24082, minCount = 1, maxCount = 2},
	{ name = "giant emerald", chance = 24082, minCount = 1, maxCount = 2},
	{ name = "giant sapphire", chance = 12041, minCount = 1, maxCount = 2},
	{ name = "giant topaz", chance = 12041, minCount = 1, maxCount = 2},
	{ name = "arboreal tome", chance = 80},
	{ name = "arboreal crown", chance = 80},
	{ name = "firefighting axe", chance = 1000},
	-- { name = "portable flame", chance = 1000},
	-- { name = "spiritthorn armor", id = 39147, chance = 200 },
	-- { name = "spiritthorn helmet", id = 39148, chance = 200 },
	-- { name = "alicorn headguard", chance = 200 },
	-- { name = "alicorn quiver", chance = 200 },
	-- { name = "arcanomancer regalia", chance = 200 },
	-- { name = "arcanomancer folio", chance = 200 },
	-- { id = 39183, chance = 200 }, -- name = "charged arcanomancer sigil"
	-- { id = 39186, chance = 200 }, -- name = "charged arboreal ring"
	-- { id = 39180, chance = 200 }, -- name = "charged alicorn ring"
	-- { id = 39177, chance = 200 }, -- name = "charged spiritthorn ring"
	{ id = 39546, chance = 500, unique = true },
	{ id = 39136, chance = 3000 }, -- perdao real
}

monster.attacks = {
	{name ="melee", interval = 200, chance = 20, minDamage = -600, maxDamage = -1650},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1600, maxDamage = -3500, target = false},
	{name ="combat", interval = 1000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -1200, maxDamage = -2500, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2500, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -2200, maxDamage = -4100, radius = 6, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 1500, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -3250, maxDamage = -5600, radius = 6, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -1500, maxDamage = -2500, length = 8, spread = 0, effect = CONST_ME_FIREAREA, target = false}
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{name ="combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 800, maxDamage = 4000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent =  0},
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
