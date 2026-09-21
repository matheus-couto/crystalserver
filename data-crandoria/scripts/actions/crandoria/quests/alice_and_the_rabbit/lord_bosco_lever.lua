local config = {
	boss = {
		name = "Lord Bosco",
		position = Position(4675, 4827, 15)
	},
	requiredLevel = 800,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4695, 4830, 15), teleport = Position(4678, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4695, 4831, 15), teleport = Position(4678, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4695, 4832, 15), teleport = Position(4678, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4695, 4833, 15), teleport = Position(4678, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4694, 4830, 15), teleport = Position(4677, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4694, 4831, 15), teleport = Position(4677, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4694, 4832, 15), teleport = Position(4677, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4694, 4833, 15), teleport = Position(4677, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4696, 4830, 15), teleport = Position(4679, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4696, 4831, 15), teleport = Position(4679, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4696, 4832, 15), teleport = Position(4679, 4838, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4696, 4833, 15), teleport = Position(4679, 4838, 15), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4666, 4823, 15),
		to = Position(4687, 4845, 15)
	},
	exit = Position(4707, 4822, 15),
	storage = Storage.Quest.Crandoria.AliceMcronald.LordBoscoTimer}

local boscoLever = Action()
function boscoLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

boscoLever:position({x = 4695, y = 4829, z = 15})
boscoLever:register()