local teleportConfig = {
    teleportId = 13030,
    creatureNames = {"King Zelos", "Doctor Marrow", "The Monster", "Scarlett Etzel", "Drume", "Grand Master Oberon", "Urmahlullu the Weakened", "Urmahlullu the Tamed", "Urmahlullu the Immaculate", "Wildness of Urmahlullu"}
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
    if not creature:isPlayer() then
        return true
    end

    if item:getPosition() == Position(5756, 4670, 6) then
        if hasCreatureInArea(Position(5756, 4670, 6), Position(5776, 4691, 6), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote Scarlett Etzel antes de passar pelo teleport.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(5726, 4679, 5))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getPosition() == Position(5264, 4496, 7) then
        if hasCreatureInArea(Position(5232, 4465, 7), Position(5274, 4505, 7), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote Drume antes de pegar o barco.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(5281, 4494, 7))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getPosition() == Position(4824, 4475, 9) then
        if hasCreatureInArea(Position(4823, 4474, 9), Position(4838, 4486, 9), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote Grand Master Oberon antes de acessar o teleport.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(4819, 4464, 9))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getPosition() == Position(5860, 4517, 8) then
        if hasCreatureInArea(Position(5856, 4500, 8), Position(5885, 4529, 8), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote Urmahlullu antes de acessar o teleport.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(4819, 4464, 9))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getPosition() == Position(5467, 4301, 12) then
        if hasCreatureInArea(Position(5451, 4291, 12), Position(5468, 4304, 12), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote o boss antes de acessar o teleport.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(5458, 4309, 12))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    elseif item:getPosition() == Position(5119, 5242, 15) then
        if hasCreatureInArea(Position(5117, 5231, 15), Position(5142, 5253, 15), teleportConfig.creatureNames) then
            creature:sendCancelMessage("Derrote King Zelos antes de acessar o teleport.")
            creature:teleportTo(fromPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        else
            creature:teleportTo(Position(5079, 5240, 15))
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end
end

teleportMovement:aid(13030)
teleportMovement:register()