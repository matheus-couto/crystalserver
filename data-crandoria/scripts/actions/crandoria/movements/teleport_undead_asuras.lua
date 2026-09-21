local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12253 then
        local storage1 = player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.DemonOakPass)

        if storage1 > 0 then
            player:teleportTo(Position(5331, 5263, 10))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(5331, 5258, 10))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This teleport is reserved for the ones who defeated the Demon Oak.")
            return true
        end
    end
end

entrance:type("stepin")
entrance:aid(12253)
entrance:register()
