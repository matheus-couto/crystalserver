local teleport = MoveEvent()

-- Tabela para armazenar IPs de jogadores que acessaram o teleporte
local accessedIPs = {}

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getLevel() < 150 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce precisa possuir nivel 150 ou superior para acessar esse local.")
        player:teleportTo(Position(4512, 5405, 12))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        return true
    else

        local playerIP = player:getIp()
    
        if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode entrar nesse local com um personagem por dia.")
            player:teleportTo(Position(4512, 5405, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        else
            player:teleportTo(Position(4484, 5384, 12))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            accessedIPs[playerIP] = player:getGuid()
        end
    end
end

teleport:aid(13065)
teleport:register()