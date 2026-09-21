local config = {
    [43772] = 0,
    [43773] = 1,
    [43774] = 2,
    [43775] = 3,
    [43776] = 4, -- Adicione o ID correto para o espelho 5
}

local storage = Storage.Grimvale.SequenceMirrors

local sequenceMirrors = Action()
function sequenceMirrors.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local targetValue = config[item.itemid]
    if not targetValue then
        player:setStorageValue(storage, 0)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You used the mirror in the wrong order. Start it again!")
        return true
    end

    local currentStorageValue = player:getStorageValue(storage)
    
    if currentStorageValue == targetValue then
        if targetValue == 4 then -- Se o espelho atual for o número 4
            player:setStorageValue(Storage.Grimvale.MoonDoor, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You activated the mirrors in correct order and got the access through the portal!")
        else
            player:setStorageValue(storage, currentStorageValue + 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Mirror activated!")
        end
    else
        player:setStorageValue(storage, 0)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You used the mirror in the wrong order. Start it again!")
    end
    return true
end

sequenceMirrors:aid(12256)
sequenceMirrors:register()
