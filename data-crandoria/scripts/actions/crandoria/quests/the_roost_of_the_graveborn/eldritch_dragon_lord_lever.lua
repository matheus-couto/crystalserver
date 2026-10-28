local config = {
	boss = {
		name = "Eldritch Dragon Lord",
		position = Position(4487, 5002, 9)
	},
	requiredLevel = 450,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4519, 4998, 9), teleport = Position(4494, 5005, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4519, 4999, 9), teleport = Position(4494, 5005, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4519, 5000, 9), teleport = Position(4494, 5005, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4519, 5001, 9), teleport = Position(4494, 5005, 9), effect = CONST_ME_TELEPORT},
		{pos = Position(4519, 5002, 9), teleport = Position(4494, 5005, 9), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4477, 4993, 9),
		to = Position(4500, 5012, 9)
	},
	exit = Position(4522, 5005, 9),
	storage = Storage.Quest.Crandoria.RoostOfTheGraveborn.EldritchDragonLordTimer,
	monsters = {
		{ name = "Pulsating Lava", pos = Position(4483, 4998, 9) },
		{ name = "Pulsating Lava", pos = Position(4492, 4998, 9) },
		{ name = "Pulsating Lava", pos = Position(4482, 5008, 9) },
		{ name = "Pulsating Lava", pos = Position(4492, 5007, 9) },
	},
}

local adventurerLever = Action()
function adventurerLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

adventurerLever:position({x = 4519, y = 4997, z = 9})
adventurerLever:register()