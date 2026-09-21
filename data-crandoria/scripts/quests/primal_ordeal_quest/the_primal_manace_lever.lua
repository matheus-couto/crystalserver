local config = {
	boss = {
		name = "The Primal Menace",
		position = Position(5684, 4706, 15)
	},
	requiredLevel = 500,
	timeToFightAgain = 20 * 60 * 60,
    timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5675, 4700, 14), teleport = Position(5693, 4706, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5676, 4700, 14), teleport = Position(5693, 4706, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5677, 4700, 14), teleport = Position(5693, 4706, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5678, 4700, 14), teleport = Position(5693, 4706, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5679, 4700, 14), teleport = Position(5693, 4706, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5672, 4697, 15),
		to = Position(5698, 4717, 15)
	},
	exit = Position(5682, 4699, 14),
	storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceTimer
}

local PrimalMenaceLever = Action()
function PrimalMenaceLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

PrimalMenaceLever:position({x = 5674, y = 4700, z = 14})
PrimalMenaceLever:register()
