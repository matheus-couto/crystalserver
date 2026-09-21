local config = {
	boss = {
		name = "Count Vlarkorth",
		position = Position(5142, 5133, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5141, 5109, 15), teleport = Position(5142, 5140, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5142, 5109, 15), teleport = Position(5142, 5140, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5143, 5109, 15), teleport = Position(5142, 5140, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5144, 5109, 15), teleport = Position(5142, 5140, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5145, 5109, 15), teleport = Position(5142, 5140, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5131, 5123, 15),
		to = Position(5154, 5145, 15)
	},
	exit = Position(5142, 5105, 15),
	storage = Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorthTimer
}

local countVlarkorthLever = Action()
function countVlarkorthLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

countVlarkorthLever:position({x = 5140, y = 5109, z = 15})
countVlarkorthLever:register()