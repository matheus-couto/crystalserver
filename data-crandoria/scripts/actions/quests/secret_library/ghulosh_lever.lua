local config = {
	boss = {
		name = "Ghulosh",
		position = Position(5413, 5388, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5404, 5441, 14), teleport = Position(5413, 5395, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5405, 5441, 14), teleport = Position(5413, 5395, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5406, 5441, 14), teleport = Position(5413, 5395, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5407, 5441, 14), teleport = Position(5413, 5395, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(5408, 5441, 14), teleport = Position(5413, 5395, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5403, 5379, 14),
		to = Position(5423, 5399, 14)
	},
	exit = Position(5406, 5438, 14),
	storage = Storage.Quest.U11_80.TheSecretLibrary.GhuloshTimer
}

local ghuloshLever = Action()
function ghuloshLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

ghuloshLever:position({x = 5403, y = 5441, z = 14})
ghuloshLever:register()