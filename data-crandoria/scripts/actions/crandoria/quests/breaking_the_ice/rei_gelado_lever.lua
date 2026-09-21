local config = {
	boss = {
		name = "Frozen King",
		position = Position(5004, 5524, 12)
	},
	requiredLevel = 500,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5024, 5528, 12), teleport = Position(5004, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5023, 5528, 12), teleport = Position(5004, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5025, 5528, 12), teleport = Position(5004, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5024, 5529, 12), teleport = Position(5005, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5023, 5529, 12), teleport = Position(5005, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5025, 5529, 12), teleport = Position(5005, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5024, 5530, 12), teleport = Position(5003, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5023, 5530, 12), teleport = Position(5003, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5025, 5530, 12), teleport = Position(5003, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5024, 5531, 12), teleport = Position(5006, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5023, 5531, 12), teleport = Position(5006, 5531, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5025, 5531, 12), teleport = Position(5006, 5531, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(4997, 5520, 12),
		to = Position(5012, 5534, 12)
	},
	exit = Position(5026, 5526, 12),
	storage = Storage.Quest.Crandoria.BreakingTheIce.ReiGeladoTimer
}

local ReiGeladoLever = Action()
function ReiGeladoLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

ReiGeladoLever:position({x = 5024, y = 5527, z = 12})
ReiGeladoLever:register()