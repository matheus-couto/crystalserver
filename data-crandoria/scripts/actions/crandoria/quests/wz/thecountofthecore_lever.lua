local config = {
	boss = {
		name = "The Count of the Core",
		position = Position(33683, 32334, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33680, 32312, 15), teleport = Position(33674, 32335, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33679, 32312, 15), teleport = Position(33674, 32335, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33681, 32312, 15), teleport = Position(33674, 32335, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33679, 32313, 15), teleport = Position(33673, 32334, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33680, 32313, 15), teleport = Position(33673, 32334, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33681, 32313, 15), teleport = Position(33673, 32334, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33679, 32314, 15), teleport = Position(33673, 32336, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33680, 32314, 15), teleport = Position(33673, 32336, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33681, 32314, 15), teleport = Position(33673, 32336, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33669, 32328, 15),
		to = Position(33693, 32341, 15)
	},
	exit = Position(33323, 32111, 15),
	storage = Storage.Quest.U11_50.DangerousDepths.Bosses.TheCountOfTheCore
}

local thecountofthecoreLever = Action()
function thecountofthecoreLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

thecountofthecoreLever:position({x = 33680, y = 32311, z = 15})
thecountofthecoreLever:register()