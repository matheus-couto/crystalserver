local config = {
	boss = {
		name = "Son of Horadron",
		position = Position(4589, 5671, 8)
	},
	requiredLevel = 250,
	timeToFightAgain = 3 * 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4561, 5669, 8), teleport = Position(4579, 5671, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4561, 5670, 8), teleport = Position(4579, 5671, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4561, 5671, 8), teleport = Position(4579, 5671, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4561, 5672, 8), teleport = Position(4579, 5671, 8), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4577, 5664, 8),
		to = Position(4593, 5678, 8)
	},
	exit = Position(4561, 5683, 8),
	storage = Storage.Quest.Crandoria.HoradronTimer
}

local sonofhoradronLever = Action()
function sonofhoradronLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

sonofhoradronLever:position({x = 4561, y = 5668, z = 8})
sonofhoradronLever:register()