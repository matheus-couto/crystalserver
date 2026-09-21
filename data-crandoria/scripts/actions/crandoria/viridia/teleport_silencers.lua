local teleportSilencers = MoveEvent()


function teleportSilencers.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
    if not player then
        return true
    end

	player:teleportTo(Position(4432, 5597, 8))
	return false


end

teleportSilencers:aid(13086)
teleportSilencers:register()