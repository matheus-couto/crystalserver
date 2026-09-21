local config = {
	boss = {
		name = "Gelidrazah the Frozen",
		position = Position(4374, 5006, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(4417, 5015, 15), teleport = Position(4391, 5005, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4416, 5015, 15), teleport = Position(4391, 5005, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4415, 5015, 15), teleport = Position(4391, 5005, 15), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4371, 4997, 15),
		to = Position(4395, 5015, 15)
	},
	exit = Position(4415, 5013, 15),
	storage = Storage.Quest.U11_02.TheFirstDragon.GelidrazahTimer
}

local kalyassaLever = Action()
function kalyassaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

kalyassaLever:position({x = 4417, y = 5015, z = 15})
kalyassaLever:register()