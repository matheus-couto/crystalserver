local config = {
	boss = {
		name = "Crazy Hat",
		position = Position(4675, 4827, 15)
	},
	requiredLevel = 800,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4552, 4625, 15), teleport = Position(4552, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4552, 4626, 15), teleport = Position(4552, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4552, 4627, 15), teleport = Position(4552, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4552, 4628, 15), teleport = Position(4552, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4551, 4625, 15), teleport = Position(4551, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4551, 4626, 15), teleport = Position(4551, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4551, 4627, 15), teleport = Position(4551, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4551, 4628, 15), teleport = Position(4551, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4553, 4625, 15), teleport = Position(4553, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4553, 4626, 15), teleport = Position(4553, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4553, 4627, 15), teleport = Position(4553, 4611, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4553, 4628, 15), teleport = Position(4553, 4611, 15), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4540, 4595, 15),
		to = Position(4565, 4615, 15)
	},
	exit = Position(4577, 4530, 15),
	storage = Storage.Quest.Crandoria.AliceMcronald.CrazyHatTimer}

local crazyHatLever = Action()
function crazyHatLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

crazyHatLever:position({x = 4552, y = 4624, z = 15})
crazyHatLever:register()