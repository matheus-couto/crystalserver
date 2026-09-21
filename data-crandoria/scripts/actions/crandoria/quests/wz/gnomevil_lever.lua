local config = {
	boss = {
		name = "Gnomevil",
		position = Position(33117, 31959, 11)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33119, 31924, 11), teleport = Position(33119, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33118, 31924, 11), teleport = Position(33119, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33120, 31924, 11), teleport = Position(33119, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33118, 31925, 11), teleport = Position(33120, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33119, 31925, 11), teleport = Position(33120, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33120, 31925, 11), teleport = Position(33120, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33118, 31926, 11), teleport = Position(33121, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33119, 31926, 11), teleport = Position(33121, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33120, 31926, 11), teleport = Position(33121, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33118, 31927, 11), teleport = Position(33122, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33119, 31927, 11), teleport = Position(33122, 31947, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(33120, 31927, 11), teleport = Position(33122, 31947, 11), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33100, 31944, 11),
		to = Position(33130, 31971, 11)
	},
	exit = Position(33001, 31900, 9),
	storage = Storage.Quest.U9_60.BigfootsBurden.BossWarzone2
}

local gnomevilLever = Action()
function gnomevilLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

gnomevilLever:position({x = 33119, y = 31923, z = 11})
gnomevilLever:register()