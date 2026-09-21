local mType = Game.createMonsterType("Monster Izildor")
local monster = {}

monster.description = "Monster Izildor"
monster.experience = 25000000
monster.outfit = {
	lookType = 881,
	lookHead = 57,
	lookBody = 96,
	lookLegs = 23,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 800000
monster.maxHealth = 800000
monster.race = "blood"
monster.corpse = 111
monster.speed = 105
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
	nearest = 10,
	health = 10,
	random = 70,
	damage = 10,
}

monster.strategiesTarget2 = {
	nearest = 100,
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
	{ name = "flask of demonic blood", chance = 50000, maxCount = 2 },
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "onyx arrow", chance = 35000, maxCount = 3 },
	{ name = "small diamond", chance = 30000, maxCount = 3 },
	{ name = "small emerald", chance = 30000, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 20000, maxCount = 3 },
	{ name = "damaged armor plates", chance = 2350, maxCount = 3 },
	{ id = 281, chance = 12000, maxCount = 1 }, -- giant shimmering pearl (green)
	{ name = "knight armor", chance = 7000 },
	{ name = "patch of fine cloth", chance = 1800 },
	{ name = "spiked squelcher", chance = 3200 },
	{ name = "titan axe", chance = 2400 },
	{ name = "falcon battleaxe", chance = 200 },
	{ name = "falcon longsword", chance = 200 },
	{ name = "falcon mace", chance = 210 },
	{ name = "falcon plate", chance = 100 },
	{ name = "falcon shield", chance = 100 },
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = -150, maxDamage = -1500 },
	{ name = "combat", interval = 1400, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -1200, range = 5, radius = 3, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name = "combat", interval = 1800, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -1200, range = 5, radius = 3, effect = CONST_ME_HITBYFIRE, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 82,
	--	mitigation = ???,
	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_HEALING, minDamage = 100, maxDamage = 750, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 30, speedChange = 220, effect = CONST_ME_POFF, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 100 },
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
