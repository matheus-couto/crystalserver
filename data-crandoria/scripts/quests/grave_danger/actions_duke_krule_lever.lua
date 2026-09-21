local config = {
	boss = {
		name = "Duke Krule",
		position = Position(5142, 5169, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5141, 5189, 15), teleport = Position(5143, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5142, 5189, 15), teleport = Position(5143, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5143, 5189, 15), teleport = Position(5143, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5144, 5189, 15), teleport = Position(5143, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5145, 5189, 15), teleport = Position(5143, 5161, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5130, 5157, 15),
		to = Position(5155, 5180, 15)
	},
	exit = Position(5143, 5193, 15),
	storage = Storage.Quest.U12_20.GraveDanger.Bosses.DukeKruleTimer
}

local dukeKruleLever = Action()
function dukeKruleLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

dukeKruleLever:position({x = 5140, y = 5189, z = 15})
dukeKruleLever:register()