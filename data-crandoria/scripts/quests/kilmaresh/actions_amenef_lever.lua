-- CRANDORIA NEW --

local config = {
	boss = {
		name = "Amenef The Burning",
		position = Position(5163, 4501, 12)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(5133, 4516, 12), teleport = Position(5156, 4501, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5134, 4516, 12), teleport = Position(5156, 4501, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5135, 4516, 12), teleport = Position(5156, 4501, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5136, 4516, 12), teleport = Position(5156, 4501, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5137, 4516, 12), teleport = Position(5156, 4501, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5153, 4495, 12),
		to = Position(5168, 4509, 12)
	},
	exit = Position(5131, 4491, 12),
	storage = Storage.Kilmaresh.AmenefTimer
}

local AmenefLever = Action()
function AmenefLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

AmenefLever:position({x = 5132, y = 4516, z = 12})
AmenefLever:register()