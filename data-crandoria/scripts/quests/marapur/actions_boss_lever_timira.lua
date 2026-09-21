local config = {
	boss = {
		name = "Timira The Many-Headed",
		position = Position(5653, 4258, 9)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5646, 4257, 8), teleport = Position(5646, 4260, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5645, 4257, 8), teleport = Position(5646, 4260, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5644, 4257, 8), teleport = Position(5646, 4260, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5643, 4257, 8), teleport = Position(5646, 4260, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5642, 4257, 8), teleport = Position(5646, 4260, 9), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5632, 4253, 9),
		to = Position(5663, 4269, 9)
	},
	exit = Position(5629, 4260, 9),
	storage = Storage.Quest.U12_90.WithinTheTides.TimiraTimer,
}

local timiraLever = Action()
function timiraLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

timiraLever:position({x = 5647, y = 4257, z = 8})
timiraLever:register()