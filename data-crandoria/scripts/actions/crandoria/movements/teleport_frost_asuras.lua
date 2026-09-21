local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12255 then
        local storage1 = player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.RewardDoor)

        if storage1 > 0 then
            player:teleportTo(Position(4949, 5573, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(fromPosition))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Finish The Inquisition Quest to have access to the teleport.")
            return true
        end
    end
end

entrance:type("stepin")
entrance:aid(12255)
entrance:register()
