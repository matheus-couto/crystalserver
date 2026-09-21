local config = {
	boss = {
		name = "The Brainstealer",
		position = Position(32498, 31123, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(32530, 31122, 15), teleport = Position(32498, 31130, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32531, 31122, 15), teleport = Position(32498, 31130, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32532, 31122, 15), teleport = Position(32498, 31130, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32533, 31122, 15), teleport = Position(32498, 31130, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32534, 31122, 15), teleport = Position(32498, 31130, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(32488, 31116, 15),
		to = Position(32508, 31134, 15)
	},
	exit = Position(32053, 31462, 15),
	storage = Storage.Quest.U12_70.TooHotToHandle.BrainstealerTimer,
}

local thebrainstealerLever = Action()
function thebrainstealerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

thebrainstealerLever:position({x = 32529, y = 31122, z = 15})
thebrainstealerLever:register()