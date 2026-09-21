-- CARNDORIA EDIT --

local config = {
	boss = {
		name = "Arbaziloth",
		position = Position(5060, 4242, 12),
	},
	timeToFightAgain = 60 * 60 * 20,
	playerPositions = {
		{ pos = Position(5068, 4273, 12), teleport = Position(5069, 4242, 12) },
		{ pos = Position(5068, 4274, 12), teleport = Position(5069, 4242, 12) },
		{ pos = Position(5068, 4275, 12), teleport = Position(5069, 4242, 12) },
		{ pos = Position(5068, 4276, 12), teleport = Position(5069, 4242, 12) },
		{ pos = Position(5068, 4277, 12), teleport = Position(5069, 4242, 12) },
	},
	specPos = {
		from = Position(5050, 4231, 12),
		to = Position(5076, 4253, 12),
	},
	exit = Position(5068, 4280, 12),
	monsters = {
		{ name = "The Forgemaster", pos = Position(5065, 4237, 12) },
	},
}

Game.setStorageValue("globalArbazilothHeal", 0)

local leverArbaziloth = BossLever(config)
leverArbaziloth:position(Position(5068, 4272, 12))
leverArbaziloth:register()
