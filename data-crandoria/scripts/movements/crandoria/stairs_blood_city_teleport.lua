local destination = {
    [12280] = Position(5971, 5371, 7), -- Escadas Blood Island
    [12281] = Position(6034, 5314, 6), -- Escadas Blood City
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]
    if teleportPosition and player:getSkull() == SKULL_NONE then
        player:setSkull(SKULL_WHITE)
        player:teleportTo(teleportPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to madness!")
        return true
    elseif teleportPosition and (player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK or player:getSkull() == SKULL_WHITE) then
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to madness!")
        return
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()

