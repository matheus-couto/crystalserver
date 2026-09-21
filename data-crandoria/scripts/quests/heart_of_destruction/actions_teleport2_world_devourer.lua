local destination = {
	[14353] = Position(5479, 4769, 15), --Falcon
}

local teleportHeart2 = MoveEvent()

function teleportHeart2.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]

	if teleport then -- Remove storages from mini bosses
		player:teleportTo(Position(5479, 4769, 15))
		player:setStorageValue(14334, -1)
		player:setStorageValue(14335, -1)
		player:setStorageValue(14336, -1)
		player:unregisterEvent("DevourerStorage")
	end
end

teleportHeart2:aid(14353)
teleportHeart2:register()