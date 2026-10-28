local config = {
	boss = {
		name = "Orc",
		position = Position(5110, 4895, 11)
	},
	requiredLevel = 150,
	timeToFightAgain = 30 * 60,
	timeToDefeatBoss = 25 * 60,
	playerPositions = {
		{pos = Position(5124, 4873, 11), teleport = Position(5121, 4871, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5125, 4873, 11), teleport = Position(5121, 4872, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5126, 4873, 11), teleport = Position(5121, 4873, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5124, 4874, 11), teleport = Position(5121, 4874, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5125, 4874, 11), teleport = Position(5121, 4875, 11), effect = CONST_ME_TELEPORT},
		{pos = Position(5126, 4874, 11), teleport = Position(5121, 4876, 11), effect = CONST_ME_TELEPORT},
	},
	specPos = {
		from = Position(5096, 4861, 11),
		to = Position(5122, 4897, 11)
	},
	exit = Position(5026, 5526, 12),
	storage = Storage.Quest.Crandoria.ArenaEspecial.Cooldown
}

local arenaEspecialLever = Action()
function arenaEspecialLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

arenaEspecialLever:position({x = 5123, y = 4872, z = 11})
arenaEspecialLever:register()