-- CARNDORIA NEW --

local config = {
	boss = {
		name = "Myzareth's Soulcage",
		position = Position(4557, 5006, 9),
	},
	requiredLevel = 800,
	timeToFightAgain = 60 * 60 * 20,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{ pos = Position(4575, 4971, 9), teleport = Position(4562, 5018, 9) },
		{ pos = Position(4575, 4972, 9), teleport = Position(4562, 5018, 9) },
		{ pos = Position(4575, 4973, 9), teleport = Position(4562, 5018, 9) },
		{ pos = Position(4575, 4974, 9), teleport = Position(4562, 5018, 9) },
		{ pos = Position(4575, 4975, 9), teleport = Position(4562, 5018, 9) },
	},
	specPos = {
		from = Position(4542, 5001, 9),
		to = Position(4572, 5038, 9),
	},
	exit = Position(4575, 4980, 9),
	storage = Storage.Quest.Crandoria.RoostOfTheGraveborn.BoneOverlordTimer,
	monsters = {
		{ name = "Zharvorin's Soulcage", pos = Position(4566, 5006, 9) },
		{ name = "Elyrax's Soulcage", pos = Position(4566, 5015, 9) },
		{ name = "Zharvorin's Soulcage", pos = Position(4557, 5015, 9) },
	}
}

local leverBoneOverlord = Action()
function leverBoneOverlord.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end
leverBoneOverlord:position({x = 4575, y = 4970, z = 9})
leverBoneOverlord:register()
