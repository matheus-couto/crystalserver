local config = {
	boss = {
		name = "Abyssador",
		position = Position(33088, 31910, 12)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33104, 31879, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33103, 31879, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33105, 31879, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33103, 31880, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33104, 31880, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33105, 31880, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33103, 31881, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33104, 31881, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33105, 31881, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33103, 31882, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33104, 31882, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(33105, 31882, 12), teleport = Position(33085, 31901, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33075, 31896, 12),
		to = Position(33102, 31925, 12)
	},
	exit = Position(33001, 31900, 9),
	storage = Storage.Quest.U9_60.BigfootsBurden.BossWarzone3
}

local AbyssadorLever = Action()
function AbyssadorLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

AbyssadorLever:position({x = 33104, y = 31878, z = 12})
AbyssadorLever:register()