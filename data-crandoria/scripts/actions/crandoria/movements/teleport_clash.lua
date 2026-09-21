local teleportClash2 = MoveEvent()

-- Tabela para armazenar IPs de jogadores que acessaram o teleporte
local accessedIPs = {}

function teleportClash2.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
    if not player then
        return true
    end

	local playerIP = player:getIp()

        if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode realizar este desafio com um porsonagem por dia.")
            player:teleportTo(fromPosition)
            return true
        else
		player:teleportTo(Position(4032, 5549, 7))
		accessedIPs[playerIP] = player:getGuid()
		return true
	end
end

teleportClash2:aid(13079)
teleportClash2:register()


