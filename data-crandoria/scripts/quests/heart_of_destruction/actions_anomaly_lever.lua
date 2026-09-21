local config = {
	boss = {
		name = "Anomaly",
		position = Position(5465, 4819, 15)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5438, 4815, 15), teleport = Position(5455, 4818, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5438, 4816, 15), teleport = Position(5455, 4818, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5438, 4817, 15), teleport = Position(5455, 4818, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5438, 4818, 15), teleport = Position(5455, 4818, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5438, 4819, 15), teleport = Position(5455, 4818, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5453, 4808, 15),
		to = Position(5476, 4831, 15)
	},
	exit = Position(5466, 4772, 15),
	storage = Storage.Quest.U10_94.HeartOfDestruction.AnomalyTimer
}

local AnomalyLever = Action()
function AnomalyLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

AnomalyLever:position({x = 5438, y = 4814, z = 15})
AnomalyLever:register()