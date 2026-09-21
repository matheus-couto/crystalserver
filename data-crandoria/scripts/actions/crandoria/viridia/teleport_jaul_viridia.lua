local teleportClash = MoveEvent()

-- Tabela para armazenar IPs de jogadores que acessaram o teleporte
local accessedIPs = {}

function teleportClash.onStepIn(creature, item, position, fromPosition)

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
		player:teleportTo(Position(4483, 5384, 12))
		accessedIPs[playerIP] = player:getGuid()
		return true
	end
end

teleportClash:aid(13089)
teleportClash:register()