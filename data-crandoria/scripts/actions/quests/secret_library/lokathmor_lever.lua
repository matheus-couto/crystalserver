local config = {
	boss = {
		name = "Lokathmor",
		position = Position(5408, 5357, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5378, 5417, 14), teleport = Position(5408, 5363, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5379, 5417, 14), teleport = Position(5408, 5363, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5380, 5417, 14), teleport = Position(5408, 5363, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5381, 5417, 14), teleport = Position(5408, 5363, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5382, 5417, 14), teleport = Position(5408, 5363, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5398, 5348, 14),
		to = Position(5418, 5366, 14)
	},
	exit = Position(5380, 5415, 14),
	storage = Storage.Quest.U11_80.TheSecretLibrary.LokathmorTimer
}

local lokathmorLever = Action()
function lokathmorLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

lokathmorLever:position({x = 5377, y = 5417, z = 14})
lokathmorLever:register()