local config = {
	boss = {
		name = "The Queen of Hearts",
		position = Position(4461, 4578, 15)
	},
	requiredLevel = 800,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4461, 4577, 12), teleport = Position(4461, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4461, 4578, 12), teleport = Position(4461, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4461, 4579, 12), teleport = Position(4461, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4461, 4580, 12), teleport = Position(4461, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4461, 4581, 12), teleport = Position(4461, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4460, 4577, 12), teleport = Position(4460, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4460, 4578, 12), teleport = Position(4460, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4460, 4579, 12), teleport = Position(4460, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4460, 4580, 12), teleport = Position(4460, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4460, 4581, 12), teleport = Position(4460, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4462, 4577, 12), teleport = Position(4462, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4462, 4578, 12), teleport = Position(4462, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4462, 4579, 12), teleport = Position(4462, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4462, 4580, 12), teleport = Position(4462, 4587, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4462, 4581, 12), teleport = Position(4462, 4587, 15), effect = CONST_ME_TELEPORT},



	},
	specPos = {
		from = Position(4451, 4575, 15),
		to = Position(4472, 4592, 15)
	},
	exit = Position(4467, 4590, 14),
	storage = Storage.Quest.Crandoria.AliceMcronald.QueenOfHeartsTimer}

local queenofheartsLever = Action()
function queenofheartsLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

queenofheartsLever:position({x = 4461, y = 4576, z = 12})
queenofheartsLever:register()