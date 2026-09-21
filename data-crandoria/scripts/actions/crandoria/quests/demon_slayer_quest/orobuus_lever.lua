local config = {
	boss = {
		name = "Orobuus",
		position = Position(5160, 4649, 11)
	},
	requiredLevel = 150,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5178, 4652, 11), teleport = Position(5173, 4649, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5178, 4651, 11), teleport = Position(5173, 4649, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5178, 4650, 11), teleport = Position(5173, 4649, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5178, 4649, 11), teleport = Position(5173, 4649, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5178, 4648, 11), teleport = Position(5173, 4649, 11), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5158, 4643, 11),
		to = Position(5175, 4655, 11)
	},
	exit = Position(5178, 4646, 11),
	storage = Storage.Quest.Crandoria.DemonSlayer.OrobuusTimer
}

local OrobuusLever = Action()
function OrobuusLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

OrobuusLever:position({x = 5178, y = 4653, z = 11})
OrobuusLever:register()