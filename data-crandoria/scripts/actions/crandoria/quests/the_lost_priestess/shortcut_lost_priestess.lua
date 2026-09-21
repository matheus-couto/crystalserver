local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12317 and player:getStorageValue(Storage.Quest.Crandoria.TheLostPriestess.Shortcut) == 1 then
            player:teleportTo(Position(5039, 4430, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(5528, 5619, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Esse teleport so pode ser usado por aqueles que foram dignos de conhecer a Lost Priestess.")
            return true
        end
    end

entrance:type("stepin")
entrance:aid(12317)
entrance:register()