local mType = Game.createMonsterType("Spectre of Shadows")
local monster = {}

monster.description = "a spectre of shadows"
monster.experience = 23400
monster.outfit = {
	lookType = 1418,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 32400
monster.maxHealth = 32400
monster.race = "blood"
monster.corpse = 36894
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
	{name = "platinum coin", chance = 70000, maxCount = 20},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{name = "ultimate mana potion", chance = 15360, maxCount = 2},
	{name = "ultimate spirit potion", chance = 22360, maxCount = 4},
	{name = "cyan crystal fragment", chance = 5830, maxCount = 3},
	{name = "glacier shoes", chance = 8590},
	{name = "glacier kilt", chance = 3590},
	{name = "blue gem", chance = 5060},
	{name = "fire axe", chance = 5060},
	{id = 3026, chance = 15344, maxCount = 4}, -- white pearl
	{id = 3161, chance = 15344, maxCount = 2}, -- avalanche rune
	{id = 6499, chance = 15344, maxCount = 2}, -- demonic essence
	{id = 35580, chance = 120, maxCount = 1}, -- golden skull
	{name = "ice rapier", chance = 7500},
}

if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
	monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{name = "platinum coin", chance = 70000, maxCount = 20},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{name = "ultimate mana potion", chance = 15360, maxCount = 2},
	{name = "ultimate spirit potion", chance = 22360, maxCount = 4},
	{name = "cyan crystal fragment", chance = 5830, maxCount = 3},
	{name = "glacier shoes", chance = 8590},
	{name = "glacier kilt", chance = 3590},
	{name = "blue gem", chance = 5060},
	{name = "fire axe", chance = 5060},
	{id = 3026, chance = 15344, maxCount = 4}, -- white pearl
	{id = 3161, chance = 15344, maxCount = 2}, -- avalanche rune
	{id = 6499, chance = 15344, maxCount = 2}, -- demonic essence
	{name = "ice rapier", chance = 7500},
	}
end

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1400},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -800, maxDamage = -1250, radius = 7, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -1400, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},
}

if Game.getStorageValue(GlobalStorage.Crandoria.MasmorraDoCaos.TilesTrap) < os.time() then
	monster.attacks = {
		{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1800},
		{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -700, maxDamage = -1950, radius = 7, effect = CONST_ME_ICETORNADO, target = false},
		{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -800, maxDamage = -1800, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},
	}
end

monster.defenses = {
	defense = 76,
	armor = 76,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 250, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = -20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 25},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 55}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
