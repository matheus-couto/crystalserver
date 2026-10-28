local mType = Game.createMonsterType("Bonelord's Phylactery")
local monster = {}

monster.description = "a bonelord's phylactery"
monster.experience = 0 -- unknown
monster.outfit = {
	lookTypeEx = 52466,
}

monster.events = {
	"soulcageDeath",
}

monster.health = 120000 -- não confirmado
monster.maxHealth = 120000 -- não confirmado
monster.race = "undead"
monster.corpse = 6068 -- não confirmado
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100, -- não confirmado
}

monster.flags = {
	summonable = false, -- não confirmado
	attackable = true, -- não confirmado
	hostile = true, -- não confirmado
	convinceable = false, -- não confirmado
	pushable = false, -- não confirmado
	rewardBoss = true, -- não confirmado
	illusionable = false, -- não confirmado
	canPushItems = false, -- não confirmado
	canPushCreatures = false, -- não confirmado
	staticAttackChance = 90, -- não confirmado
	targetDistance = 1, -- não confirmado
	runHealth = 0, -- não confirmado
	healthHidden = false, -- não confirmado
	isBlockable = false, -- não confirmado
	canWalkOnEnergy = true, -- não confirmado
	canWalkOnFire = true, -- não confirmado
	canWalkOnPoison = true, -- não confirmado
}

monster.light = {
	level = 0, -- não confirmado
	color = 0, -- não confirmado
}

monster.loot = {
	{ name = "crystal coin", chance = 100000, minCount = 30, maxCount = 50 },
	{ name = "ultimate mana potion", chance = 40000, minCount = 22, maxCount = 50 },
	{ name = "ultimate spirit potion", chance = 44000, minCount = 22, maxCount = 46 }, 
	{ name = "ultimate health potion", chance = 44000, minCount = 22, maxCount = 38 }, 
	{ id = 10316, chance = 44000, maxCount = 2 },
	{ id = 238, chance = 32000, maxCount = 70 },
	{ name = "haunted blade", chance = 32000 },
	{ name = "yellow gem", chance = 28000, minCount = 3, maxCount = 10 },
	{ id = 3039, chance = 28000, minCount = 3, maxCount = 8 },
	{ name = "bonelord eye", chance = 28000, maxCount = 2 },
	{ name = "great spirit potion", chance = 28000, minCount = 30, maxCount = 51 },
	{ name = "supreme health potion", chance = 24000, minCount = 8, maxCount = 14 },
	{ name = "strong mana potion", chance = 32000, minCount = 33, maxCount = 93 },
	{ name = "small flask of eyedrops", chance = 24000 },
	{ name = "blue gem", chance = 16000, maxCount = 3 },
	{ name = "giant sapphire", chance = 16000, maxCount = 3 },
	{ name = "bonelord shield", chance = 15000 },
	{ id = 8061, chance = 8000 },
	{ id = 10438, chance = 8000 },
	{ name = "skull staff", chance = 8000 },
	{ name = "giant ruby", chance = 4000, maxCount = 2 },
	{ name = "giant emerald", chance = 4000, maxCount = 1 },
	{ name = "skull helmet", chance = 4000 },
	{ name = "ancient scales", chance = 4000 },
	{ name = "soul trap", chance = 1500 },
	{ name = "skull tendril", chance = 400 },
	{ name = "necromantic crypt rune", chance = 400 },
	{ id = 52716, chance = 400 },
	
	-- { name = "guardian gem", chance = 100000 },
	-- { name = "marksman gem", chance = 100000 },
	-- { name = "mystic gem", chance = 100000 },
	-- { name = "sage gem", chance = 100000 },
	-- { name = "spiritualist gem", chance = 100000 },
	-- { name = "greater guardian gem", chance = 100000 },
	-- { name = "greater marksman gem", chance = 100000 },
	-- { name = "greater mystic gem", chance = 100000 }, 
	-- { name = "greater sage gem", chance = 100000 }, 
	-- { name = "greater spiritualist gem", chance = 100000 },

}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -800, maxDamage = -1200, radius = 5, effect = CONST_ME_MORTAREA, target = false }, -- não confirmado
}

monster.defenses = {
	defense = 100, -- não confirmado
	armor = 100, -- não confirmado
	mitigation = 2.00, -- não confirmado
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_MANADRAIN, percent = 0 }, -- não confirmado
	{ type = COMBAT_DROWNDAMAGE, percent = 0 }, -- não confirmado
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true }, -- não confirmado
	{ type = "outfit", condition = true }, -- não confirmado
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }, -- não confirmado
}

mType:register(monster)
