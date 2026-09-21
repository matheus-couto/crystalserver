local mType = Game.createMonsterType("Eradicator")
local monster = {}

monster.description = "Eradicator"
monster.experience = 5000000
monster.outfit = {
	lookType = 875,
	lookHead = 79,
	lookBody = 3,
	lookLegs = 114,
	lookFeet = 79,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 590000
monster.maxHealth = 590000
monster.race = "venom"
monster.corpse = 23564
monster.speed = 225
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 25
}

monster.bosstiary = {
	bossRaceId = 1225,
	bossRace = RARITY_ARCHFOE,
	storageCooldown = 14329
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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.events = {
	"HeartBossDeath",
	"EradicatorTransform"
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
	{id = 3031, chance = 100000, maxCount = 200}, -- gold coin
	{id = 3035, chance = 100000, maxCount = 25}, -- platinum coin
	{id = 16121, chance = 8000, maxCount = 3}, -- green crystal shard
	{id = 238, chance = 8000, maxCount = 5}, -- great mana potion
	{id = 7642, chance = 8000, maxCount = 5}, -- great spirit potion
	{id = 3033, chance = 8000, maxCount = 5}, -- small amethyst
	{id = 3030, chance = 8000, maxCount = 5}, -- small ruby
	{id = 9057, chance = 8000, maxCount = 5}, -- small topaz
	{id = 7643, chance = 8000, maxCount = 10}, -- ultimate health potion
	{id = 16120, chance = 8000, maxCount = 3}, -- violet crystal shard
	{id = 23535, chance = 8000}, -- energy bar
	{id = 23520, chance = 8000}, -- plasmatic lightning
	{id = 23518, chance = 8000}, -- spark sphere
	{id = 22721, chance = 100000, minCount = 1, maxCount = 4}, -- gold token
	{id = 23509, chance = 100000}, -- mysterious remains
	{id = 23510, chance = 100000}, -- odd organ
	{id = 3041, chance = 6000}, -- blue gem
	{id = 3038, chance = 6000}, -- green gem
	{id = 8073, chance = 6000}, -- spellbook of warding
	{id = 3333, chance = 4000}, -- crystal mace
	{id = 23529, chance = 3500}, -- ring of blue plasma
	{id = 23531, chance = 3500}, -- ring of green plasma
	{id = 23533, chance = 3500}, -- ring of red plasma
	{id = 3554, chance = 5000, unique = true}, -- steel boots
	{id = 8075, chance = 3000, unique = true} -- spellbook of lost souls
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -2200},
	{ name = "boss break", interval = 2000, chance = 100, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_BLOCKHIT, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -450, maxDamage = -900, radius = 8, effect = CONST_ME_BLOCKHIT, target = false},
	{name ="big energy wave", interval = 2000, chance = 20, minDamage = -700, maxDamage = -1000, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -800, radius = 4, effect = CONST_ME_ENERGYHIT, target = true},
	{name ="anomaly break", interval = 2000, chance = 40, target = false}
}

monster.defenses = {
	defense = 100,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 70},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 30},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 30},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
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
