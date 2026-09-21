local config = {
	boss = {
		name = "Deathstrike",
		position = Position(33107, 31964, 10)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33124, 31923, 10), teleport = Position(33102, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33124, 31922, 10), teleport = Position(33102, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33124, 31924, 10), teleport = Position(33102, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33123, 31922, 10), teleport = Position(33101, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33123, 31923, 10), teleport = Position(33101, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33123, 31924, 10), teleport = Position(33101, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33122, 31922, 10), teleport = Position(33100, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33122, 31923, 10), teleport = Position(33100, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33122, 31924, 10), teleport = Position(33100, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33121, 31922, 10), teleport = Position(33099, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33121, 31923, 10), teleport = Position(33099, 31952, 10), effect = CONST_ME_TELEPORT},
		{pos = Position(33121, 31924, 10), teleport = Position(33099, 31952, 10), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33088, 31944, 10),
		to = Position(33129, 31986, 10)
	},
	exit = Position(33001, 31900, 9),
	storage = Storage.Quest.U9_60.BigfootsBurden.BossWarzone1
}

local DeathstrikeLever = Action()
function DeathstrikeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

DeathstrikeLever:position({x = 33125, y = 31923, z = 10})
DeathstrikeLever:register()