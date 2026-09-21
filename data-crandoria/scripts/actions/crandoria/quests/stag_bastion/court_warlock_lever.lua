-- -- CARNDORIA EDIT --

-- local config = {
-- 	boss = {
-- 		name = "Court Warlock",
-- 		position = Position(5252, 5463, 1),
-- 	},
-- 	timeToFightAgain = 60 * 60 * 20,
-- 	playerPositions = {
-- 		{pos = Position(5257, 5477, 3), teleport = Position(5253, 5473, 2)},
-- 		{pos = Position(5257, 5476, 3), teleport = Position(5253, 5473, 2)},
-- 		{pos = Position(5257, 5475, 3), teleport = Position(5253, 5473, 2)},
-- 		{pos = Position(5257, 5474, 3), teleport = Position(5253, 5473, 2)},
-- 		{pos = Position(5257, 5473, 3), teleport = Position(5253, 5473, 2)},
-- 	},
-- 	specPos = {
-- 		from = Position(5243, 5463, 2),
-- 		to = Position(5263, 5481, 2)
-- 	},
-- 	exit = Position(5252, 5473, 3),
-- 	monsters = {
-- 		{ name = "The Forgemaster", pos = Position(5065, 4237, 12) },
-- 	},
-- }

-- Game.setStorageValue("globalArbazilothHeal", 0)

-- local leverArbaziloth = BossLever(config)
-- leverArbaziloth:position(Position(5068, 4272, 12))
-- leverArbaziloth:register()





local config = {
	boss = {
		name = "Court Warlock",
		position = Position(5252, 5463, 1)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5257, 5477, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
		{pos = Position(5257, 5476, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
		{pos = Position(5257, 5475, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
		{pos = Position(5257, 5474, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
		{pos = Position(5257, 5473, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(5243, 5463, 2),
		to = Position(5263, 5481, 2)
	},
	exit = Position(5252, 5473, 3),
	storage = Storage.Quest.Crandoria.StagBastion.CourtWarlockTimer,
	monsters = {
		{ name = "Raging Raubritter", pos = Position(5249, 5469, 2) },
		{ name = "Energised Raubritter", pos = Position(5249, 5249, 2) },
		{ name = "Frozen Raubritter", pos = Position(5256, 5249, 2) },
		{ name = "Poisoned Raubritter", pos = Position(5249, 5469, 2) },
	},
}
local function clearUpperFloorMonsters(specPos)
	local upperFrom = Position(specPos.from.x, specPos.from.y, specPos.from.z - 1)
	local upperTo = Position(specPos.to.x, specPos.to.y, specPos.to.z - 1)

	local upperSpec = Spectators()
	upperSpec:setOnlyPlayer(false)
	upperSpec:setCheckPosition({ from = upperFrom, to = upperTo })
	upperSpec:check()
	upperSpec:removeMonsters()
end

local courtWarlockLever = Action()
function courtWarlockLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	clearUpperFloorMonsters(config.specPos)
	return CreateDefaultLeverBoss(player, config)
end

courtWarlockLever:position({x = 5258, y = 5478, z = 3})
courtWarlockLever:register()

-- local config = {
-- 	boss = {
-- 		name = "Court Warlock",
-- 		position = Position(5252, 5463, 1)
-- 	},
-- 	requiredLevel = 250,
-- 	timeToFightAgain = 20 * 60 * 60,
-- 	timeToDefeatBoss = 20 * 60,
-- 	playerPositions = {
-- 		{pos = Position(5257, 5477, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5257, 5476, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5257, 5475, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5257, 5474, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
-- 		{pos = Position(5257, 5473, 3), teleport = Position(5253, 5473, 2), effect = CONST_ME_TELEPORT},
-- 	},
-- 	specPos = {
-- 		from = Position(5243, 5463, 2),
-- 		to = Position(5263, 5481, 2)
-- 	},
-- 	exit = Position(5252, 5473, 3),
-- 	storage = Storage.Quest.Crandoria.StagBastion.CourtWarlockTimer,
-- }

-- local courtWarlockLever = Action()
-- function courtWarlockLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	return CreateDefaultLeverBoss(player, config)
-- end

-- courtWarlockLever:position({x = 5258, y = 5478, z = 3})
-- courtWarlockLever:register()