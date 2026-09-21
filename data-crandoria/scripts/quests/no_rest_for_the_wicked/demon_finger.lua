local demonFinger = Action()

function demonFinger.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local storage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Questlog)

    if storage == 4 then
        if target.itemid == 5732 and target:getPosition() == Position(5164, 4305, 8) and player:getPosition().y == 4306 then
            local chance = math.random(1, 8)
            item:remove(1)
            if chance == 1 then
                player:teleportTo(Position(5164, 4304, 8))
                toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu a porta da cela. Fale com Ortelio e fujam daqui.")
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O dedo de demonio se partiu.")
                toPosition:sendMagicEffect(CONST_ME_POFF)
                return true
            end
        end
    else
        toPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

end

demonFinger:id(49908)
demonFinger:register()