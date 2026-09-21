local config = {
	boss = {
		name = "Goriath",
		position = Position(6094, 4614, 7)
	},
	requiredLevel = 600,
	timeToFightAgain = 3 * 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(6110, 4613, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6110, 4614, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6111, 4613, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6111, 4614, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6112, 4613, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6112, 4614, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6109, 4613, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6109, 4614, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6108, 4613, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(6108, 4614, 8), teleport = Position(6083, 4607, 7), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(6081, 4604, 7),
		to = Position(6098, 4618, 7)
	},
	exit = Position(6111, 4616, 8),
	storage = Storage.Quest.Crandoria.TheCanyonChallenge.GoriathTimer
}

local GoriathLever = Action()
function GoriathLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

GoriathLever:position({x = 6110, y = 4612, z = 8})
GoriathLever:register()