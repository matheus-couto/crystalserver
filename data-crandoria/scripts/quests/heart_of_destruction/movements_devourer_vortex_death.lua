local rewardPosition = Position(5443, 4792, 15)

local rewardVortex = MoveEvent()

function rewardVortex.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    player:teleportTo(rewardPosition)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated the World Devourer and can now claim your rewards.")

    return true
end

rewardVortex:type("stepin")
rewardVortex:aid(12000)
rewardVortex:register()