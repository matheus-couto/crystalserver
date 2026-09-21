local config = {
	boss = {
		name = "Rupture",
		position = Position(5517, 4824, 15)
	},
	requiredLevel = 150,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5490, 4823, 15), teleport = Position(5508, 4827, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5490, 4824, 15), teleport = Position(5508, 4827, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5490, 4825, 15), teleport = Position(5508, 4827, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5490, 4826, 15), teleport = Position(5508, 4827, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5490, 4827, 15), teleport = Position(5508, 4827, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5507, 4816, 15),
		to = Position(5526, 4836, 15)
	},
	exit = Position(5488, 4766, 15),
	storage = Storage.Quest.U10_94.HeartOfDestruction.RuptureTimer
}

local RuptureLever = Action()
function RuptureLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

RuptureLever:position({x = 5490, y = 4822, z = 15})
RuptureLever:register()