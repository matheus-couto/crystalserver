local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12257 then
            player:teleportTo(Position(4891, 4918, 13))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
    end
end

entrance:type("stepin")
entrance:aid(12257)
entrance:register()