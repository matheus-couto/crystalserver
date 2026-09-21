local mType = Game.createMonsterType("Orshabaal")
local monster = {}

monster.description = "Orshabaal"
monster.experience = 30000000
monster.outfit = {
	lookType = 201,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 201,
	bossRace = RARITY_NEMESIS,
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "fire"
monster.corpse = 5995
monster.speed = 270
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 2000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 20,
	health = 10,
	random = 60,
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
	runHealth = 2500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "demon", chance = 20, interval = 1000, count = 4 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "VOCE ESTA CONDENADO!", yell = true },
	{ text = "ORSHABAAL ESTA DE VOLTA! HA HA HA!", yell = true },
	{ text = "PREPARE-SE PARA O DIA QUE MEUS MESTRES VIRAO ATE VOCE!", yell = false },
	{ text = "ALMAS PARA ORSHABAAL!", yell = true },
}

monster.loot = {
	-- { id = 3250, chance = 450, maxCount = 1 },
	{ name = "purple tome", chance = 20000 },
	{ name = "golden mug", chance = 12500 },
	{ name = "crystal necklace", chance = 20000 },
	{ name = "white pearl", chance = 33333, maxCount = 15 },
	{ name = "black pearl", chance = 25000, maxCount = 8 },
	{ name = "small diamond", chance = 20000, maxCount = 5 },
	{ name = "small sapphire", chance = 33333, maxCount = 8 },
	{ name = "small emerald", chance = 25000, maxCount = 7 },
	{ name = "small amethyst", chance = 20000, maxCount = 17 },
	{ name = "talon", chance = 20000, maxCount = 3 },
	{ name = "platinum coin", chance = 100000, maxCount = 69 },
	{ name = "green gem", chance = 6666 },
	{ name = "blue gem", chance = 20000 },
	{ id = 3046, chance = 6666 }, -- magic light wand
	{ name = "might ring", chance = 6666 },
	{ name = "silver amulet", chance = 20000 },
	{ name = "platinum amulet", chance = 12500 },
	{ name = "strange symbol", chance = 20000 },
	{ name = "orb", chance = 6666 },
	{ name = "life crystal", chance = 12500 },
	{ name = "mind stone", chance = 20000 },
	{ name = "boots of haste", chance = 12500 },
	{ name = "protection amulet", chance = 20000 },
	{ id = 3098, chance = 33333 }, -- ring of healing
	{ id = 26186, chance = 33333, maxCount = 2 }, -- exercise stash
	{ name = "two handed sword", chance = 12500 },
	{ name = "giant sword", chance = 25000 },
	{ name = "silver dagger", chance = 6666 },
	{ name = "golden sickle", chance = 6666 },
	{ name = "fire axe", chance = 12500 },
	{ name = "dragon hammer", chance = 6666 },
	{ name = "devil helmet", chance = 33333 },
	{ name = "golden legs", chance = 12500 },
	{ name = "magic plate armor", chance = 6666 },
	{ name = "mastermind shield", chance = 6666 },
	{ name = "demon shield", chance = 25000 },
	{ name = "Orshabaal's brain", chance = 6666 },
	{ name = "thunder hammer", chance = 500 },
	{ name = "demon horn", chance = 50000 },
	{ id = 6299, chance = 50000 }, -- death ring
	{ name = "demonic essence", chance = 100000 },
	{ name = "assassin star", chance = 12500, maxCount = 42 },
	{ id = 238, chance = 33333 },
	{ name = "great health potion", chance = 20000 },
	{ name = "great spirit potion", chance = 12500 },
	{ name = "ultimate health potion", chance = 33333 },
	{ name = "gold ingot", chance = 6666 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2490 },
	{ name = "combat", interval = 1000, chance = 16, type = COMBAT_MANADRAIN, minDamage = -800, maxDamage = -950, range = 7, target = false },
	{ name = "combat", interval = 1000, chance = 22, type = COMBAT_MANADRAIN, minDamage = -450, maxDamage = -950, radius = 5, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -810, maxDamage = -1400, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 1000, chance = 24, type = COMBAT_FIREDAMAGE, minDamage = -1610, maxDamage = -2600, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "firefield", interval = 1000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -900, maxDamage = -1350, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
}

monster.defenses = {
	defense = 111,
	armor = 90,
	--	mitigation = ???,
	{ name = "combat", interval = 1000, chance = 9, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 1000, chance = 17, type = COMBAT_HEALING, minDamage = 600, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 5, speedChange = 1901, effect = CONST_ME_MAGIC_RED, target = false, duration = 7000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -1 },
	{ type = COMBAT_HOLYDAMAGE, percent = -1 },
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
