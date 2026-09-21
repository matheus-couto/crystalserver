local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getActionId() == 12258 then
        local storage1 = player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled)


        if storage1 > 0 then
            player:teleportTo(Position(5413, 4279, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(5405, 4278, 8))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This teleport is reserved for those who have killed The Monster.")
            return true
        end
    end
end

entrance:type("stepin")
entrance:aid(12258)
entrance:register()
