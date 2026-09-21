local tileWaterBufalo = MoveEvent()

function tileWaterBufalo.onStepIn(player, item, position, fromPosition)

	if player:getOutfit().lookMount ~= 526 then
		player:teleportTo(fromPosition)
		player:sendCancelMessage("O local parece muito profundo.")
		return false
	else
		return true
	end
end


tileWaterBufalo:aid(13095)
tileWaterBufalo:register()