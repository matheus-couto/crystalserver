local config = {
	boss = {
		name = "Mikarah Sarcophagus",
		position = Position(4875, 5379, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4878, 5398, 14), teleport = Position(4875, 5385, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4877, 5398, 14), teleport = Position(4875, 5385, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4876, 5398, 14), teleport = Position(4875, 5385, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(4875, 5398, 14), teleport = Position(4875, 5385, 14), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4868, 5377, 14),
		to = Position(4881, 5389, 14)
	},
	exit = Position(4876, 5396, 14),
	storage = Storage.Quest.Crandoria.Viridia.MikarahTimer
}

local mikarahLever = Action()
function mikarahLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

mikarahLever:position({x = 4879, y = 5398, z = 14})
mikarahLever:register()