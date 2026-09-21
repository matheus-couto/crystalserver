local bookFalseGod = Action()
function bookFalseGod.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso)

    if storage == 6 then
        player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 7)
    end

    
end

bookFalseGod:id(11442)
bookFalseGod:register()