local config = {
	boss = {
		name = "The Vermin Queen",
		position = Position(4467, 4810, 15)
	},
	requiredLevel = 800,
	timeToFightAgain = 24 * 60 * 59,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(4484, 4803, 15), teleport = Position(4467, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4484, 4804, 15), teleport = Position(4467, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4484, 4805, 15), teleport = Position(4467, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4484, 4806, 15), teleport = Position(4467, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4483, 4803, 15), teleport = Position(4466, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4483, 4804, 15), teleport = Position(4466, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4483, 4805, 15), teleport = Position(4466, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4483, 4806, 15), teleport = Position(4466, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4485, 4803, 15), teleport = Position(4468, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4486, 4804, 15), teleport = Position(4468, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4487, 4805, 15), teleport = Position(4468, 4814, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(4488, 4806, 15), teleport = Position(4468, 4814, 15), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4459, 4808, 15),
		to = Position(4476, 4821, 15)
	},
	exit = Position(4481, 4805, 15),
	storage = Storage.Quest.Crandoria.AliceMcronald.VerminQueenTimer}

local verminLever = Action()
function verminLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

verminLever:position({x = 4484, y = 4802, z = 15})
verminLever:register()