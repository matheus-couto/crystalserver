local teleportHeart3 = MoveEvent()

function teleportHeart3.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(14330) >= 1 and player:getStorageValue(14332) >= 1 then
		if player:canFightBoss("World Devourer") then
			player:teleportTo(Position(5576, 4863, 15))
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(19, "Esta muito cedo para desafiar o World Devourer novamente.")
		end
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(19, "Derrote Outburst e Eradicator antes de desafiar o World Devourer.")
	end
end

teleportHeart3:aid(14351)
teleportHeart3:register()