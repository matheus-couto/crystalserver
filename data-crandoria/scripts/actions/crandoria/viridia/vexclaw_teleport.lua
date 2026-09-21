local vexclawTeleport = MoveEvent()


function vexclawTeleport.onStepIn(player, item, position, fromPosition)

	player:teleportTo(Position(4435, 5376, 11))
	return true

end


vexclawTeleport:aid(13109)
vexclawTeleport:register()