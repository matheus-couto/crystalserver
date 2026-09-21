local boatDorian = MoveEvent()

function boatDorian.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.PiratesQuest.Progresso)

    if storage >= 4 then
        player:teleportTo(Position(5941, 5555, 7))
        return true
    else
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
        return true
    end

end

boatDorian:aid(13189)
boatDorian:register()