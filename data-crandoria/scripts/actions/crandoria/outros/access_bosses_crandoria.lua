local AccessBoss = MoveEvent()

function AccessBoss.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storageScarlett = player:getStorageValue(Storage.AccessBoss.ScarlettAccess)
    local storageDrume = player:getStorageValue(Storage.AccessBoss.DrumeAccess)
    local storageOberon = player:getStorageValue(Storage.AccessBoss.OberonAccess)

    if item:getPosition() == Position(5760, 4699, 6) then
        if storageScarlett >= 2 then
            player:teleportTo(Position(5760, 4697, 6))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(5274, 4467, 6) then
        if storageDrume >= 2 then
            player:teleportTo(Position(5277, 4469, 6))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    elseif item:getPosition() == Position(4764, 4450, 9) then
        if storageOberon >= 2 then
            player:teleportTo(Position(4830, 4502, 9))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
            return true
        end
    end

end

AccessBoss:aid(13218)
AccessBoss:register()