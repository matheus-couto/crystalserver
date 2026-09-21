local mType = Game.createMonsterType("Dragon Knight")
local monster = {}

monster.description = "a dragon knight"
monster.experience = 19800
monster.outfit = {
	lookType = 1071,
	lookHead = 95,
	lookBody = 3,
	lookLegs = 3,
	lookFeet = 125,
	lookAddons = 3,
	lookMount = 0,
}


monster.health = 22850
monster.maxHealth = 22850
monster.race = "blood"
monster.corpse = 28733
monster.speed = 105
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
	{ name = "platinum coin", chance = 76234, maxCount = 21},
	{ name = "ham", chance = 50000, maxCount = 2 },
	{ name = "onyx arrow", chance = 35000, maxCount = 3 },
	{ name = "small diamond", chance = 30000, maxCount = 3 },
	{ name = "small emerald", chance = 30000, maxCount = 3 },
	{ name = "small enchanted amethyst", chance = 20000, maxCount = 3 },
	{ name = "damaged armor plates", chance = 2350, maxCount = 3 },
	{ name = "knight armor", chance = 7000 },
	{ name = "spiked squelcher", chance = 1200 },
	{ name = "dragon shield", chance = 3500},
	{ name = "dragon lance", chance = 5520},
	{ name = "dragon scale mail", chance = 1500}

}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -150, maxDamage = -1150 },
	{ name = "combat", interval = 1500, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -380, maxDamage = -890, range = 4, radius = 4, effect = CONST_ME_REDSMOKE, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -590, maxDamage = -920, range = 7, shootEffect = CONST_ANI_ETHEREALSPEAR, target = false },
	{ name = "combat", interval = 1500, chance = 14, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_BLOCKHIT, target = false },
	{ name = "combat", interval = 2000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -350, maxDamage = -950, range = 6, length = 7, effect = CONST_ME_ENERGYAREA, target = false}
}

monster.defenses = {
	defense = 62,
	armor = 75,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 200, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 10, speedChange = 220, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 80 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
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
