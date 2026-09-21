local config = {
	boss = {
		name = "Eradicator",
		position = Position(5447, 4846, 15)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5475, 4847, 15), teleport = Position(5458, 4845, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5475, 4848, 15), teleport = Position(5458, 4845, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5475, 4849, 15), teleport = Position(5458, 4845, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5475, 4850, 15), teleport = Position(5458, 4845, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5475, 4851, 15), teleport = Position(5458, 4845, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5440, 4836, 15),
		to = Position(5461, 4857, 15)
	},
	exit = Position(5481, 4757, 15),
	storage = Storage.Quest.U10_94.HeartOfDestruction.EradicatorTimer
}

local AnomalyLever = Action()
function AnomalyLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

AnomalyLever:position({x = 5475, y = 4846, z = 15})
AnomalyLever:register()