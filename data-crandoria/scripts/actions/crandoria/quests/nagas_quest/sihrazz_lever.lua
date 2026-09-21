local config = {
	boss = {
		name = "Sihrazz Shadow",
		position = Position(4875, 5379, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5904, 4323, 14), teleport = Position(5898, 4312, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5903, 4323, 14), teleport = Position(5898, 4312, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5902, 4323, 14), teleport = Position(5899, 4312, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5901, 4323, 14), teleport = Position(5900, 4312, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5900, 4323, 14), teleport = Position(5900, 4312, 14), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(5891, 4300, 14),
		to = Position(5909, 4316, 14)
	},
	exit = Position(5897, 4323, 14),
	storage = Storage.Quest.Crandoria.NagasQuest.SihrazzTimer
}

local mikarahLever = Action()
function mikarahLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

mikarahLever:position({x = 5905, y = 4323, z = 14})
mikarahLever:register()