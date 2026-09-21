local config = {
	boss = {
		name = "The Ancient Shell",
		position = Position(4779, 4555, 15)
	},
	requiredLevel = 800,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4796, 4560, 15), teleport = Position(4782, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4796, 4561, 15), teleport = Position(4782, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4796, 4562, 15), teleport = Position(4782, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4796, 4563, 15), teleport = Position(4782, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4795, 4560, 15), teleport = Position(4781, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4795, 4561, 15), teleport = Position(4781, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4795, 4562, 15), teleport = Position(4781, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4795, 4563, 15), teleport = Position(4781, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4797, 4560, 15), teleport = Position(4783, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4797, 4561, 15), teleport = Position(4783, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4797, 4562, 15), teleport = Position(4783, 4568, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4797, 4563, 15), teleport = Position(4783, 4568, 15), effect = CONST_ME_TELEPORT},


	},
	specPos = {
		from = Position(4763, 4548, 15),
		to = Position(4789, 4574, 15)
	},
	exit = Position(4772, 4627, 15),
	storage = Storage.Quest.Crandoria.AliceMcronald.AncientShellTimer}

local ancientShellLever = Action()
function ancientShellLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

ancientShellLever:position({x = 4796, y = 4559, z = 15})
ancientShellLever:register()