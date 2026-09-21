local mType = Game.createMonsterType("Lost Tortoise")
local monster = {}

monster.description = "a lost tortoise"
monster.experience = 13300
monster.outfit = {
	lookType = 361,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}


monster.health = 14900
monster.maxHealth = 14900
monster.race = "blood"
monster.corpse = 6073
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 5000,
	chance = 30,
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 4,
	color = 5,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
	-- { id = 3250, chance = 900, maxCount = 2 },
	{ id = 3035, chance = 66666, maxCount = 35 },
	{ id = 3035, chance = 33333, maxCount = 22 },
	{ id = 3043, chance = 2100, maxCount = 1 },
	{ id = 7643, chance = 8100, maxCount = 1 },
	{ id = 238, chance = 4100, maxCount = 2 },
	{ id = 5899, chance = 2800 }, -- turtle shell
	{ name = "tortoise egg", chance = 790, maxCount = 3 },
	{ name = "white mushroom", chance = 2200 },
	{ name = "brown mushroom", chance = 1700 },
	{ id = 3366, chance = 1700 },
	{ id = 3364, chance = 1700 },
	{ id = 3391, chance = 3333 },
	{ id = 10438, chance = 1000 },
	{ name = "white pearl", chance = 3600, maxCount = 4 },
	{ name = "black pearl", chance = 4200, maxCount = 2 },
	{ id = 29995, chance = 500, maxCount = 1 },

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1230 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -700, maxDamage = -1100, area = 3, range = 7, effect = CONST_ME_STONES, shootEffect = CONST_ANI_LARGEROCK, target = true },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = 1250, range = 6, length = 6, spread = 5, effect = CONST_ME_GROUNDSHAKER, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 65,
	--	mitigation = ???,
	{ name = "combat", interval = 4000, chance = 15, type = COMBAT_HEALING, minDamage = 550, maxDamage = 850, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
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
