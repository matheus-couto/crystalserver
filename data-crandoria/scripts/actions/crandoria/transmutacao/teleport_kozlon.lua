local teleportKozlon = MoveEvent()

function teleportKozlon.onStepIn(creature, item, position, fromPosition)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso)

    if storage >= 11 then
        player:teleportTo(Position(4793, 5210, 8))
        return true
    else
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Obtenha a permissao de Kozlon antes de acessar o teleport."
        )
        player:teleportTo(fromPosition)
        return true
    end
end

teleportKozlon:aid(13205)
teleportKozlon:register()