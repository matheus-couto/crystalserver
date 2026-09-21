local config = {
	boss = {
		name = "The False God",
		position = Position(5220, 4388, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5194, 4398, 15), teleport = Position(5220, 4393, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5194, 4399, 15), teleport = Position(5220, 4393, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5194, 4400, 15), teleport = Position(5220, 4393, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5194, 4401, 15), teleport = Position(5220, 4393, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5194, 4402, 15), teleport = Position(5220, 4393, 15), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(5212, 4380, 15),
		to = Position(5228, 4400, 15)
	},
	exit = Position(5192, 4400, 15),
	storage = Storage.Quest.Crandoria.TheFalseGod.TimerBoss
}

local falseGodLever = Action()
function falseGodLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

falseGodLever:position({x = 5194, y = 4397, z = 15})
falseGodLever:register()