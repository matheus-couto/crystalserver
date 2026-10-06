-- CARNDORIA NEW --

local config = {
	boss = {
		name = "The First Dragon",
		position = Position(4557, 5016, 15),
	},
	requiredLevel = 400,
	timeToFightAgain = 60 * 60 * 20,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{ pos = Position(4535, 5018, 15), teleport = Position(4557, 5024, 15) },
		{ pos = Position(4535, 5019, 15), teleport = Position(4557, 5024, 15) },
		{ pos = Position(4535, 5020, 15), teleport = Position(4557, 5024, 15) },
		{ pos = Position(4535, 5021, 15), teleport = Position(4557, 5024, 15) },
		{ pos = Position(4535, 5022, 15), teleport = Position(4557, 5024, 15) },
	},
	specPos = {
		from = Position(4548, 5009, 15),
		to = Position(4567, 5028, 15),
	},
	exit = Position(4535, 5025, 15),
	storage = Storage.Quest.U11_02.TheFirstDragon.FirstDragonTimer,
}

local leverVladrukh = Action()
function leverVladrukh.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end
leverVladrukh:position({x = 4535, y = 5017, z = 15})
leverVladrukh:register()
