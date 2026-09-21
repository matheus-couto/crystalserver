-- CRANDORIA EDIT --

local config = {
	boss = {
		name = "Sister Hetai",
		position = Position(5816, 4533, 9)
	},
	requiredLevel = 100,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5789, 4532, 9), teleport = Position(5813, 4527, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5790, 4532, 9), teleport = Position(5813, 4527, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5791, 4532, 9), teleport = Position(5813, 4527, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5792, 4532, 9), teleport = Position(5813, 4527, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(5793, 4532, 9), teleport = Position(5813, 4527, 9), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5810, 4529, 9),
		to = Position(5822, 4539, 9)
	},
	exit = Position(5730, 4537, 9),
	storage = Storage.Kilmaresh.SisterHetaiTimer
}

local sisterHetaiLever = Action()
function sisterHetaiLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return CreateDefaultLeverBoss(player, config)
end

sisterHetaiLever:position({x = 5788, y = 4532, z = 9})
sisterHetaiLever:register()