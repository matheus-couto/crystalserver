-- CRANDORIA EDIT NEW --

local config = {
	boss = {
		name = "Brain Head",
		position = Position(4931, 4889, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4933, 4871, 15), teleport = Position(4932, 4879, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4933, 4870, 15), teleport = Position(4932, 4879, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4933, 4869, 15), teleport = Position(4932, 4879, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4933, 4868, 15), teleport = Position(4932, 4879, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4933, 4867, 15), teleport = Position(4932, 4879, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4919, 4877, 15),
		to = Position(4945, 4900, 15)
	},
	exit = Position(4934, 4868, 15),
	storage = Storage.Quest.U12_30.FeasterOfSouls.BrainHeadTimer
}

local brainHeadLever = Action()
function brainHeadLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

brainHeadLever:position({x = 4933, y = 4872, z = 15})
brainHeadLever:register()