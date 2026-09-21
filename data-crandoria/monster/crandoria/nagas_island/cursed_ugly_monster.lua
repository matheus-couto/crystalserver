local mType = Game.createMonsterType("Cursed Ugly Monster")
local monster = {}

monster.description = "a cursed ugly monster"
monster.experience = 12250
monster.outfit = {
	lookType = 1218,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 12250
monster.maxHealth = 12250
monster.race = "blood"
monster.corpse = 31551
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
	staticAttackChance = 90,
	targetDistance = 4,
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 1700, maxCount = 1 },
--	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ id = 3043, chance = 1300, maxCount = 1 },
	{ id = 3035, chance = 40300, maxCount = 66 },
	{ id = 3035, chance = 20300, maxCount = 66 },
	{ id = 6499, chance = 8300, maxCount = 1 },
	{ id = 3028, chance = 15300, maxCount = 7 },
	{ id = 3324, chance = 15300, maxCount = 1 },
	{ id = 3383, chance = 15300, maxCount = 1 },
	{ id = 3360, chance = 3300, maxCount = 1 },
	{ name = "ultimate health potion", chance = 6300, maxCount = 3 },
	{ name = "wand of voodoo", chance = 3300 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1120 },
	{ name = "great death ring", interval = 2000, chance = 15, minDamage = -880, maxDamage = -1300, range = 7, target = false },
	{ name = "drunk", interval = 2000, chance = 10, range = 5, shootEffect = CONST_ANI_EARTH, target = false, duration = 5000 },
	{ name = "combat", interval = 2000, chance = 22, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1450, radius = 4, range = 4, effect = CONST_ME_INSECTS, target = false }
	
}

monster.defenses = {
	defense = 48,
	armor = 60,
	--	mitigation = ???,
	{ name = "invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_GREEN },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = -10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
