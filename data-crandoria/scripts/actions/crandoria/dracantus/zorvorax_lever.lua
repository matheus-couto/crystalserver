local config = {
	boss = {
		name = "Zorvorax",
		position = Position(4488, 4919, 8)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(4496, 4903, 8), teleport = Position(4481, 4926, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4495, 4903, 8), teleport = Position(4481, 4926, 8), effect = CONST_ME_TELEPORT},
		{pos = Position(4494, 4903, 8), teleport = Position(4481, 4926, 8), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4476, 4915, 8),
		to = Position(4493, 4931, 8)
	},
	exit = Position(4493, 4903, 8),
	storage = Storage.Quest.U11_02.TheFirstDragon.ZorvoraxTimer
}

local kalyassaLever = Action()
function kalyassaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

kalyassaLever:position({x = 4497, y = 4903, z = 8})
kalyassaLever:register()