local teleportConfig = {
    creatureNames = {"Goshnar's Cruelty", "Goshnar's Greed", "Goshnar's Hatred", "Goshnar's Malice", "Goshnar's Megalomania", "Goshnar's Spite", "Zavarash", "Prince Drazzak", "Gnomevil", "The Baron From Below", "Terofar", "The Brainstealer", "Morgaroth", "Orobuus", "Ferumbras Mortal Shell", "Gnomevil", "Jaul", "Obujos", "Tanjis", "Deathstrike", "Abyssador", "The Baron from Below", "The Count of the Core", "The Duke of the Depths", "Drume", "Grand Master Oberon", "Urmahlullu the Immaculate", "Faceless Bane", "Brokul", "The Unarmored Voidborn", "Eradicator", "Glooth Fairy", "The Duke Of The Depths", "Ayana the Crimson Curse", "Tamru the Black", "Ratmiral Blackwhiskers", "The Fear Feaster", "The Dread Maiden", "The Unwelcome", "Lord Azaram", "Duke Krule", "Magma Bubble"}
}

local accessedIPs = {}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local function hasPlayerInArea(fromPosition, toPosition)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    return true
                end
            end
        end
    end
    return false
end

local eventoTorres = MoveEvent()

function eventoTorres.onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer()

    if not player then
        return true
    end

    local playerIP = player:getIp()

    local storageTimer = player:getStorageValue(Storage.Quest.Crandoria.DuasTorres.CooldownTimes)
    local crandoria = player:getStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria)
    local umbra = player:getStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeUmbra)

    if item:getPosition() == Position(4902, 5181, 7) then
        if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
            player:teleportTo(Position(5000, 5000, 6))
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Apenas um jogador por IP.")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            if storageTimer < os.time() then
                player:teleportTo(Position(4902, 5185, 7))
                return true
            else
                if crandoria > 0 then
                    player:teleportTo(Position(4888, 5171, 7))
                    player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 2)
                    accessedIPs[playerIP] = player:getGuid()
                elseif umbra > 0 then
                    player:teleportTo(Position(4914, 5171, 7))
                    player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeUmbra, 2)
                    accessedIPs[playerIP] = player:getGuid()
                end
                accessedIPs[playerIP] = player:getGuid()
                return true
            end
        end
    elseif item:getPosition() == Position(4888, 5164, 7) then
        if hasCreatureInArea(Position(4883, 5163, 7), Position(4893, 5172, 7), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 6))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 2)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 6) then
        if hasCreatureInArea(Position(4883, 5163, 6), Position(4893, 5172, 6), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 5))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 3)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 5) then
        if hasCreatureInArea(Position(4883, 5163, 5), Position(4893, 5172, 5), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 4))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 4)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 4) then
        if hasCreatureInArea(Position(4883, 5163, 4), Position(4893, 5172, 4), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 3))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 5)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 3) then
        if hasCreatureInArea(Position(4883, 5163, 3), Position(4893, 5172, 3), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 2))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 6)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 2) then
        if hasCreatureInArea(Position(4883, 5163, 2), Position(4893, 5172, 2), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 1))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 7)
            return true
        end
    elseif item:getPosition() == Position(4888, 5164, 1) then
        if hasCreatureInArea(Position(4883, 5163, 1), Position(4893, 5172, 1), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4909, 5163, 0), Position(4920, 5173, 0)) then
                player:teleportTo(Position(4908, 5168, 0))
                return true
            end
            player:teleportTo(Position(4888, 5171, 0))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 8)
            return true
        end
        ---------------- UMBRA ----------------------
    elseif item:getPosition() == Position(4914, 5164, 7) then
        if hasCreatureInArea(Position(4909, 5163, 7), Position(4919, 5172, 7), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 6))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 2)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 6) then
        if hasCreatureInArea(Position(4909, 5163, 6), Position(4919, 5172, 6), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 5))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 3)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 5) then
        if hasCreatureInArea(Position(4909, 5163, 5), Position(4919, 5172, 5), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 4))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 4)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 4) then
        if hasCreatureInArea(Position(4909, 5163, 4), Position(4919, 5172, 4), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 3))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 5)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 3) then
        if hasCreatureInArea(Position(4909, 5163, 3), Position(4919, 5172, 3), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 2))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 6)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 2) then
        if hasCreatureInArea(Position(4909, 5163, 2), Position(4919, 5172, 2), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 1))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 7)
            return true
        end
    elseif item:getPosition() == Position(4914, 5164, 1) then
        if hasCreatureInArea(Position(4909, 5163, 1), Position(4919, 5172, 1), teleportConfig.creatureNames) then
            player:sendCancelMessage("Derrotem todos os monstros para passar pelo teleport.")
            player:teleportTo(fromPosition)
            return true
        else
            if hasPlayerInArea(Position(4883, 5163, 0), Position(4894, 5173, 0)) then
                player:teleportTo(Position(4894, 5168, 0))
                return true
            end
            player:teleportTo(Position(4914, 5171, 0))
            player:setStorageValue(Storage.Quest.Crandoria.DuasTorres.TimeCrandoria, 8)
            return true
        end
    end
    return true
end

eventoTorres:aid(13075)
eventoTorres:register()
