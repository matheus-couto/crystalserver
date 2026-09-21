local teleportMines = MoveEvent()

function teleportMines.onStepIn(player, item, position, fromPosition)

	if item:getPosition() == Position(4568, 5110, 12) then
		player:teleportTo(Position(4565, 5109, 12))
		return true
	elseif item:getPosition() == Position(4566, 5110, 12) then
		player:teleportTo(Position(4568, 5112, 12))
		return true
	end
		
end

teleportMines:aid(13076)
teleportMines:register()