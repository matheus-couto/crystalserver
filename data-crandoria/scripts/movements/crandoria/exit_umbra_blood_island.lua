local destination = {
    [12282] = Position(5972, 5366, 6), -- Saída da ilha de Umbra
    [12283] = Position(6045, 5312, 5), -- Entrada na cidade de Umbra
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]

    -- if teleportPosition and (player:getSkull() == SKULL_RED or player:getSkull() == SKULL_BLACK or player:getSkull() == SKULL_WHITE) then
    if teleportPosition then
        if player:isPzLocked() or player:getSkull() == SKULL_WHITE then
            player:teleportTo(teleportPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Se livre de suas impurezas de batalha antes de passar")
            return true
        elseif player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and player:getSkull() == SKULL_RED then
            player:teleportTo(teleportPosition)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Se livre de suas impurezas de batalha antes de passar")
            return true
        else
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce esta livre para passar")
            return true
        end
        return true
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()

