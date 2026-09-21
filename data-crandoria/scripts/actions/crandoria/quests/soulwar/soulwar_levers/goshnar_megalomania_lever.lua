local config = {
	boss = {
		name = "Goshnars Megalomania Jar",
		position = Position(33710, 31634, 14)
	},
	requiredLevel = 250,
	timeToFightAgain = 40 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(33676, 31634, 14), teleport = Position(33702, 31634, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33677, 31634, 14), teleport = Position(33702, 31634, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33678, 31634, 14), teleport = Position(33702, 31634, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33679, 31634, 14), teleport = Position(33702, 31634, 14), effect = CONST_ME_TELEPORT},
		{pos = Position(33680, 31634, 14), teleport = Position(33702, 31634, 14), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(33698, 31623, 14),
		to = Position(33721, 31645, 14)
	},
	exit = Position(33621, 31427, 10),
	storage = Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaTimer,
}

local goshnarsmegalomaniaLever = Action()
function goshnarsmegalomaniaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

goshnarsmegalomaniaLever:position({x = 33675, y = 31634, z = 14})
goshnarsmegalomaniaLever:register()