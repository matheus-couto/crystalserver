local config = {
	boss = {
		name = "Tazhadur",
		position = Position(4459, 5043, 7)
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 15 * 60,
	playerPositions = {
		{pos = Position(4509, 5045, 7), teleport = Position(4460, 5054, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4510, 5045, 7), teleport = Position(4460, 5054, 7), effect = CONST_ME_TELEPORT},
		{pos = Position(4511, 5045, 7), teleport = Position(4460, 5054, 7), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(4452, 5040, 7),
		to = Position(4472, 5059, 7)
	},
	exit = Position(4510, 5043, 7),
	storage = Storage.Quest.U11_02.TheFirstDragon.TazhadurTimer
}

local tazhadurLever = Action()
function tazhadurLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

tazhadurLever:position({x = 4508, y = 5045, z = 7})
tazhadurLever:register()