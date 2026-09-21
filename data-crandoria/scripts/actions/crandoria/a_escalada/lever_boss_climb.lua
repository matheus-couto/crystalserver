local config = {
	boss = {
		name = "Ancient Wyrm",
		position = Position(4168, 4905, 0)
	},
	requiredLevel = 50,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(4169, 4920, 1), teleport = Position(4168, 4916, 0), effect = CONST_ME_TELEPORT},
		{pos = Position(4169, 4921, 1), teleport = Position(4168, 4916, 0), effect = CONST_ME_TELEPORT},
		{pos = Position(4169, 4922, 1), teleport = Position(4168, 4916, 0), effect = CONST_ME_TELEPORT},
		{pos = Position(4169, 4923, 1), teleport = Position(4168, 4916, 0), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4160, 4901, 0),
		to = Position(4176, 4917, 0)
	},
	exit = Position(4167, 4919, 1),
	storage = Storage.Quest.Crandoria.TheClimb.AncientTimer,
}

local climbLever = Action()
function climbLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

climbLever:position({x = 4169, y = 4919, z = 1})
climbLever:register()
