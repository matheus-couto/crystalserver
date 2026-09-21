local mType = Game.createMonsterType("Stalker of Shadows")
local monster = {}

monster.description = "a stalker of shadows"
monster.experience = 22000
monster.outfit = {
	lookType = 1407,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 33000
monster.maxHealth = 33000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 280
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 4000,
	chance = 10
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{name = "platinum coin", chance = 70000, maxCount = 25},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{name = "ultimate health potion", chance = 20360, maxCount = 4},
	{name = "green crystal fragment", chance = 5830, maxCount = 3},
	{name = "diamond sceptre", chance = 4590},
	{name = "green gem", chance = 5060},
	{name = "focus cape", chance = 3060},
	{id = 3027, chance = 15344, maxCount = 4}, -- black pearl
	{id = 3155, chance = 15344, maxCount = 2}, -- sudden death rune
	{id = 6499, chance = 15344, maxCount = 2}, -- demonic essence
	{id = 35580, chance = 100, maxCount = 1}, -- golden skull
	{name = "dragonbone staff", chance = 7500},
}

if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
	monster.loot = {
	-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{name = "platinum coin", chance = 70000, maxCount = 25},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{name = "ultimate health potion", chance = 20360, maxCount = 4},
	{name = "green crystal fragment", chance = 5830, maxCount = 3},
	{name = "diamond sceptre", chance = 4590},
	{name = "green gem", chance = 5060},
	{name = "focus cape", chance = 3060},
	{id = 3027, chance = 15344, maxCount = 4}, -- black pearl
	{id = 3155, chance = 15344, maxCount = 2}, -- sudden death rune
	{id = 6499, chance = 15344, maxCount = 2}, -- demonic essence
	{name = "dragonbone staff", chance = 7500},
}
end

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1400},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -1050, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 2000, chance = 22, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -1150, length = 3, spread = 2, effect = CONST_ME_GREEN_RINGS, target = false}
}

if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
	monster.attacks = {
		{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1600},
		{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -880, maxDamage = -1750, radius = 4, effect = CONST_ME_MORTAREA, target = false},
		{name ="combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -800, maxDamage = -1800, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},
		{name ="combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -1450, length = 3, spread = 2, effect = CONST_ME_GREEN_RINGS, target = false}
	}
end

monster.defenses = {
	defense = 76,
	armor = 76,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 250, maxDamage = 750, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 25},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = -15},
	{type = COMBAT_DEATHDAMAGE , percent = 75}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
