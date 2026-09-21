local config = {
	boss = {
		name = "Pythius the Rotten",
		position = Position(4570, 5554, 11)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4538, 5560, 11), teleport = Position(4559, 5556, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(4538, 5561, 11), teleport = Position(4559, 5556, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(4538, 5562, 11), teleport = Position(4559, 5556, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(4538, 5563, 11), teleport = Position(4559, 5556, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(4538, 5564, 11), teleport = Position(4559, 5556, 11), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4552, 5548, 11),
		to = Position(4577, 5567, 11)
	},
	exit = Position(4531, 5542, 11),
	storage = Storage.Quest.Crandoria.Viridia.PythiusTimer
}

local pythiusLever = Action()
function pythiusLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

pythiusLever:position({x = 4538, y = 5559, z = 11})
pythiusLever:register()