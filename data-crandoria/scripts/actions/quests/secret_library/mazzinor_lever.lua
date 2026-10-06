local config = {
	boss = {
		name = "Mazzinor",
		position = Position(5381, 5387, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5378, 5441, 14), teleport = Position(5381, 5394, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5379, 5441, 14), teleport = Position(5381, 5394, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5380, 5441, 14), teleport = Position(5381, 5394, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5381, 5441, 14), teleport = Position(5381, 5394, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5382, 5441, 14), teleport = Position(5381, 5394, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5371, 5380, 14),
		to = Position(5391, 5399, 14)
	},
	exit = Position(5380, 5438, 14),
	storage = Storage.Quest.U11_80.TheSecretLibrary.MazzinorTimer
}

local mazzinorLever = Action()
function mazzinorLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

mazzinorLever:position({x = 5377, y = 5441, z = 14})
mazzinorLever:register()