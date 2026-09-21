local mType = Game.createMonsterType("Dragon Mother")
local monster = {}

monster.description = "Dragon Mother"
monster.experience = 50000000
monster.outfit = {
	lookType = 1466,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 2000000
monster.maxHealth = 2000000
monster.race = "fire"
monster.corpse = 37598
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

-- monster.summon = {
-- 	maxSummons = 6,
-- 	summons = {
-- 		{ name = "Dragon Lord Hatchling", chance = 33, interval = 4000, count = 2 },
-- 	},
-- }

monster.voices = {
	interval = 5000,
	chance = 10,
	-- { text = "NEM TODOS OS CALDOS DE FEIJAO DO MUNDO VAO SACIAR A MINHA FOME! HAHAHAHA", yell = true },
	-- { text = "SAIAM DA FRENTE, MORTAIS. PRECISO DE UM QUENTAO!", yell = true },
	-- { text = "ONDE ESTA A CANJICA? E O BOLO DE FUBA? AAAAHHHHHHH!", yell = true },
	-- { text = "TRAGA TODAS AS IGUARIAS DE SAO JOAO PARA MIM. EU ORDENO!!!", yell = true },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ name = "platinum coin", chance = 95000, maxCount = 74 },
	{ id = 3043, chance = 100000, maxCount = 15 },
	{ id = 3043, chance = 40000, maxCount = 22 },
	-- { id = 14112, chance = 20000, maxCount = 2},
	-- { id = 23683, chance = 100000, unique = true },
	{ id = 35909, chance = 60000 },
	{ id = 20138, chance = 40000, maxCount = 2 },
	{ id = 20139, chance = 10000, maxCount = 2 },
	{ id = 9099, chance = 70000 },
	{ id = 3024, chance = 15000 },
	{ id = 10290, chance = 5000, unique = true },
	{ id = 3309, chance = 20000, unique = true },
	{ id = 3422, chance = 20000, unique = true },
	{ id = 827, chance = 30000 },
	{ id = 818, chance = 30000 },
	{ id = 826, chance = 30000 },
	{ id = 821, chance = 30000 },
	{ id = 827, chance = 30000 },
	{ id = 3416, chance = 30000 },
	{ id = 3302, chance = 30000 },
	{ id = 3386, chance = 50000 },
	{ id = 22724, chance = 50000, maxCount = 22 },
	{ id = 22720, chance = 50000, maxCount = 12 },
	{ id = 22721, chance = 100000, maxCount = 6 },
	{ id = 22516, chance = 100000, maxCount = 9 },
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -5 },
	{ name = "combat", interval = 3000, chance = 5, type = COMBAT_FIREDAMAGE, minDamage = -5, maxDamage = -10, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1800, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -5, maxDamage = -10, range = 7, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 3000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -5, maxDamage = -10, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2500, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -3, maxDamage = -6, range = 7, radius = 5, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_PHYSICALDAMAGE, minDamage = -4, maxDamage = -8, range = 7, radius = 13, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -5, maxDamage = -8, radius = 14, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 3000, chance = 5, type = COMBAT_PHYSICALDAMAGE, minDamage = -2, maxDamage = -5, range = 7, radius = 3, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -4, maxDamage = -8, radius = 3, effect = CONST_ME_HITAREA, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 25, type = COMBAT_HEALING, minDamage = 20, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 470, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
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
