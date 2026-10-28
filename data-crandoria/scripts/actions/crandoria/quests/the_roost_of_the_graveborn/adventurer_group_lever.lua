local config = {
	boss = {
		name = "Fatal Bug",
		position = Position(4455, 4978, 9)
	},
	requiredLevel = 450,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4453, 4930, 9), teleport = Position(4457, 4953, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4453, 4931, 9), teleport = Position(4457, 4953, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4453, 4932, 9), teleport = Position(4457, 4953, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4453, 4933, 9), teleport = Position(4457, 4953, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4453, 4934, 9), teleport = Position(4457, 4953, 9), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4444, 4948, 9),
		to = Position(4468, 4981, 9)
	},
	exit = Position(4455, 4933, 9),
	storage = Storage.Quest.Crandoria.RoostOfTheGraveborn.AdventurerGroupTimer,
	monsters = {
		{ name = "Fiona Firstdream", pos = Position(4454, 4955, 9) },
		{ name = "Grendel Greenlunch", pos = Position(4452, 4959, 9) },
		{ name = "Nigel Neverguess", pos = Position(4463, 4957, 9) },
		{ name = "Percy Peacetinker", pos = Position(4460, 4962, 9) },
		{ name = "Yorik Youngbook", pos = Position(4453, 4963, 9) },
		{ name = "Bright Crystal", pos = Position(4451, 4963, 9) },
		{ name = "Bright Crystal", pos = Position(4451, 4956, 9) },
		{ name = "Bright Crystal", pos = Position(4461, 4957, 9) },
	},
}

local adventurerLever = Action()
function adventurerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

adventurerLever:position({x = 4453, y = 4929, z = 9})
adventurerLever:register()