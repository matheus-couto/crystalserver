local config = {
	boss = {
		name = "Earl Osam",
		position = Position(5174, 5134, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5202, 5140, 15), teleport = Position(5174, 5126, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5203, 5140, 15), teleport = Position(5174, 5126, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5204, 5140, 15), teleport = Position(5174, 5126, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5205, 5140, 15), teleport = Position(5174, 5126, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5206, 5140, 15), teleport = Position(5174, 5126, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5163, 5124, 15),
		to = Position(5186, 5145, 15)
	},
	exit = Position(5203, 5134, 15),
	storage = Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsamTimer
}

local earlOsamLever = Action()
function earlOsamLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

earlOsamLever:position({x = 5201, y = 5140, z = 15})
earlOsamLever:register()