local config = {
	boss = {
		name = "Realityquake",
		position = Position(5493, 4880, 15)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5497, 4850, 15), teleport = Position(5486, 4880, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5497, 4851, 15), teleport = Position(5486, 4880, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5497, 4852, 15), teleport = Position(5486, 4880, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5497, 4853, 15), teleport = Position(5486, 4880, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5497, 4854, 15), teleport = Position(5486, 4880, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5482, 4869, 15),
		to = Position(5502, 4890, 15)
	},
	exit = Position(5498, 4856, 15),
	storage = Storage.Quest.U10_94.HeartOfDestruction.RealityquakeTimer
}

local QuakeLever = Action()
function QuakeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

QuakeLever:position({x = 5497, y = 4849, z = 15})
QuakeLever:register()