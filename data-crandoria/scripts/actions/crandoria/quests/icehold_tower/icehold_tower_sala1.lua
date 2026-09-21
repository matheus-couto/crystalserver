local teleportConfig = {
    teleportId = 12319,
    teleportPosition = Position(5033, 5332, 6),
    destinationPosition = Position(5033, 5332, 6),
    creatureNames = {"Colerian the Barbarian", "Barbarian Bloodwalker"}
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
    if hasCreatureInArea(Position(5026, 5320, 7), Position(5040, 5333, 7), teleportConfig.creatureNames) then
        creature:sendCancelMessage("You need to kill all monsters in the area before you can go to the next floor.")
        creature:teleportTo(fromPosition)
        return false
    end

    creature:teleportTo(teleportConfig.destinationPosition)
    return true
end

teleportMovement:aid(teleportConfig.teleportId)
teleportMovement:register()
