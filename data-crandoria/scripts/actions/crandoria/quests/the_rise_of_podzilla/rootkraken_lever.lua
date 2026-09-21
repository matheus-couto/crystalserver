local config = {
	boss = {
		name = "The Rootkraken Immortal",
		position = Position(6204, 4388, 8),
	},
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{ pos = Position(6192, 4463, 8), teleport = Position(6209, 4396, 8), effect = CONST_ME_TELEPORT },
		{ pos = Position(6192, 4464, 8), teleport = Position(6209, 4396, 8), effect = CONST_ME_TELEPORT },
		{ pos = Position(6192, 4465, 8), teleport = Position(6209, 4396, 8), effect = CONST_ME_TELEPORT },
		{ pos = Position(6192, 4466, 8), teleport = Position(6209, 4396, 8), effect = CONST_ME_TELEPORT },
		{ pos = Position(6192, 4467, 8), teleport = Position(6209, 4396, 8), effect = CONST_ME_TELEPORT },

	},
	specPos = {
		from = Position(6190, 4379, 8),
		to = Position(6190, 4379, 8),
	},
	exit = Position(6190, 4464, 8),
	storage = Storage.Quest.Crandoria.TheRiseOfPodzilla.RootkrakenTimer,
	monsters = {
		{ name = "Power Generator", pos = Position(6203, 4382, 8) },
		{ name = "Doctor Marrow Podzilla", pos = Position(6201, 4385, 8) },
	},
}

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end 
lever:position({x = 6192, y = 4462, z = 8})
lever:register()