

local teleportList = {
    [1] = { teleportPos = Position(4974, 4707, 7), destination = Position(5534, 4809, 7) }, 
    [2] = { teleportPos = Position(4975, 4707, 7), destination = Position(5444, 4914, 7) },
    [3] = { teleportPos = Position(5444, 4911, 7), destination = Position(4975, 4708, 7) },
    [4] = { teleportPos = Position(5445, 4911, 7), destination = Position(4825, 5612, 7) },
    [5] = { teleportPos = Position(4825, 5611, 7), destination = Position(5445, 4912, 7) },
    [6] = { teleportPos = Position(4826, 5611, 7), destination = Position(6029, 5038, 7) },
    [7] = { teleportPos = Position(6029, 5037, 7), destination = Position(4826, 5612, 7) },
    [8] = { teleportPos = Position(6030, 5037, 7), destination = Position(5764, 4615, 7) },
    [9] = { teleportPos = Position(5764, 4614, 7), destination = Position(6030, 5038, 7) },
    [10] = { teleportPos = Position(5765, 4614, 7), destination = Position(5689, 4254, 7) },
    [11] = { teleportPos = Position(5689, 4253, 7), destination = Position(5765, 4615, 7) },
    [12] = { teleportPos = Position(5690, 4253, 7), destination = Position(5583, 5537, 7) },
    [13] = { teleportPos = Position(5583, 5536, 7), destination = Position(5690, 4254, 7) },
    [14] = { teleportPos = Position(5584, 5536, 7), destination = Position(5533, 4809, 7) },
    [15] = { teleportPos = Position(5533, 4808, 7), destination = Position(5584, 5537, 7) },
    [16] = { teleportPos = Position(5534, 4808, 7), destination = Position(4974, 4708, 7) },
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.WorldTeleports.Access)
    local storageNillux = player:getStorageValue(Storage.Quest.Crandoria.NilluxQuest.TimerEffect)

    -- Encontrar qual teleport é baseado na posição atual
    local destination = nil
    for _, data in pairs(teleportList) do
        if position.x == data.teleportPos.x and
           position.y == data.teleportPos.y and
           position.z == data.teleportPos.z then
            destination = data.destination
            break
        end
    end

    if destination and (storage == 1 or player:isVip() or storageNillux > os.time()) then
        player:teleportTo(destination)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    player:teleportTo(fromPosition)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Este teleport so pode ser usado por jogadores VIP ou membros da Sociedade dos Magos.")
    return true
end

teleport:type("stepin")
teleport:aid(12262)
teleport:register()
