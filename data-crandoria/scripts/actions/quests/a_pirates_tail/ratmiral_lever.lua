local config = {
	boss = {
		name = "Ratmiral Blackwhiskers",
		position = Position(4990, 4358, 14),
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{ pos = Position(4976, 4395, 15), teleport = Position(4982, 4360, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(4977, 4395, 15), teleport = Position(4982, 4360, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(4978, 4395, 15), teleport = Position(4982, 4360, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(4979, 4395, 15), teleport = Position(4982, 4360, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(4980, 4395, 15), teleport = Position(4982, 4360, 14), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(4980, 4351, 14),
		to = Position(4997, 4365, 14),
	},
	exit = Position(4976, 4392, 15),
	storage = Storage.Quest.U12_60.APiratesTail.RatmiralTimer
}

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end
lever:position(Position(4975, 4395, 15))
lever:register()
