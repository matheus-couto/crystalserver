local mType = Game.createMonsterType("Cannibal Iks Druid")
local monster = {}

monster.description = "a cannibal iks druid"
monster.experience = 31700
monster.outfit = {
	lookType = 1590,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 80000
monster.maxHealth = 80000
monster.race = "blood"
monster.corpse = 42065
monster.speed = 180
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 3,
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
		-- -- -- { id = 3250, chance = 900, maxCount = 1 },
--	-- { id = 3250, chance = 900, maxCount = 2 },
	{ name = "gold coin", chance = 1000000, maxCount = 477 },
	{ id = 281, chance = 7100 }, -- giant shimmering pearl (green)
	{ id = 3043, chance = 77100, maxCount = 4 },
	{ name = "tiger eye", chance = 7100 },
	{ name = "ultimate mana potion", chance = 86380, maxCount = 2 },
	{ name = "ultimate health potion", chance = 86380, maxCount = 2 },
	{ name = "ultimate spirit potion", chance = 86380, maxCount = 2 },
	{ name = "small sapphire", chance = 4370, maxCount = 15 },
	{ name = "daedal chisel", chance = 2910 },
	{ name = "opal", chance = 1640, maxCount = 12 },
	{ name = "ritual tooth", chance = 1460 },
	{ name = "spellbook of enlightenment", chance = 1090 },
	{ name = "gold ingot", chance = 730 },
	{ name = "rotten feather", chance = 730 },
	{ name = "broken iks faulds", chance = 5360 },
	{ id = 39137, chance = 30000, maxCount = 1, unique = true },
	{ name = "gold-brocaded cloth", chance = 500 },
	{ name = "gold-brocaded cloth", chance = 500 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1235 },
	{ name = "combat", type = COMBAT_ICEDAMAGE, interval = 2000, chance = 100, shootEffect = CONST_ANI_ICE, range = 4, effect = CONST_ME_ICEATTACK, minDamage = -200, maxDamage = -350 },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -720, maxDamage = -1250, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -720, maxDamage = -1350, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "bakragore vortex", interval = 2000, chance = 20, minDamage = -585, maxDamage = -1250, range = 7, target = false },
}

monster.defenses = {
	defense = 35,
	armor = 34,
	mitigation = 1.26,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 25 },
	{ type = COMBAT_FIREDAMAGE, percent = 25 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
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
