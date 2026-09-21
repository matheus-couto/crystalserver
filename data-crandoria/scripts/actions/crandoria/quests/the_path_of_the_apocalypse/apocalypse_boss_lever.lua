local config = {
	boss = {
		name = "Apocalypse",
		position = Position(4937, 5234, 13)
	},
	requiredLevel = 500,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4889, 5233, 13), teleport = Position(4928, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4889, 5232, 13), teleport = Position(4928, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4889, 5234, 13), teleport = Position(4928, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4890, 5232, 13), teleport = Position(4928, 5235, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4890, 5233, 13), teleport = Position(4928, 5235, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4890, 5234, 13), teleport = Position(4928, 5235, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4891, 5232, 13), teleport = Position(4927, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4891, 5233, 13), teleport = Position(4927, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4891, 5234, 13), teleport = Position(4927, 5234, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4892, 5232, 13), teleport = Position(4927, 5235, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4892, 5233, 13), teleport = Position(4927, 5235, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(4892, 5234, 13), teleport = Position(4927, 5235, 13), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4917, 5220, 13),
		to = Position(4953, 5250, 13)
	},
	exit = Position(4897, 5236, 13),
	storage = Storage.Quest.Crandoria.PathToApocalypse.ApocalypseTimer
}

local thecountofthecoreLever = Action()
function thecountofthecoreLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

thecountofthecoreLever:position({x = 4888, y = 5233, z = 13})
thecountofthecoreLever:register()