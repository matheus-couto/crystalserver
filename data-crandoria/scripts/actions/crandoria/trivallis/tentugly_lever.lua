local config = {
	boss = {
		name = "Tentugly's Head",
		position = Position(5940, 5517, 7)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5949, 5518, 7), teleport = Position(5945, 5516, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(5950, 5518, 7), teleport = Position(5945, 5516, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(5951, 5518, 7), teleport = Position(5945, 5516, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(5952, 5518, 7), teleport = Position(5945, 5516, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(5953, 5518, 7), teleport = Position(5945, 5516, 7), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(5927, 5507, 7),
		to = Position(5946, 5524, 7)
	},
	exit = Position(5950, 5515, 7),
	storage = Storage.Quest.U12_60.APiratesTail.TentuglyTimer,
}

local tentuglyLever = Action()
function tentuglyLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

tentuglyLever:position({x = 5948, y = 5518, z = 7})
tentuglyLever:register()