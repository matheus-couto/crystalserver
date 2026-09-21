local config = {
	boss = {
		name = "The Scourge of Oblivion",
		position = Position(5313, 5413, 13)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(5263, 5421, 13), teleport = Position(5306, 5424, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5264, 5421, 13), teleport = Position(5305, 5425, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5263, 5422, 13), teleport = Position(5306, 5424, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5264, 5422, 13), teleport = Position(5305, 5425, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5263, 5423, 13), teleport = Position(5306, 5424, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5264, 5423, 13), teleport = Position(5305, 5425, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5263, 5420, 13), teleport = Position(5306, 5424, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5264, 5420, 13), teleport = Position(5305, 5425, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5263, 5419, 13), teleport = Position(5306, 5424, 13), effect = CONST_ME_TELEPORT},
		{pos = Position(5264, 5419, 13), teleport = Position(5305, 5425, 13), effect = CONST_ME_TELEPORT}
	},
	specPos = {
		from = Position(5298, 5400, 13),
		to = Position(5326, 5427, 13)
	},
	exit = Position(5266, 5421, 13),
	storage = Storage.Quest.U11_80.TheSecretLibrary.ScourgeOfOblivionTimer
}

local scourgeOfOblivionLever = Action()
function scourgeOfOblivionLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

scourgeOfOblivionLever:position({x = 5262, y = 5421, z = 13})
scourgeOfOblivionLever:register()