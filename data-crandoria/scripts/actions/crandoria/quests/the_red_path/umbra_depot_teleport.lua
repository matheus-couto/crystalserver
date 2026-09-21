local destination = {
    [12285] = Position(6058, 5312, 6), -- Entrada Depot Umbra

}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleportPosition = destination[item.actionid]
    if teleportPosition and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) >= 2 then
        player:teleportTo(teleportPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome back, master.")
        return true
    elseif teleportPosition and player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) < 2 then
        player:teleportTo(Position(6056, 5310, 6))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the most worthy Followers can access this place!")
        return true
    end
end

teleport:type("stepin")

for index, value in pairs(destination) do
    teleport:aid(index)
end

teleport:register()

