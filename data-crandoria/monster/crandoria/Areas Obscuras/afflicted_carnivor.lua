local mType = Game.createMonsterType("Afflicted Carnivor")
local monster = {}

monster.description = "an afflicted carnivor"
monster.experience = 12112
monster.outfit = {
	lookType = 1138,
	lookHead = 86,
	lookBody = 51,
	lookLegs = 83,
	lookFeet = 91,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 13500
monster.maxHealth = 13500
monster.race = "blood"
monster.corpse = 30103
monster.speed = 210
monster.manaCost = 0

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
	canWalkOnPoison = true,
}

monster.light = {
	level = 5,
	color = 184,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 8177, chance = 150, maxCount = 2 },
	{ id = 26186, chance = 40, maxCount = 1 },
	{ name = "platinum coin", chance = 100000, maxCount = 6 },
	{ name = "morning star", chance = 100000 },
	{ name = "platinum coin", chance = 100000, maxCount = 50 },
	{ name = "platinum coin", chance = 30000, maxCount = 30 },
	{ name = "terra rod", chance = 15550 },
	{ name = "small ruby", chance = 15000 },
	{ name = "crystal sword", chance = 25000 },
	{ name = "ultimate mana potion", chance = 50000 },
	{ name = "wand of dragonbreath", chance = 15000 },
	{ name = "machete", chance = 30000 },
	{ name = "iron helmet", chance = 20000 },
	{ name = "serpent sword", chance = 18000 },
	{ name = "heavy machete", chance = 17000 },
	{ name = "terra legs", chance = 6000 },
	{ name = "knight legs", chance = 4500 },
	{ name = "wand of starstorm", chance = 8000 },
	{ name = "wand of voodoo", chance = 7100 },
	-- { name = "violet glass plate", chance = 6200 },
	{ name = "small enchanted ruby", chance = 2400 },
	{ name = "green crystal fragment", chance = 3600 },
	{ name = "onyx chip", chance = 9800 },
	{ name = "opal", chance = 4000 },
	{ name = "tiger eye", chance = 3000 },
	{ name = "wand of decay", chance = 8700 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -550 },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -120, maxDamage = -250, length = 4, spread = 3, effect = CONST_ME_SMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 14, type = COMBAT_LIFEDRAIN, minDamage = -120, maxDamage = -250, length = 4, spread = 3, effect = CONST_ME_POISONAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -180, maxDamage = -360, radius = 4, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 0,
	armor = 68,
	mitigation = 1.88,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 200, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.reflects = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
