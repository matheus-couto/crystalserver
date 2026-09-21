local config = {
	boss = {
		name = "Tamru the Black",
		position = Position(4790, 4332, 1)
	},
	requiredLevel = 100,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 10 * 60,
	playerPositions = {
		{pos = Position(4807, 4321, 10), teleport = Position(4782, 4335, 1), effect = CONST_ME_TELEPORT},
		{pos = Position(4807, 4322, 10), teleport = Position(4782, 4335, 1), effect = CONST_ME_TELEPORT},
		{pos = Position(4807, 4323, 10), teleport = Position(4782, 4335, 1), effect = CONST_ME_TELEPORT},
		{pos = Position(4807, 4324, 10), teleport = Position(4782, 4335, 1), effect = CONST_ME_TELEPORT},
		{pos = Position(4807, 4325, 10), teleport = Position(4782, 4335, 1), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4779, 4328, 1),
		to = Position(4797, 4338, 1)
	},
	exit = Position(4784, 4341, 2),
	storage = Storage.Grimvale.TamruTimer
}

local tamruLever = Action()
function tamruLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

tamruLever:position({x = 4807, y = 4320, z = 10})
tamruLever:register()