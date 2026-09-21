local teleportConfig = {
    teleportId = 12311,
    teleportPosition = Position(4934, 4518, 15),
    destinationPosition = Position(4934, 4518, 15),
    creatureNames = {"Demon", "Hellflayer", "Juggernaut"}
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
    if hasCreatureInArea(Position(4950, 4465, 15), Position(4960, 4476, 15), teleportConfig.creatureNames) then
        creature:sendCancelMessage("You need to kill all monsters in the area before using the teleport.")
        creature:teleportTo(fromPosition)
        return false
    end

    creature:teleportTo(teleportConfig.destinationPosition)
    return true
end

teleportMovement:aid(teleportConfig.teleportId)
teleportMovement:register()
