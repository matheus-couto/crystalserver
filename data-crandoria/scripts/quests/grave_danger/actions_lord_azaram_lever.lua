local config = {
	boss = {
		name = "Lord Azaram",
		position = Position(5110, 5169, 15)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5108, 5189, 15), teleport = Position(5112, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5109, 5189, 15), teleport = Position(5112, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5110, 5189, 15), teleport = Position(5112, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5111, 5189, 15), teleport = Position(5112, 5161, 15), effect = CONST_ME_TELEPORT},
		{pos = Position(5112, 5189, 15), teleport = Position(5112, 5161, 15), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5100, 5158, 15),
		to = Position(5121, 5179, 15)
	},
	exit = Position(5109, 5195, 15),
	storage = Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaramTimer
}

local lordAzaramLever = Action()
function lordAzaramLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

lordAzaramLever:position({x = 5107, y = 5189, z = 15})
lordAzaramLever:register()