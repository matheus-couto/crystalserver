local destination = {
    [12284] = Position(5000, 5000, 7), -- Sistema de manter skull
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]
    if teleportPosition then
        if player:getPosition() == Position(6141, 5389, 9) then
            if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.DeepUmbra) < 1 then
                player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.DeepUmbra, 1)
                player:getPosition():sendMagicEffect(CONST_ME_REDTELEPORT)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to Madness!")
                if player:getSkull() == SKULL_NONE then
                    player:setSkull(SKULL_WHITE)
                end
            else
                return true
            end
        elseif player:getPosition() == Position(6125, 5262, 7) or player:getPosition() == Position(6141, 5387, 8) then
            player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.DeepUmbra, 0)
            if player:getSkull() == SKULL_NONE then
                player:setSkull(SKULL_WHITE)
                player:getPosition():sendMagicEffect(CONST_ME_REDTELEPORT)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't fool the Blood God!")
            end
        else
            if player:getSkull() == SKULL_NONE then
                player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.DeepUmbra, 0)
                player:setSkull(SKULL_WHITE)
                player:getPosition():sendMagicEffect(CONST_ME_REDTELEPORT)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't fool the Blood God!")
            end
        end
        return true
    end
end

teleport:aid(12284)
teleport:register()
