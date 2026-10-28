guideBook = Action()

function guideBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then 
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.AdventurerGroupTimer)

    if storage > os.time() then
        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.AdventurerGroupTimer, 0)
        item:remove(1)
        fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce reiniciou o seu cooldown para enfrentar o Adventurer Group.")
        return true
    else
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item nao parece ser necessario no momento.")
        return true
    end
    return true
end

guideBook:id(52710)
guideBook:register()