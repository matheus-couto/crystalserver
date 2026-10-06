local config = {
	boss = {
		name = "Obujos",
		position = Position(5809, 4930, 12)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5778, 4922, 12), teleport = Position(5794, 4923, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5778, 4923, 12), teleport = Position(5794, 4923, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5778, 4924, 12), teleport = Position(5794, 4923, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5778, 4925, 12), teleport = Position(5794, 4923, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5778, 4926, 12), teleport = Position(5794, 4923, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5788, 4921, 12),
		to = Position(5821, 4943, 12)
	},
	exit = Position(5780, 4923, 12),
	storage = Storage.Quest.Crandoria.Deeplings.ObujosTimer
}

local obujosLever = Action()
function obujosLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

obujosLever:position({x = 5778, y = 4921, z = 12})
obujosLever:register()