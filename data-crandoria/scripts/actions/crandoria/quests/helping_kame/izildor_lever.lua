local config = {
	boss = {
		name = "Monster Izildor",
		position = Position(5337, 4549, 9)
	},
	requiredLevel = 500,
	timeToFightAgain = 23 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5322, 4551, 9), teleport = Position(5337, 4561, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4552, 9), teleport = Position(5337, 4561, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4553, 9), teleport = Position(5337, 4561, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4554, 9), teleport = Position(5337, 4561, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5322, 4555, 9), teleport = Position(5337, 4561, 9), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(5329, 4546, 9),
		to = Position(5346, 4563, 9)
	},
	exit = Position(5320, 4553, 9),
	storage = Storage.Quest.Crandoria.OldKame.IzildorTimer,
}

local izildorLever = Action()
function izildorLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

izildorLever:position({x = 5322, y = 4550, z = 9})
izildorLever:register()