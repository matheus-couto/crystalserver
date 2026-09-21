local config = {
	boss = {
		name = "Ancient Wyrm",
		-- name = "Wyrm",
		position = Position(4168, 4905, 0)
	},
	requiredLevel = 50,
	timeToFightAgain = 23 * 60 * 60,
	timeToDefeatBoss = 30 * 60,
	playerPositions = {
		{pos = Position(4167, 5153, 7), teleport = Position(4168, 5144, 6), effect = CONST_ME_TELEPORT},
		{pos = Position(4167, 5154, 7), teleport = Position(4168, 5144, 6), effect = CONST_ME_TELEPORT},
		{pos = Position(4167, 5155, 7), teleport = Position(4168, 5144, 6), effect = CONST_ME_TELEPORT},
		{pos = Position(4167, 5156, 7), teleport = Position(4168, 5144, 6), effect = CONST_ME_TELEPORT},

	},
	specPos = {
		from = Position(4157, 5140, 6),
		to = Position(4182, 5148, 6)
	},
	exit = Position(4167, 5157, 7),
	storage = Storage.Quest.Crandoria.TheClimb.MainTimer,
}

local climbLever = Action()
function climbLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local stonePosition = {x = 4167, y = 5153, z = 7}
	local tile = Tile(stonePosition)
	local topCreature = tile:getTopCreature()


	if CreateDefaultLeverBoss(player, config) then
		Game.createItem(1841, 1, stonePosition)
		addEvent(function()
			Tile(stonePosition):getItemById(1841):remove()
		end, 15 * 60 * 1000)

	end

end

climbLever:position({x = 4167, y = 5152, z = 7})
climbLever:register()
