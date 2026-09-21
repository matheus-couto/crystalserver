local mType = Game.createMonsterType("The Enraged Queen")
local monster = {}

monster.description = "The Enraged Queen"
monster.experience = 20000000
monster.outfit = {
	lookType = 354,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 500000
monster.maxHealth = 1000000
monster.race = "fire"
monster.corpse = 6068
monster.speed = 200
monster.manaCost = 0

monster.events = {
	"QueenOfHeartsTransform",
}

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
	maxSummons = 4,
	summons = {
		{ name = "Clubs Guard", chance = 15, interval = 4000, count = 1 },
		{ name = "Spades Guard", chance = 15, interval = 4000, count = 1 },
		{ name = "Diamonds Guard", chance = 15, interval = 4000, count = 1 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "HA HA HA HA HA!", yell = true },
	{ text = "CORTEM AS CABECAS DELES!", yell = true },
	{ text = "VOCE OUSA DESAFIAR A RAINHA DE COPAS?", yell = false },
	{ text = "MEU MUNDO, MEU REINO, MINHA REGRAS!", yell = true },
}

monster.loot = {
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -900, maxDamage = -2450 },
	{ name = "combat", interval = 1800, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -1900, maxDamage = -4280, range = 1, effect = CONST_ME_SLASH, target = true },
	{ name = "combat", interval = 7500, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -3500, maxDamage = -6000, range = 7, radius = 7, effect = CONST_ME_MORTAREA, target = false },
	{name ="anomaly break", interval = 3000, chance = 40, target = false},
	{name ="boss break", interval = 3000, chance = 40, target = false},
	{ name = "combat", interval = 2200, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -3600, maxDamage = -6050, radius = 10, effect = CONST_ME_PLANTATTACK, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -750, range = 7, effect = CONST_ME_SOUND_RED, target = false, duration = 20000 },

}

monster.defenses = {
	defense = 65,
	armor = 130,
	--	mitigation = ???,
	{ name = "combat", interval = 4000, chance = 22, type = COMBAT_HEALING, minDamage = 4500, maxDamage = 7000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 4000, chance = 80, speedChange = 670, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 35 },
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
