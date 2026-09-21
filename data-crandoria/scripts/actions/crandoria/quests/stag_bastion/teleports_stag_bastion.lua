local teleportStag = MoveEvent()

function teleportStag.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.StagBastion.TeleportCourtWarlock)

    if storage >= 2 then
        player:teleportTo(Position(5256, 5478, 7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        return true
    else
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
        return true
    end

end

teleportStag:aid(13217)
teleportStag:register()