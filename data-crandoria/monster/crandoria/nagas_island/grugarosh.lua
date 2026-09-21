local mType = Game.createMonsterType("Grugarosh")
local monster = {}

monster.description = "Grugarosh"
monster.experience = 1000000
monster.outfit = {
	lookType = 12,
	lookHead = 0,
	lookBody = 84,
	lookLegs = 113,
	lookFeet = 113,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 750000
monster.maxHealth = 750000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 305
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
	maxSummons = 6,
	summons = {
		{ name = "Demon", chance = 33, interval = 4000, count = 6 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "ACHAM QUE PODEM ME APRISIONAR PARA SEMPRE?", yell = true },
	{ text = "SE VOCE ME DERROTAR, EU RETORNAREI!", yell = true },
	{ text = "MORGAROTH, ESPERE POR MIM!!!", yell = true },
	{ text = "NAO TENHO PENA DE MEROS HUMANOS...", yell = true },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "platinum coin", chance = 95000, maxCount = 74 },
	{ name = "demonic essence", chance = 95000, maxCount = 5 },
	{ name = "green gem", chance = 50000 },
	{ id = 238, chance = 45000 },
	{ name = "small emerald", chance = 27000, maxCount = 7 },
	{ name = "ultimate health potion", chance = 27000 },
	{ name = "demon horn", chance = 22000, maxCount = 2 },
	{ id = 3098, chance = 22000 }, -- ring of healing
	{ name = "double axe", chance = 18000 },
	{ name = "great spirit potion", chance = 18000 },
	{ name = "magic plate armor", chance = 8000 },
	{ name = "might ring", chance = 18000 },
	{ id = 3049, chance = 18000 }, -- stealth ring
	{ name = "white pearl", chance = 13000, maxCount = 11 },
	{ name = "black pearl", chance = 13000, maxCount = 13 },
	{ name = "assassin star", chance = 13000, maxCount = 35 },
	{ name = "blue gem", chance = 9000 },
	{ name = "gold ring", chance = 9000 },
	{ name = "demon shield", chance = 9000 },
	{ id = 3051, chance = 9000 }, -- energy ring
	{ name = "giant sword", chance = 9000 },
	{ name = "golden legs", chance = 9000 },
	{ name = "life crystal", chance = 9000 },
	{ id = 3046, chance = 9000 }, -- magic light wand
	{ name = "steel boots", chance = 9000 },
	{ name = "small diamond", chance = 4500, maxCount = 5 },
	{ id = 3007, chance = 4500 }, -- crystal ring
	{ name = "fire axe", chance = 4500 },
	{ name = "great health potion", chance = 4500 },
	{ name = "mastermind shield", chance = 4500 },
	{ id = 33309, chance = 10000 },
	{ id = 33306, chance = 250 },
	{ id = 17514, chance = 200, unique = true }, -- kit encant
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2050 },
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1810, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 3000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -1200, maxDamage = -1850, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2500, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1400, maxDamage = -2480, range = 7, radius = 5, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -1350, maxDamage = -2500, range = 7, radius = 13, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -1950, radius = 14, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -400, range = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -1120, radius = 3, effect = CONST_ME_HITAREA, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 9000, chance = 15, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 470, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 10 },
	{ type = COMBAT_FIREDAMAGE, percent = 50 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 40 },
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
