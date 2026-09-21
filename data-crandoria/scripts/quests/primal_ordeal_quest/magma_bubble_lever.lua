local config = {
	boss = {
		name = "Magma Bubble",
		position = Position(5780, 4855, 15)
	},
	requiredLevel = 500,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5796, 4874, 15), teleport = Position(5782, 4866, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5796, 4875, 15), teleport = Position(5782, 4866, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5796, 4876, 15), teleport = Position(5782, 4866, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5796, 4877, 15), teleport = Position(5782, 4866, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5796, 4878, 15), teleport = Position(5782, 4866, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5765, 4845, 15),
		to = Position(5791, 4868, 15)
	},
	exit = Position(5788, 4844, 14),
	storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleTimer
}

local MagmaBubbleLever = Action()
function MagmaBubbleLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

MagmaBubbleLever:position({x = 5796, y = 4873, z = 15})
MagmaBubbleLever:register()
