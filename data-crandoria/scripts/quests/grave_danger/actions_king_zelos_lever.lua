local config = {
	boss = {
		name = "King Zelos",
		position = Position(5129, 5241, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5171, 5242, 15), teleport = Position(5129, 5248, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5171, 5241, 15), teleport = Position(5129, 5248, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5171, 5240, 15), teleport = Position(5129, 5248, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5171, 5243, 15), teleport = Position(5129, 5248, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5171, 5244, 15), teleport = Position(5129, 5248, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5172, 5242, 15), teleport = Position(5129, 5249, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5172, 5241, 15), teleport = Position(5129, 5249, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5172, 5240, 15), teleport = Position(5129, 5249, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5172, 5243, 15), teleport = Position(5129, 5249, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5172, 5244, 15), teleport = Position(5129, 5249, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5117, 5231, 15),
		to = Position(5143, 5252, 15)
	},
	exit = Position(5177, 5242, 15),
	storage = Storage.Quest.U12_20.GraveDanger.Bosses.KingZelosTimer
}

local kingZelosLever = Action()
function kingZelosLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

kingZelosLever:position({x = 5170, y = 5242, z = 15})
kingZelosLever:register()