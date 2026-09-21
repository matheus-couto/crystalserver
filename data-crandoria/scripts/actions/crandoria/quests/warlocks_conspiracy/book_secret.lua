local bookWarlocks = Action()

function bookWarlocks.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	player:teleportTo(Position(4566, 5104, 15))
	return true
end

bookWarlocks:uid(12356)
bookWarlocks:register()