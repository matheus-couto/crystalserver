local config = {
	boss = {
		name = "Srezz Yellow Eyes",
		position = Position(4627, 5265, 12)
	},
	requiredLevel = 250,
	timeToFightAgain = 7 * 24 * 60 * 60,
	timeToDefeatBoss = 60 * 60,
	playerPositions = {
		{pos = Position(4666, 5251, 12), teleport = Position(4620, 5266, 12), effect = CONST_ME_TELEPORT},
		{pos = Position(4665, 5251, 12), teleport = Position(4620, 5266, 12), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4617, 5259, 12),
		to = Position(4698, 5288, 12)
	},
	exit = Position(4657, 5253, 12),
	storage = Storage.Quest.Crandoria.Viridia.WarmasterOutfits.ArenaTimer
}


local arenaLever = Action()
function arenaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	CreateDefaultLeverBoss(player, config)
	Game.createMonster("Tazhadur", Position(4640, 5265, 12))
	Game.createMonster("Mozradek", Position(4653, 5265, 12))
	Game.createMonster("Tirecz", Position(4666, 5265, 12))
	Game.createMonster("Thawing Dragon Lord", Position(4679, 5265, 12))
	Game.createMonster("The Ravager", Position(4692, 5265, 12))
	Game.createMonster("Death Priest Shargon", Position(4627, 5279, 12))
	Game.createMonster("Unaz the Mean", Position(4640, 5279, 12))
	Game.createMonster("Bullwark", Position(4653, 5279, 12))
	Game.createMonster("The Lord of the Lice", Position(4666, 5279, 12))
	Game.createMonster("Professor Maxxen", Position(4679, 5279, 12))
	Game.createMonster("Ravenous Hunger", Position(4692, 5279, 12))


end

arenaLever:position({x = 4667, y = 5251, z = 12})
arenaLever:register()
