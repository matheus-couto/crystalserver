local boatAstralis = MoveEvent()

function boatAstralis.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points) >= 175 then
        player:teleportTo(Position(4769, 4610, 7))
        return true
    else
        player:teleportTo(Position(4741, 4556, 7))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas para jogadores com reputacao Nobre ou superior.")
        return true
    end

end

boatAstralis:aid(13197)
boatAstralis:register()