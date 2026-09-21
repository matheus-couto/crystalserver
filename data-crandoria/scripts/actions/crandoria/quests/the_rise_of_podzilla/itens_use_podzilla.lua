local itensPodzilla = Action()
function itensPodzilla.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)
    local pos = player:getPosition()

    if item:getPosition() == Position(6117, 4325, 9) then -- sala de power dew
        if storage >= 4 then
            if pos.x == 6118 then
                player:teleportTo(Position(6116, 4325, 9))
                pos:sendMagicEffect(CONST_ME_TELEPORT)
            elseif pos.x == 6116 then
                player:teleportTo(Position(6118, 4325, 9))
                pos:sendMagicEffect(CONST_ME_TELEPORT)
            end
        else
            return false
        end
    elseif item:getPosition() == Position(6069, 4316, 11) then -- laboratorio
        if storage == 6 then
            player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 7)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou documentos secretos de Doctor Marrow. Leve-os para Two Lips.")
            return false
        end
    end
    
end

itensPodzilla:aid(13220)
itensPodzilla:register()