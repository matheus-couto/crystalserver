local teleportsElvenshire = MoveEvent()

function teleportsElvenshire.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.Quest.Crandoria.HindraelQuest.Progresso) >= 4 then
        local previoustile = Tile(fromPosition)
        if item:getPosition() == Position(4697, 4752, 7) or item:getPosition() == Position(4698, 4752, 7) then
            if previoustile:getItemById(18461) or previoustile:getItemById(18463) or previoustile:getItemById(18460) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "1. Frost Dragons; 2. Hydras; 3. Roshamuul")
                return true
            end
        elseif item:getPosition() == Position(4697, 4749, 7) then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:teleportTo(Position(5018, 5539, 4))
            return true
        elseif item:getPosition() == Position(4699, 4748, 7) then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:teleportTo(Position(5309, 5115, 7))
            return true
        elseif item:getPosition() == Position(4701, 4749, 7) then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:teleportTo(Position(5883, 5071, 6))
            return true
        end
    end

end

teleportsElvenshire:aid(13168)
teleportsElvenshire:register()