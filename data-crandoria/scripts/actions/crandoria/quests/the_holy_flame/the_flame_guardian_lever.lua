local config = {
	boss = {
		name = "The Flame Guardian",
		position = Position(5215, 5427, 11)
	},
	requiredLevel = 500,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5247, 5421, 11), teleport = Position(5215, 5436, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5247, 5422, 11), teleport = Position(5215, 5436, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5247, 5423, 11), teleport = Position(5215, 5436, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5247, 5424, 11), teleport = Position(5215, 5436, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5247, 5425, 11), teleport = Position(5215, 5436, 11), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5204, 5419, 11),
		to = Position(5224, 5439, 11)
	},
	exit = Position(5247, 5427, 11),
	storage = Storage.Quest.Crandoria.TheHolyFlame.TheFlameGuardianTimer
}

local flameGuardianLever = Action()
function flameGuardianLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config),
	Game.createMonster("Knight of the Holy Flame", Position(5211, 5424, 11)),
	Game.createMonster("Knight of the Holy Flame", Position(5218, 5424, 11))
end

flameGuardianLever:position({x = 5247, y = 5420, z = 11})
flameGuardianLever:register()