local config = {
	boss = {
		name = "Gaia",
		position = Position(5660, 4489, 14)
	},
	requiredLevel = 500,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5630, 4487, 14), teleport = Position(5660, 4479, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5631, 4487, 14), teleport = Position(5660, 4479, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5629, 4487, 14), teleport = Position(5660, 4479, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5630, 4488, 14), teleport = Position(5659, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5631, 4488, 14), teleport = Position(5659, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5629, 4488, 14), teleport = Position(5659, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5630, 4489, 14), teleport = Position(5660, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5631, 4489, 14), teleport = Position(5660, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5629, 4489, 14), teleport = Position(5660, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5630, 4490, 14), teleport = Position(5661, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5631, 4490, 14), teleport = Position(5661, 4478, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5629, 4490, 14), teleport = Position(5661, 4478, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5648, 4475, 14),
		to = Position(5673, 4496, 14)
	},
	exit = Position(5632, 4527, 14),
	storage = Storage.Quest.Crandoria.NaturalTroubles.GaiaTimer
}

local GaiaLever = Action()
function GaiaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

GaiaLever:position({x = 5630, y = 4486, z = 14})
GaiaLever:register()