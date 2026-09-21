local config = {
	boss = {
		name = "Goshnar's Cruelty",
		position = Position(33710, 31667, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33678, 31667, 14), teleport = Position(33700, 31667, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33679, 31667, 14), teleport = Position(33700, 31667, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33680, 31667, 14), teleport = Position(33700, 31667, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33681, 31667, 14), teleport = Position(33700, 31667, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33682, 31667, 14), teleport = Position(33700, 31667, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33696, 31657, 14),
		to = Position(33721, 31678, 14)
	},
	exit = Position(33621, 31427, 10),
	storage = Storage.Quest.U12_40.SoulWar.GoshnarCrueltyTimer,
}

local goshnarscrueltyLever = Action()
function goshnarscrueltyLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

goshnarscrueltyLever:position({x = 33677, y = 31667, z = 14})
goshnarscrueltyLever:register()