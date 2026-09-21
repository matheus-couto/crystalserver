local config = {
	boss = {
		name = "Kalyassa",
		position = Position(4492, 5081, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(4487, 5007, 5), teleport = Position(4491, 5071, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4488, 5007, 5), teleport = Position(4491, 5071, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4489, 5007, 5), teleport = Position(4491, 5071, 15), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4483, 5068, 15),
		to = Position(4502, 5087, 15)
	},
	exit = Position(4488, 5008, 5),
	storage = Storage.Quest.U11_02.TheFirstDragon.KalyassaTimer
}

local kalyassaLever = Action()
function kalyassaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

kalyassaLever:position({x = 4486, y = 5007, z = 5})
kalyassaLever:register()