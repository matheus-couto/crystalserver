local mType = Game.createMonsterType("Groguron")
local monster = {}

monster.description = "Groguron"
monster.experience = 250000000
monster.outfit = {
	lookType = 1464,
	lookAddons = 3,
	lookMount = 0,
}


-- monster.health = 2500000
monster.health = 3500000
monster.maxHealth = 3500000
monster.race = "fire"
monster.corpse = 37590
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

-- monster.events = {
-- 	"groguronDeath",
-- }

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
	runHealth = 100000,
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
	maxSummons = 8,
	summons = {
		{ name = "Orc Spearman", chance = 80, interval = 2000, count = 1 },
		{ name = "Orc Spearman", chance = 80, interval = 2000, count = 1 },
		{ name = "Orc Berserker", chance = 80, interval = 2000, count = 1 },
		{ name = "Orc Berserker", chance = 80, interval = 2000, count = 1 },
		{ name = "Orc", chance = 80, interval = 2000, count = 1 },
		{ name = "Orc", chance = 80, interval = 2000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "NEM TODOS OS CALDOS DE FEIJAO DO MUNDO VAO SACIAR A MINHA FOME! HAHAHAHA", yell = true },
	{ text = "SAIAM DA FRENTE, MORTAIS. PRECISO DE UM QUENTAO!", yell = true },
	{ text = "ONDE ESTA A CANJICA? E O BOLO DE FUBA? AAAAHHHHHHH!", yell = true },
	{ text = "TRAGA TODAS AS IGUARIAS DE SAO JOAO PARA MIM. EU ORDENO!!!", yell = true },
}

monster.loot = {
	-- { id = 21184, chance = 3500, maxCount = 1 },
	{ name = "platinum coin", chance = 95000, maxCount = 74 },
	{ name = "platinum coin", chance = 65000, maxCount = 44 },
	{ id = 3043, chance = 100000, maxCount = 50 },
	{ id = 3043, chance = 100000, maxCount = 50 },
	{ id = 12811, chance = 15000, maxCount = 1 },
	{ id = 22724, chance = 25000, maxCount = 12 },
	{ id = 22720, chance = 25000, maxCount = 12 },
	{ id = 22721, chance = 100000, maxCount = 6 },
	{ id = 22516, chance = 100000, maxCount = 9 },
	{ id = 3387, chance = 15000, unique = true },
	{ id = 30061, chance = 100000, maxCount = 3 },
	{ id = 3422, chance = 10000, unique = true },
	{ id = 3399, chance = 10000, unique = true },
	{ id = 3366, chance = 50000, maxCount = 1 },
	{ id = 3554, chance = 50000, maxCount = 1 },
	{ id = 3364, chance = 50000, maxCount = 1 },
	{ id = 3057, chance = 50000, maxCount = 1 },
	{ id = 8061, chance = 50000, maxCount = 1 },
	{ id = 3079, chance = 50000, maxCount = 1 },
	{ id = 3340, chance = 50000, maxCount = 1 },
	{ id = 3386, chance = 50000, maxCount = 1 },
	{ id = 5741, chance = 20000, maxCount = 1 },
	{ id = 3360, chance = 50000, maxCount = 1 },
	{ id = 3388, chance = 10000, maxCount = 1 },
	{ id = 16244, chance = 10000, maxCount = 1 },
	-- { id = 9220, chance = 10000, maxCount = 1 },
	{ id = 3389, chance = 5000, maxCount = 1 },
	{ id = 20138, chance = 15000, maxCount = 1 },
	{ id = 20139, chance = 15000, maxCount = 1 },
	{ id = 26186, chance = 15000, maxCount = 2 },
	{ id = 39136, chance = 100000, maxCount = 2 },
	{ id = 30060, chance = 75000, maxCount = 3 },
	{ id = 30059, chance = 75000, maxCount = 3 },
	{ id = 3024, chance = 10000, unique = true },
	{ id = 39136, chance = 50000, maxCount = 2 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -150, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1800, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -40, maxDamage = -180, range = 7, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 3000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -120, maxDamage = -150, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 2500, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -200, range = 7, radius = 5, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -105, maxDamage = -250, range = 7, radius = 13, effect = CONST_ME_SOUND_RED, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -120, maxDamage = -150, radius = 14, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -140, maxDamage = -180, range = 7, radius = 3, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "godfather explosion", interval = 5500, chance = 20, minDamage = -160, maxDamage = -250, targe = false, range = 8},
	{name = "flame guardian vortex", interval = 4200, chance = 15, minDamage = -140, maxDamage = -160, target = false},
}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 470, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
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
