local teleportConfig = {
    teleportPosition = Position(4435, 5369, 11),
    destinationPosition = Position(4435, 5362, 11),
    creatureNames = {"Vexclaw"}
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
    if hasCreatureInArea(Position(4431, 5368, 11), Position(4440, 5377, 11), teleportConfig.creatureNames) then
        creature:sendCancelMessage("You need to kill all monsters in the area before using the teleport.")
        creature:teleportTo(fromPosition)
        return false
    end

    creature:teleportTo(teleportConfig.destinationPosition)
    if creature:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 31 then
        creature:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 32)
    end
    return true
end

teleportMovement:aid(13072)
teleportMovement:register()
