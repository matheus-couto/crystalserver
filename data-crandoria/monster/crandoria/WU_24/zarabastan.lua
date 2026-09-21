local mType = Game.createMonsterType("Zarabastan")
local monster = {}

monster.description = "Zarabastan"
monster.experience = 3000000
monster.outfit = {
	lookType = 130,
	lookHead = 0,
	lookBody = 77,
	lookLegs = 92,
	lookFeet = 97,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 750000
monster.maxHealth = 750000
monster.race = "blood"
monster.corpse = 18273
monster.speed = 165
monster.manaCost = 0

monster.events = {
	"zarabastanDeath",
}

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
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
	staticAttackChance = 90,
	targetDistance = 3,
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

monster.summon = {
	maxSummons = 4,
	summons = {
		{ name = "Master Warlock", chance = 10, interval = 2000, count = 2 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 5,
	{ text = "Sua forca nao chega nem perto do poder do meu conhecimento!", yell = false },
	{ text = "O tempo esta a meu favor.", yell = false },
	{ text = "Voce andou praticando? Nao parece. Ha ha ha ha!", yell = false },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ id = 3043, chance = 32000, maxCount = 4 },
	{ id = 39145, chance = 100, maxCount = 1, unique = true },
	{ id = 3035, chance = 32000, maxCount = 22 },
	{ id = 3324, chance = 18330 }, -- skull staff
	{ id = 3567, chance = 13390 }, -- blue robe
	{ id = 3029, chance = 18190, maxCount = 15 }, -- small sapphire
	{ id = 30061, chance = 12190, maxCount = 2 }, -- giant sapphire
	{ id = 3364, chance = 15240 }, -- golden legs
	{ id = 825, chance = 8040 }, -- lightning robe
	{ id = 10438, chance = 15000 }, -- spellweavers robe
	{ id = 3366, chance = 8000 }, -- mpa
	{ id = 3006, chance = 5420 }, -- ring of the sky
	{ id = 3360, chance = 15240 }, -- golden armor
	{ id = 3414, chance = 7000 }, -- mms
	{ id = 3079, chance = 17000 }, -- boh
	{ id = 22706, chance = 100 }, -- casino ticket
	{ id = 20275, chance = 500 }, -- dream warden claw
	{ id = 24964, chance = 5000 }, -- living crystal
	-- { id = 25745, chance = 15000 }, -- livro sagrado
	
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1430 },
	{ name = "warlock skill reducer", interval = 2000, chance = 15, range = 5, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -950, maxDamage = -1550, range = 7, radius = 4, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
	{ name = "great death ring", interval = 1800, chance = 20, minDamage= -1000, maxDamage= -1800, range = 8, target = false },
	{ name = "combat", interval = 2500, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -880, maxDamage = -1850, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_WATER_DROP, target = false },
	{ name = "zarabastan teleport", interval = 15000, chance = 100, range = 8, target = false },
	{ name = "combat", interval = 3500, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1530, maxDamage = -2550, radius = 8, effect = CONST_ME_BIGCLOUDS, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -250, maxDamage = -450, range = 7, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -600, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 20000 },

}

monster.defenses = {
	defense = 20,
	armor = 20,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 2500, maxDamage = 3500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "invisible", interval = 2000, chance = 20, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 90 },
	{ type = COMBAT_EARTHDAMAGE, percent = 75 },
	{ type = COMBAT_FIREDAMAGE, percent = 90 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 75 },
	{ type = COMBAT_HOLYDAMAGE, percent = -15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
