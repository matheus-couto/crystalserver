local firstDragonSpirit = Action()
function firstDragonSpirit.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if target.itemid == 25065 or target.itemid == 25066 then
        if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 9 then
            item:remove()
            player:addItem(44528, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o espirito do dragao. Leve o frasco para Drako na superficie.")
            player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso, 10)
            return true
        end
    end
end

firstDragonSpirit:id(44527)
firstDragonSpirit:register()