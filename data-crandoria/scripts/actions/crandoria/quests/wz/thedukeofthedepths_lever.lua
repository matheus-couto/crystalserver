local config = {
	boss = {
		name = "The Duke Of The Depths",
		position = Position(33708, 32302, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33689, 32299, 15), teleport = Position(33717, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33688, 32299, 15), teleport = Position(33717, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33690, 32299, 15), teleport = Position(33717, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33689, 32300, 15), teleport = Position(33718, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33688, 32300, 15), teleport = Position(33718, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33690, 32300, 15), teleport = Position(33718, 32300, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33689, 32301, 15), teleport = Position(33718, 32299, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33688, 32301, 15), teleport = Position(33718, 32299, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(33690, 32301, 15), teleport = Position(33718, 32299, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33701, 32293, 15),
		to = Position(33723, 32313, 15)
	},
	exit = Position(33275, 32318, 15),
	storage = Storage.Quest.U11_50.DangerousDepths.Bosses.TheDukeOfTheDepths
}

local thedukeofthedepthsLever = Action()
function thedukeofthedepthsLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

thedukeofthedepthsLever:position({x = 33689, y = 32298, z = 15})
thedukeofthedepthsLever:register()