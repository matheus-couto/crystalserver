local demonRoot = Action()
function demonRoot.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso)
    local level = player:getLevel()

    if level < 300 then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe o que fazer com isso.")
        return false
    else
        if storage < 1 then
            item:remove(1)
            player:setStorageValue(Storage.Quest.Crandoria.TheRiseOfPodzilla.Progresso, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce se sente um pouco estranho...")
            return false
        else
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja se alimentou de Demon Roots.")
            return false
        end
    end

end

demonRoot:id(48510)
demonRoot:register()