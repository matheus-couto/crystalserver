local config = {
	boss = {
		name = "The Godfather",
		position = Position(5311, 4874, 14)
	},
	requiredLevel = 500,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5322, 4920, 14), teleport = Position(5310, 4889, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5321, 4920, 14), teleport = Position(5310, 4889, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5323, 4920, 14), teleport = Position(5310, 4889, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4921, 14), teleport = Position(5310, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5321, 4921, 14), teleport = Position(5310, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5323, 4921, 14), teleport = Position(5310, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5321, 4922, 14), teleport = Position(5309, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4922, 14), teleport = Position(5309, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5323, 4922, 14), teleport = Position(5309, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5321, 4923, 14), teleport = Position(5311, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4923, 14), teleport = Position(5311, 4890, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5323, 4923, 14), teleport = Position(5311, 4890, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5297, 4867, 14),
		to = Position(5326, 4897, 14)
	},
	exit = Position(5420, 4933, 14),
	storage = Storage.Quest.Crandoria.TheGodfather.GodfatherTimer
}

local doctorMarrowLever = Action()
function doctorMarrowLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return CreateDefaultLeverBoss(player, config)
end

doctorMarrowLever:position({x = 5322, y = 4919, z = 14})
doctorMarrowLever:register()
