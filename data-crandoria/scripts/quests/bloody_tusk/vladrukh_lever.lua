-- CARNDORIA NEW --

local config = {
	boss = {
		name = "Vladrukh",
		position = Position(4538, 4227, 13),
	},
	requiredLevel = 250,
	timeToFightAgain = 60 * 60 * 20,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{ pos = Position(4577, 4228, 13), teleport = Position(4538, 4233, 13) },
		{ pos = Position(4577, 4229, 13), teleport = Position(4538, 4233, 13) },
		{ pos = Position(4577, 4230, 13), teleport = Position(4538, 4233, 13) },
		{ pos = Position(4577, 4231, 13), teleport = Position(4538, 4233, 13) },
		{ pos = Position(4577, 4232, 13), teleport = Position(4538, 4233, 13) },
	},
	specPos = {
		from = Position(4525, 4214, 13),
		to = Position(4554, 4242, 13),
	},
	exit = Position(4575, 4231, 13),
	storage = Storage.Quest.U15_10.BloodyTusks.VladrukhTimer,
}

local leverVladrukh = Action()
function leverVladrukh.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	Game.setStorageValue("globalVladrukhPoisonTransform", 0)
	return CreateDefaultLeverBoss(player, config)
end
leverVladrukh:position({x = 4577, y = 4227, z = 13})
leverVladrukh:register()
