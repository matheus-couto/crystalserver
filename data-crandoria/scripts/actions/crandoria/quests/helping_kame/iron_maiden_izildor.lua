local ironMaiden = Action()
function ironMaiden.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item:getPosition() == Position(5249, 4583, 9) then
		player:teleportTo(Position(5260, 4564, 9))
		return true
	elseif item:getPosition() == Position(5260, 4563, 9) then
		player:teleportTo(Position(5250, 4583, 9))
		return true
	end
end

ironMaiden:aid(13058)
ironMaiden:register()