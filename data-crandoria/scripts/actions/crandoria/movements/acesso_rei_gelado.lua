local destination = {
    [12296] = Position(5024, 5525, 12), -- Crandoria
}

local darkPlaces = {
    Position(5099, 5544, 12),
    Position(5090, 5551, 12),
    Position(5090, 5559, 12),
    Position(5084, 5553, 12),
    Position(5068, 5544, 12),
    Position(5068, 5537, 12),
    Position(5053, 5554, 12),
    Position(5035, 5554, 12),
    Position(5063, 5561, 12),
    Position(5059, 5564, 12),
    Position(5026, 5564, 12),
    Position(5019, 5554, 12),
    Position(5007, 5545, 12),
    Position(5002, 5552, 12),
    Position(5027, 5548, 12),
    Position(5038, 5539, 12),
    Position(5053, 5536, 12),
    Position(5003, 5576, 12),
    Position(4993, 5580, 12),
    Position(5057, 5572, 12),
    Position(5047, 5576, 12),
    Position(5040, 5574, 12),
    Position(5040, 5583, 12),
    Position(5036, 5593, 12),
    Position(5044, 5593, 12),
    Position(5049, 5587, 12),
    Position(5062, 5583, 12),
    Position(5076, 5587, 12),
    Position(5093, 5579, 12),
    Position(5081, 5581, 12),
    Position(5084, 5571, 12),
    Position(5074, 5567, 12)

}

local teleport = MoveEvent()

function isDarkPlace(position)
    local tile = Tile(position)
    local item2929 = tile and tile:getItemById(2929)
    local item2931 = tile and tile:getItemById(2931)
    return item2929 ~= nil or item2931 ~= nil
end

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportDest = destination[item.actionid]

    if teleportDest then
        local canTeleport = true

        for _, darkPlace in pairs(darkPlaces) do
            if not isDarkPlace(darkPlace) then
                canTeleport = false
                break
            end
        end

        if canTeleport then
            player:teleportTo(teleportDest)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "The place is still too dark for you to face the Frozen King.")
        end

        return true
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()
