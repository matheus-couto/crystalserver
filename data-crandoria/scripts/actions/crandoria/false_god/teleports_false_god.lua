local teleportConfig = {
    teleportId = 13173,
    teleportPosition = Position(4773, 4495, 15),
    destinationPosition = Position(4777, 4495, 15),
    creatureNames = {"Minotaur Idol"}
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

local teleportsFalseGod = MoveEvent()

function teleportsFalseGod.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item:getPosition() == Position(4730, 4494, 15) then
        if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) >= 6 then
            player:teleportTo(Position(4730, 4491, 15))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui permissao para passar pela barreira.")
            player:teleportTo(fromPosition)
        end
    elseif item:getPosition() == Position(4749, 4499, 15) then
        if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) >= 7 then
            player:teleportTo(destinationPosition)
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda nao provou seu valor.")
            player:teleportTo(fromPosition)
            return true
        end
    elseif item:getPosition() == teleportPosition then
        if hasCreatureInArea(Position(4751, 4492, 15), Position(4773, 4499, 15),teleportConfig.creatureNames) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Derrote todos os monstros para passar.")
            player:teleportTo(fromPosition)
        else
            player:teleportTo(destinationPosition)
            if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 6 then
                player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 7)
            end
            return true
        end
    elseif item:getPosition() == Position(5177, 4480, 14) then
        if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) >= 9 then
            player:teleportTo(Position(5202, 4477, 14))
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso proibido pelo guardiao The Draccoon.")
            player:teleportTo(fromPosition)
            return true
        end
    end

    return true
end

teleportsFalseGod:aid(13173)
teleportsFalseGod:register()