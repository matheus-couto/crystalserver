local config = {
	boss = {
		name = "Doctor Marrow",
		position = Position(5459, 4297, 12)
	},
	requiredLevel = 250,
	timeToFightAgain = 24 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5434, 4290, 12), teleport = Position(5453, 4293, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5433, 4290, 12), teleport = Position(5453, 4293, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5432, 4290, 12), teleport = Position(5453, 4293, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5431, 4290, 12), teleport = Position(5453, 4293, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5430, 4290, 12), teleport = Position(5453, 4293, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5449, 4289, 12),
		to = Position(5470, 4306, 12)
	},
	exit = Position(5421, 4290, 12),
	storage = Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterTimer
}

local doctorMarrowLever = Action()
function doctorMarrowLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return CreateDefaultLeverBoss(player, config)
end

doctorMarrowLever:position({x = 5435, y = 4290, z = 12})
doctorMarrowLever:register()
