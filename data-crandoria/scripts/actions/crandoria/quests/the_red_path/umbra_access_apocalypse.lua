local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) >= 6 then
        player:teleportTo(teleportPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bem vindo, mestre!")
        return true
    else
        player:teleportTo(Position(6069, 5314, 4))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao se mostrou digno de acessar este local.")
        return true
    end
end

teleport:aid(12286)
teleport:register()

