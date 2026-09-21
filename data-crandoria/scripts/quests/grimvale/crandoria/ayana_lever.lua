local config = {
	boss = {
		name = "Ayana the Crimson Curse",
		position = Position(4709, 4324, 8)
	},
	requiredLevel = 100,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 10 * 60,
	playerPositions = {
		{pos = Position(4794, 4321, 10), teleport = Position(4711, 4335, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4794, 4322, 10), teleport = Position(4711, 4335, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4794, 4323, 10), teleport = Position(4711, 4335, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4794, 4324, 10), teleport = Position(4711, 4335, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4794, 4325, 10), teleport = Position(4711, 4335, 8), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4696, 4319, 8),
		to = Position(4720, 4340, 8)
	},
	exit = Position(4730, 4335, 8),
	storage = Storage.Grimvale.AyanaTimer
}

local ayanaLever = Action()
function ayanaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

ayanaLever:position({x = 4794, y = 4320, z = 10})
ayanaLever:register()