local config = {
	boss = {
		name = "Ahau",
		position = Position(5492, 5148, 15)
	},
	requiredLevel = 80,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5521, 5165, 15), teleport = Position(5492, 5154, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5520, 5165, 15), teleport = Position(5492, 5154, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5519, 5165, 15), teleport = Position(5492, 5154, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5518, 5165, 15), teleport = Position(5492, 5154, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5517, 5165, 15), teleport = Position(5492, 5154, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5482, 5142, 15),
		to = Position(5504, 5158, 15)
	},
	exit = Position(5518, 5175, 15),
	storage = Storage.Quest.Crandoria.AdventuresOfGalthen.AhauTimer
}

local ahauLever = Action()
function ahauLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return CreateDefaultLeverBoss(player, config)
end

ahauLever:position({x = 5522, y = 5165, z = 15})
ahauLever:register()
