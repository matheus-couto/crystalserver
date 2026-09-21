local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12250 then
        local storage1 = player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.DemonHelmetPass)
        local storage2 = player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.DemonOakPass)
        local storage3 = player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.InquisitionPass)
        local storage4 = player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.AnnihilatorPass)

        if storage1 == 1 and storage2 == 1 and storage3 == 1 and storage4 == 1 then
            player:teleportTo(Position(5178, 4646, 11))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(5180, 4634, 11))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This teleport is reserved for the true Demon Slayers.")
            return true
        end
    end
end

entrance:type("stepin")
entrance:aid(12250)
entrance:register()
