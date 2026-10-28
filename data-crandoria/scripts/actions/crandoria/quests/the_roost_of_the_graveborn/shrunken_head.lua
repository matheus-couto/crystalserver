local shrunkenHead = Action()

function shrunkenHead.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if not player then 
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.GravediggerTimer)

    if storage > os.time() then
        player:setStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.GravediggerTimer, 0)
        item:remove(1)
        fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce reiniciou o seu cooldown para enfrentar The Gravedigger.")
        return true
    else
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item nao parece ser necessario no momento.")
        return true
    end
    return true

end

shrunkenHead:id(52712)
shrunkenHead:register()

