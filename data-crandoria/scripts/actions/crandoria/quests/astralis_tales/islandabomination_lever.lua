local config = {
	boss = {
		name = "The Island Abomination",
		position = Position(4696, 4443, 7)
	},
	requiredLevel = 500,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 20 * 60,
	playerPositions = {
		{pos = Position(4746, 4481, 4), teleport = Position(4695, 4450, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4746, 4480, 4), teleport = Position(4695, 4450, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4746, 4482, 4), teleport = Position(4695, 4450, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4745, 4481, 4), teleport = Position(4696, 4450, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4745, 4480, 4), teleport = Position(4696, 4450, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4745, 4482, 4), teleport = Position(4696, 4450, 7), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4683, 4430, 7),
		to = Position(4709, 4455, 7)
	},
	exit = Position(4745, 4469, 6),
	storage = Storage.Quest.Crandoria.AstralisTales.AbominationTimer
}

local islandabominationLever = Action()
function islandabominationLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

islandabominationLever:position({x = 4747, y = 4481, z = 4})
islandabominationLever:register()