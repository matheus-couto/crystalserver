local mType = Game.createMonsterType("Voidborn")
local monster = {}

monster.description = "a voidborn"
monster.experience = 56000
monster.outfit = {
	lookType = 987,
}


monster.health = 43850
monster.maxHealth = 43850
monster.race = "blood"
monster.corpse = 26133
monster.speed = 185
monster.manaCost = 0


monster.changeTarget = {
	interval = 4000,
	chance = 35,
}

monster.changeTarget2 = {
	interval = 3000,
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
	staticAttackChance = 70,
	targetDistance = 1,
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
	-- { id = 3250, chance = 1700, maxCount = 3 },
	{ name = "crystal coin", chance = 12234, maxCount = 1},
	{ name = "platinum coin", chance = 76234, maxCount = 39},
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "ultimate mana potion", chance = 10000, maxCount = 2 },
	{ name = "ultimate health potion", chance = 10000, maxCount = 2 },
	{ name = "ultimate spirit potion", chance = 10000, maxCount = 2 },
	{ name = "small diamond", chance = 3000, maxCount = 8 },
	{ name = "small emerald", chance = 3000, maxCount = 12 },
	{ name = "small enchanted amethyst", chance = 2000, maxCount = 6 },
	{ name = "knight armor", chance = 12000 },
	{ name = "dragon scale mail", chance = 8500},
	-- { id = 35909, chance = 150},
	{ id = 8099, chance = 100},
	-- { id = 44179, chance = 100},

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -1350 },
	{ name = "extended energy chain", interval = 2000, chance = 25, minDamage = -800, maxDamage = -1400, target = true, range = 6},
	{ name = "combat", interval = 1500, chance = 18, type = COMBAT_LIFEDRAIN, minDamage = -660, maxDamage = -980, range = 5, radius = 5, effect = CONST_ME_PURPLESMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -650, maxDamage = -1100, target = true, radius = 1, effect = CONST_ME_SLASH },

}

monster.defenses = {
	defense = 72,
	armor = 78,
	{ name = "combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 600, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 40 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 25 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
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
