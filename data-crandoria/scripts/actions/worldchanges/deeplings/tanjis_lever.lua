local config = {
	boss = {
		name = "Tanjis",
		position = Position(5836, 4819, 12)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5851, 4839, 12), teleport = Position(5831, 4804, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5851, 4840, 12), teleport = Position(5831, 4804, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5851, 4841, 12), teleport = Position(5831, 4804, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5851, 4842, 12), teleport = Position(5831, 4804, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(5851, 4843, 12), teleport = Position(5831, 4804, 12), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5820, 4802, 12),
		to = Position(5847, 4829, 12)
	},
	exit = Position(5853, 4838, 12),
	storage = Storage.Quest.Crandoria.Deeplings.TanjisTimer
}

local tanjisLever = Action()
function tanjisLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

tanjisLever:position({x = 5851, y = 4838, z = 12})
tanjisLever:register()