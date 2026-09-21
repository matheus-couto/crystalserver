local config = {
	boss = {
		name = "Outburst",
		position = Position(5434, 4762, 15)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5405, 4761, 15), teleport = Position(5424, 4760, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 4762, 15), teleport = Position(5424, 4760, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 4763, 15), teleport = Position(5424, 4760, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 4764, 15), teleport = Position(5424, 4760, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 4765, 15), teleport = Position(5424, 4760, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5421, 4751, 15),
		to = Position(5444, 4773, 15)
	},
	exit = Position(5459, 4757, 15),
	storage = Storage.Quest.U10_94.HeartOfDestruction.OutburstTimer
}

local OutburstLever = Action()
function OutburstLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

OutburstLever:position({x = 5405, y = 4760, z = 15})
OutburstLever:register()