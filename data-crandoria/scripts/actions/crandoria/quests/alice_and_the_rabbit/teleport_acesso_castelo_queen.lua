local teleportConfig = {
    teleportId = 12387,
    destinationPosition = Position(4462, 4596, 14),
    creatureNames = {"Spades Guard", "Clubs Guard"}
}

local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
    for x = fromPosition.x, toPosition.x do
        for y = fromPosition.y, toPosition.y do
            local pos = Position(x, y, fromPosition.z)
            local tile = Tile(pos)
            if tile then
                local creature = tile:getTopCreature()
                if creature and table.contains(creatureNames, creature:getName()) then
                    return true
                end
            end
        end
    end
    return false
end

local teleportMovement = MoveEvent()

function teleportMovement.onStepIn(creature, item, position, fromPosition)
    if hasCreatureInArea(Position(4450, 4592, 15), Position(4485, 4608, 15), teleportConfig.creatureNames) then
        creature:sendCancelMessage("Derrote todos os guardas para ganhar acesso ao castelo.")
        creature:teleportTo(fromPosition)
        return false
    end

    creature:teleportTo(teleportConfig.destinationPosition)
    return true
end

teleportMovement:aid(teleportConfig.teleportId)
teleportMovement:register()