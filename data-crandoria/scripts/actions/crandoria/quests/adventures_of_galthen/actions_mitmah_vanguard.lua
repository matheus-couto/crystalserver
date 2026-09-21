-- CRANDORIA EDIT --

local config = {
	boss = {
		name = "Mitmah Vanguard",
		position = Position(5705, 5380, 15),
	},
	timeAfterKill = 60,
	playerPositions = {
		{ pos = Position(5685, 5403, 15), teleport = Position(5705, 5388, 15) },
		{ pos = Position(5686, 5403, 15), teleport = Position(5705, 5388, 15) },
		{ pos = Position(5687, 5403, 15), teleport = Position(5705, 5388, 15) },
		{ pos = Position(5688, 5403, 15), teleport = Position(5705, 5388, 15) },
		{ pos = Position(5689, 5403, 15), teleport = Position(5705, 5388, 15) },
	},
	specPos = {
		from = Position(5686, 5366, 15),
		to = Position(5722, 5393, 15),
	},
	exit = Position(5690, 5406, 15),
}

local lever = BossLever(config)
lever:position(Position(5684, 5403, 15))
lever:register()
