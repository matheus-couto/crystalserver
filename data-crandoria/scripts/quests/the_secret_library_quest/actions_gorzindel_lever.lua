local config = {
	boss = {
		name = "Gorzindel",
		position = Position(5344, 5386, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5404, 5417, 14), teleport = Position(5344, 5392, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 5417, 14), teleport = Position(5344, 5392, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5406, 5417, 14), teleport = Position(5344, 5392, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5407, 5417, 14), teleport = Position(5344, 5392, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5408, 5417, 14), teleport = Position(5344, 5392, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5335, 5378, 14),
		to = Position(5353, 5396, 14)
	},
	exit = Position(5406, 5414, 14),
	storage = Storage.Quest.U11_80.TheSecretLibrary.GorzindelTimer
}

local gorzindelLever = Action()
function gorzindelLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

gorzindelLever:position({x = 5403, y = 5417, z = 14})
gorzindelLever:register()