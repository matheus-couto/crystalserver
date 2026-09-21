local config = {
	boss = {
		name = "Grugarosh",
		position = Position(5893, 4418, 9)
	},
	requiredLevel = 400,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5896, 4444, 9), teleport = Position(5894, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5896, 4445, 9), teleport = Position(5894, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5896, 4446, 9), teleport = Position(5894, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5896, 4447, 9), teleport = Position(5894, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5895, 4444, 9), teleport = Position(5893, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5895, 4445, 9), teleport = Position(5893, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5895, 4446, 9), teleport = Position(5893, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5895, 4447, 9), teleport = Position(5893, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5897, 4444, 9), teleport = Position(5895, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5897, 4445, 9), teleport = Position(5895, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5897, 4446, 9), teleport = Position(5895, 4429, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5897, 4447, 9), teleport = Position(5895, 4429, 9), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(5882, 4414, 9),
		to = Position(5904, 4434, 9)
	},
	exit = Position(5896, 4449, 9),
	storage = Storage.Quest.Crandoria.NagasQuest.GrugaroshTimer,
}

local grugaroshLever = Action()
function grugaroshLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

grugaroshLever:position({x = 5896, y = 4443, z = 9})
grugaroshLever:register()