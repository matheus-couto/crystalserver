local config = {
	boss = {
		name = "The Baron From Below",
		position = Position(33648, 32302, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33670, 32302, 15), teleport = Position(33648, 32309, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33669, 32302, 15), teleport = Position(33648, 32309, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33671, 32302, 15), teleport = Position(33648, 32309, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33669, 32303, 15), teleport = Position(33647, 32310, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33670, 32303, 15), teleport = Position(33647, 32310, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33671, 32303, 15), teleport = Position(33647, 32310, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33669, 32304, 15), teleport = Position(33649, 32310, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33670, 32304, 15), teleport = Position(33649, 32310, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33671, 32304, 15), teleport = Position(33649, 32310, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33637, 32293, 15),
		to = Position(33660, 32315, 15)
	},
	exit = Position(33460, 32268, 15),
	storage = Storage.Quest.U11_50.DangerousDepths.Bosses.TheBaronFromBelow
}

local thebaronfrombelowLever = Action()
function thebaronfrombelowLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

thebaronfrombelowLever:position({x = 33670, y = 32301, z = 15})
thebaronfrombelowLever:register()