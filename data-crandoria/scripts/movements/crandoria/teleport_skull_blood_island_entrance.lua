local destination = {
    [12278] = Position(5971, 5371, 7), -- Entrada Blood Island
    [12279] = Position(6047, 5314, 5), -- Entrada Blood City
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]
    if teleportPosition then
        player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
        if  player:getSkull() == SKULL_NONE or player:getSkull() == SKULL_WHITE then
            player:setSkull(SKULL_WHITE)
            player:teleportTo(teleportPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to madness!")
            player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
            return true
        elseif player:getSkull() == SKULL_RED then
            player:teleportTo(teleportPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to madness!")
            player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
            return true
        elseif player:getSkull() == SKULL_BLACK then
            player:teleportTo(teleportPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to madness!")
            player:setStorageValue(Storage.Quest.Crandoria.PvpStatus.Status, 1)
            return true
        end
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()

