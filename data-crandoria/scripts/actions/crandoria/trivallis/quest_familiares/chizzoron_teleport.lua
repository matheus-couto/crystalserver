local teleportConfig = {
    teleportPosition = Position(5798, 5591, 10),
    destinationPosition = Position(5851, 5641, 10),
    creatureNames = {"Draken Elite", "Draken Abomination", "Draken Warmaster", "Lizard Chosen", "Draken Spellweaver"}
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
    if hasCreatureInArea(Position(5788, 5589, 10), Position(5808, 5604, 10), teleportConfig.creatureNames) then
        creature:sendCancelMessage("Ha guardioes vivos na sala.")
        creature:teleportTo(fromPosition)
        return false
    end

    creature:teleportTo(teleportConfig.destinationPosition)
    return true
end

teleportMovement:aid(13184)
teleportMovement:register()