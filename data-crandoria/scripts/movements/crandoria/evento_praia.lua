local destination = {
    [12351] = Position(4998, 5095, 7), -- Asura Citadel
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]

    if teleportPosition then
        local checkPosition = Position(4998, 5095, 7)
        local playerAtCheckPosition = Tile(Position(4998, 5095, 7)):getTopCreature()

        if playerAtCheckPosition and playerAtCheckPosition:isPlayer() then
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Por favor, espere a sua vez.")
            return true
        else
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Pegue o item e jogue sobre uma backpack.")
            return true
        end
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()
