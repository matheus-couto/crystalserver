local teleportsPodzilla = MoveEvent()

function teleportsPodzilla.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)

    if item:getPosition() == Position(6054, 4367, 7) then -- entrada -1
        player:teleportTo(Position(6051, 4343, 8))
        player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
        return true
    elseif item:getPosition() == Position(6050, 4342, 8) then -- saida -1 > superficie
        player:teleportTo(Position(6055, 4366, 7))
        player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
        return true

    elseif item:getPosition() == Position(6073, 4400, 8) then -- entrada raizes flor
        if storage >= 2 then
            player:teleportTo(Position(6083, 4409, 8))
            player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(6082, 4410, 8) then -- saida raizes flor
        if storage >= 2 then
            player:teleportTo(Position(6072, 4401, 8))
            player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(6119, 4374, 9) then -- atalho -2 entrada
        if storage >= 5 then
            player:teleportTo(Position(6116, 4374, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(6117, 4373, 9) then -- atalho -2 saida
        if storage >= 5 then
            player:teleportTo(Position(6119, 4375, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(6080, 4326, 11) then -- alavanca boss
        if storage >= 8 then
            player:teleportTo(Position(6189, 4464, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    end

end

teleportsPodzilla:aid(13219)
teleportsPodzilla:register()