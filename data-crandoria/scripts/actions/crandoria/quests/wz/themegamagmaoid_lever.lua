local config = {
	boss = {
		name = "The Mega Magmaoid",
		position = Position(32500, 31154, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(32530, 31154, 15), teleport = Position(32500, 31162, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32531, 31154, 15), teleport = Position(32500, 31162, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32532, 31154, 15), teleport = Position(32500, 31162, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32533, 31154, 15), teleport = Position(32500, 31162, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(32534, 31154, 15), teleport = Position(32500, 31162, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(32489, 31146, 15),
		to = Position(32512, 31167, 15)
	},
	exit = Position(32069, 31490, 14),
	storage = Storage.Quest.U12_70.TooHotToHandle.MegaMagmaoidTimer,
}

local themegamagmaoidLeverLever = Action()
function themegamagmaoidLeverLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

themegamagmaoidLeverLever:position({x = 32529, y = 31154, z = 15})
themegamagmaoidLeverLever:register()