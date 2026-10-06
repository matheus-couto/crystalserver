local config = {
	boss = {
		name = "Jaul",
		position = Position(5816, 4798, 11)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5846, 4790, 11), teleport = Position(5815, 4786, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5846, 4791, 11), teleport = Position(5815, 4786, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5846, 4792, 11), teleport = Position(5815, 4786, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5846, 4793, 11), teleport = Position(5815, 4786, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5846, 4794, 11), teleport = Position(5815, 4786, 11), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5798, 4782, 11),
		to = Position(5827, 4803, 11)
	},
	exit = Position(5844, 4792, 11),
	storage = Storage.Quest.Crandoria.Deeplings.JaulTimer
}

local jaulLever = Action()
function jaulLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

jaulLever:position({x = 5846, y = 4789, z = 11})
jaulLever:register()