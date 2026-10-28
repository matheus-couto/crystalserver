local mType = Game.createMonsterType("Flamanzog")
local monster = {}

monster.description = "Flamanzog"
monster.experience = 150000000
monster.outfit = {
	lookType = 583,
}

monster.health = 1500000
monster.maxHealth = 1500000
monster.race = "blood"
monster.corpse = 20144
monster.speed = 190
monster.manaCost = 0

monster.events = {
	"bossDisputaKill",
}


monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 50,
	health = 10,
	random = 30,
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
	staticAttackChance = 70,
	targetDistance = 1,
	healthHidden = false,
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
	{ id = 3043, chance = 100000, minCount = 8, maxCount = 22 },
	{ id = 3043, chance = 5000, maxCount = 1 },
}

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "Burning Book", chance = 30, interval = 2000, count = 2}
	}
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2550 },
	{ name = "timira fire ring", interval = 2000, chance = 15, minDamage = -2060, maxDamage = -4525 },
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -1490, maxDamage = -1925, range = 3, target = true },
	{ name = "mana drain chain", interval = 2000, chance = 20, minDamage = -810, maxDamage = -1130 },
	{name = "great fire ring", interval = 2000, chance = 20, minDamage = -2890, maxDamage = -5950, targe = false},
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1200, maxDamage = -2500, range = 5, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -1450, maxDamage = -4580, radius = 4, effect = CONST_ME_FIREAREA, target = false},
	{ name = "boss break", interval = 2000, chance = 100, target = false},
}

monster.defenses = {
	defense = 100,
	armor = 100,
	mitigation = 2.07,
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -25 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
