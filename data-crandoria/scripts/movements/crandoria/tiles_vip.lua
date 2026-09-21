local destination = {
    [12300] = Position(fromPosition), -- retornar a posição
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]
    -- if teleportPosition and player:isVip() then
    if teleportPosition and player:getVipDays() > 0 then
        return true
	else
        player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Access granted for VIP players only.")
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()
