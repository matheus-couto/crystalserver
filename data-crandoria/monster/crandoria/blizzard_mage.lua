local mType = Game.createMonsterType("Blizzard Mage")
local monster = {}

monster.description = "a blizzard mage"
monster.experience = 8225
monster.outfit = {
	lookType = 130,
	lookHead = 86,
	lookBody = 57,
	lookLegs = 57,
	lookFeet = 57,
	lookAddons = 3,
	lookMount = 630
}


monster.health = 5300
monster.maxHealth = 5300
monster.race = "blood"
monster.corpse = 18102
monster.speed = 170
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 20
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	random = 10,
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 500,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{name = "ice golem", chance = 20, interval = 2000, count = 1}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Come and die, mortal!", yell = false},
	{text = "Some like it cold!", yell = false},
	{text = "It's freezing time!", yell = false}
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{name = "gold coin", chance = 56500, maxCount = 100},
	{name = "platinum coin", chance = 40000, maxCount = 12},
	{id = 3051, chance = 1800}, -- energy ring
	{name = "skull staff", chance = 6500},
	{name = "magic sulphur", chance = 600},
	{name = "blue piece of cloth", chance = 620},
	{id = 238, chance = 19700},
	{name = "great health potion", chance = 1900},
	{name = "small enchanted sapphire", chance = 4250},
	{name = "glacier shoes", chance = 300},
	{name = "royal tapestry", chance = 520},
	{name = "blue robe", chance = 820}, 
	{name = "raspberry", chance = 8500, maxCount = 5},
	{name = "spellbook of mind control", chance = 370},
	{name = "gold ingot", chance = 1700}

}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -120, maxDamage = -300},
	{name ="great ice ring", interval = 1000, chance = 20, minDamage = -120, maxDamage = -250, range = 6, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -120, maxDamage = -280, length = 5, spread = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 1000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -130, maxDamage = -290, range = 7, radius = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_ICETORNADO, target = false}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 90, maxDamage = 430, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = -15},
	{type = COMBAT_FIREDAMAGE, percent = 80},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
