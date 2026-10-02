-- Look README.md for see the reserved action/unique numbers
-- This file is only for teleports items (miscellaneous) not for magic forcefields

TeleportItemAction = {
	-- Feyrist shrines entrance
	-- Path: data\scripts\actions\other\gems.lua
	[15001] = {
		itemId = false,
		itemPos = {
			{ x = 32194, y = 31418, z = 2 },
			{ x = 32194, y = 31419, z = 2 },
			{ x = 32195, y = 31418, z = 2 },
			{ x = 32195, y = 31419, z = 2 },
		},
	},
	[15002] = {
		itemId = false,
		itemPos = {
			{ x = 32910, y = 32338, z = 15 },
			{ x = 32910, y = 32339, z = 15 },
			{ x = 32911, y = 32338, z = 15 },
			{ x = 32911, y = 32339, z = 15 },
		},
	},
	[15003] = {
		itemId = false,
		itemPos = {
			{ x = 32973, y = 32225, z = 7 },
			{ x = 32973, y = 32226, z = 7 },
			{ x = 32974, y = 32225, z = 7 },
			{ x = 32974, y = 32226, z = 7 },
		},
	},
	[15004] = {
		itemId = false,
		itemPos = {
			{ x = 33060, y = 32713, z = 5 },
			{ x = 33060, y = 32714, z = 5 },
			{ x = 33061, y = 32713, z = 5 },
			{ x = 33061, y = 32714, z = 5 },
		},
	},
	-- Deeper fibula draw well
	-- Path: data\scripts\quests\deeper_fibula\action-draw_well.lua
	[15005] = {
		itemId = false,
		itemPos = {
			{ x = 32171, y = 32439, z = 7 },
			{ x = 32172, y = 32439, z = 7 },
		},
	},
	-- Forgotten Knowledge Quest - Teleports Thais
	[24873] = {
		itemId = 25047,
		itemPos = {
			{ x = 32325, y = 32087, z = 7 },
		},
	},
	[24874] = {
		itemId = 25051,
		itemPos = {
			{ x = 32328, y = 32087, z = 7 },
		},
	},
	[24875] = {
		itemId = 25049,
		itemPos = {
			{ x = 32331, y = 32087, z = 7 },
		},
	},
	[24876] = {
		itemId = 25053,
		itemPos = {
			{ x = 32334, y = 32087, z = 7 },
		},
	},
	[24877] = {
		itemId = 25057,
		itemPos = {
			{ x = 32337, y = 32087, z = 7 },
		},
	},
	[24878] = {
		itemId = 25055,
		itemPos = {
			{ x = 32340, y = 32087, z = 7 },
		},
	},
	[24879] = {
		itemId = 10840,
		itemPos = {
			{ x = 32332, y = 32094, z = 7 },
		},
	},
	[24880] = {
		itemId = 25048,
		itemPos = {
			{ x = 32805, y = 31657, z = 8 },
		},
	},
	[24881] = {
		itemId = 25052,
		itemPos = {
			{ x = 32786, y = 32818, z = 13 },
		},
	},
	[24882] = {
		itemId = 25050,
		itemPos = {
			{ x = 32637, y = 32255, z = 7 },
		},
	},
	[24883] = {
		itemId = 25054,
		itemPos = {
			{ x = 33341, y = 31167, z = 7 },
		},
	},
	[24884] = {
		itemId = 25058,
		itemPos = {
			{ x = 32205, y = 31036, z = 10 },
		},
	},
	[24885] = {
		itemId = 25056,
		itemPos = {
			{ x = 32780, y = 32684, z = 14 },
		},
	},
	[24886] = {
		itemId = 10842,
		itemPos = {
			{ x = 32906, y = 32846, z = 13 },
		},
	},
	[26668] = {
		itemId = 1949,
		itemPos = {
			{ x = 33396, y = 31129, z = 9 },
		},
	},
}

TeleportItemUnique = {
	[15001] = {
		itemId = 31673,
		itemPos = {x = 5685, y = 4678, z = 6},
		destination = {x = 5755, y = 4658, z = 7},
		effect = CONST_ME_TELEPORT
	},
	[15002] = {
		itemId = 4997,
		itemPos = {x = 5754, y = 4657, z = 7},
		destination = {x = 5684, y = 4677, z = 6},
		effect = CONST_ME_TELEPORT
	},
	[15003] = {
		itemId = 5679,
		itemPos = { x = 33918, y = 31471, z = 7 },
		destination = { x = 33916, y = 31466, z = 8 },
		effect = CONST_ME_TELEPORT,
	},
	-- CRANDORIA
	-- ROTTEN BLOOD QUEST
	[15004] = {
		itemId = 33017,
		itemPos = {x = 5938, y = 5020, z = 14},
		destination = {x = 5955, y = 5122, z = 13},
		effect = CONST_ME_TELEPORT
	},
	[15006] = {
		itemId = 33017,
		itemPos = {x = 5955, y = 5121, z = 13},
		destination = {x = 5938, y = 5022, z = 14},
		effect = CONST_ME_TELEPORT
	},
	[15007] = {
		itemId = 33017,
		itemPos = {x = 5939, y = 5051, z = 14},
		destination = {x = 5811, y = 5248, z = 13},
		effect = CONST_ME_TELEPORT
	},
	[15008] = {
		itemId = 33017,
		itemPos = {x = 5811, y = 5247, z = 13},
		destination = {x = 5939, y = 5050, z = 14},
		effect = CONST_ME_TELEPORT
	},
	[15009] = {
		itemId = 33017,
		itemPos = {x = 5966, y = 5020, z = 14},
		destination = {x = 5861, y = 5127, z = 13},
		effect = CONST_ME_TELEPORT
	},
	[15010] = {
		itemId = 33017,
		itemPos = {x = 5861, y = 5126, z = 13},
		destination = {x = 5966, y = 5021, z = 14},
		effect = CONST_ME_TELEPORT
	},
	[15011] = {
		itemId = 33017,
		itemPos = {x = 5963, y = 5052, z = 15},
		destination = {x = 5730, y = 5169, z = 14},
		effect = CONST_ME_TELEPORT
	},
	[15012] = {
		itemId = 33017,
		itemPos = {x = 5730, y = 5168, z = 14},
		destination = {x = 5963, y = 5051, z = 15},
		effect = CONST_ME_TELEPORT
	},
	[15013] = {
		itemId = 33017,
		itemPos = {x = 5904, y = 5314, z = 15},
		destination = {x = 5773, y = 5248, z = 15},
		effect = CONST_ME_TELEPORT
	},
	[15014] = {
		itemId = 33017,
		itemPos = {x = 5613, y = 5113, z = 15},
		destination = {x = 5773, y = 5282, z = 15},
		effect = CONST_ME_TELEPORT
	},
	[15015] = {
		itemId = 33017,
		itemPos = {x = 6018, y = 5164, z = 15},
		destination = {x = 5667, y = 5280, z = 15},
		effect = CONST_ME_TELEPORT
	},
	[15016] = {
		itemId = 33017,
		itemPos = {x = 5825, y = 5165, z = 15},
		destination = {x = 5668, y = 5248, z = 15},
		effect = CONST_ME_TELEPORT
	}
}
