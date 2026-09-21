local config = {
	boss = {
		name = "Zarabastan",
		position = Position(4560, 5101, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4541, 5097, 14), teleport = Position(4553, 5101, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4540, 5097, 14), teleport = Position(4553, 5101, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4539, 5097, 14), teleport = Position(4553, 5101, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4538, 5097, 14), teleport = Position(4553, 5101, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4537, 5097, 14), teleport = Position(4553, 5101, 14), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4549, 5095, 14),
		to = Position(4564, 5107, 14)
	},
	exit = Position(4540, 5095, 14),
	storage = Storage.Quest.Crandoria.WarlocksConspiracy.ZarabastanTimer
}

local zarabastanLever = Action()
function zarabastanLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

zarabastanLever:position({x = 4542, y = 5097, z = 14})
zarabastanLever:register()