local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end


    if item:getPosition() == Position(5480, 4803, 8) then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) >= 2 then
            player:teleportTo(Position(5476, 4840, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para acessar este local sagrado.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    elseif item:getPosition() == Position(5467, 4772, 12) then
	    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) > 2 then
            player:teleportTo(Position(5432, 4775, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(Position(5467, 4775, 12))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para acessar esse local.")
        end
    elseif item:getPosition() == Position(5467, 4779, 12) then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) > 2 then
            player:teleportTo(Position(5432, 4792, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(Position(5467, 4776, 12))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para acessar esse local.")
        end
    elseif item:getPosition() == Position(5457, 4776, 12) then
        if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.TrueSecret) > 8 then
            player:teleportTo(Position(5412, 4783, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(Position(fromPosition))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para acessar esse local.")
        end
    end
    
end


teleport:aid(13009)
teleport:register()