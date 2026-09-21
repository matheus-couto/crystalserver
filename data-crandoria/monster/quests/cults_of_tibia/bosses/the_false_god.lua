local mType = Game.createMonsterType("The False God")
local monster = {}

monster.description = "The False God"
monster.experience = 250000
monster.outfit = {
	lookType = 984,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1409,
	bossRace = RARITY_ARCHFOE,
}

monster.events = {
	"falseGodDeath",
}

monster.health = 550000
monster.maxHealth = 550000
monster.race = "blood"
monster.corpse = 22495
monster.speed = 230
monster.manaCost = 0

monster.changeTarget = {
	interval = 3000,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 95,
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
	interval = 10000,
	chance = 10,
	{ text = "YOU CAN'T DEAL WITH MY STRENGTH!", yell = true },
	{ text = "HOW DO YOU FEEL FIGHTING GOD?", yell = true },
	{ text = "YOU MORTALS CANNOT DEFEAT ME!", yell = true },
}

monster.loot = {
	-- { id = 30003, chance = 20000, maxCount = 1 },
	-- { id = 21184, chance = 30000, minCount = 1, maxCount = 2 }, -- NOVO
	{ id = 282, chance = 26900 }, -- giant shimmering pearl (brown)
	{ name = "magic sulphur", chance = 18920 },
	{ name = "mino shield", chance = 17620 },
	{ name = "silver token", chance = 1732 },
	{ name = "gold token", chance = 8532 },
	{ name = "gold coin", chance = 100000, maxCount = 200 },
	{ name = "platinum coin", chance = 29840, maxCount = 30 },
	{ name = "piece of hell steel", chance = 12370, maxCount = 9 },
	{ name = "red piece of cloth", chance = 16370, maxCount = 6 },
	{ name = "yellow gem", chance = 29460 },
	{ name = "blue gem", chance = 21892 },
	{ name = "underworld rod", chance = 117270 },
	{ name = "war axe", chance = 127270 },
	{ name = "pair of iron fists", chance = 9510 },
	{ name = "mysterious remains", chance = 100000 },
	{ name = "small diamond", chance = 12760, maxCount = 10 },
	{ name = "small amethyst", chance = 14700, maxCount = 10 },
	{ name = "small topaz", chance = 11520, maxCount = 10 },
	{ name = "small sapphire", chance = 13790, maxCount = 10 },
	{ name = "small emerald", chance = 14700, maxCount = 10 },
	{ name = "small amethyst", chance = 12259, maxCount = 10 },
	{ name = "energy bar", chance = 16872, maxCount = 3 },
	{ name = "ultimate health potion", chance = 27652, maxCount = 10 },
	{ id = 238, chance = 33721, maxCount = 10 },
	{ name = "great spirit potion", chance = 25690, maxCount = 5 },
	{ name = "piece of royal steel", chance = 15890 },
	{ name = "execowtioner axe", chance = 1800 },
	{ name = "maimer", chance = 1200 },
	{ name = "ornate mace", chance = 1800 },
	{ name = "velvet mantle", chance = 1200 },
	{ name = "iron ore", chance = 14542 },
	{ name = "giant sword", chance = 16892 },
	{ id = 8047, chance = 200 }, -- god's tunic
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = -1400, maxDamage = -2000, range = 6, radius = 4, effect = CONST_ME_STONES, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -1600, rande = 6, radius = 6, effect = CONST_ME_GROUNDSHAKER, target = false},
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_HOLYDAMAGE, minDamage = -800, maxDamage = -1000, range = 1, effect = CONST_ME_THUNDER, target = true},
	{ name = "great holy ring", interval = 2000, chance = 20, minDamage = -800, maxDamage = -1800},
	{ name = "speed", interval = 2000, chance = 20, speedChange = -650, radius = 5, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.defenses = {
	defense = 66,
	armor = 66,
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 10 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 5 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
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
