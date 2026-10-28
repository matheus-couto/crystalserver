local teleportEventos = MoveEvent()

local accessedIPs = {}

function teleportEventos.onStepIn(player, item, position, fromPosition)

    if not player then
        return true
    end

    local playerIP = player:getIp()

    local day = os.date("%A")
    local storage = Game.getStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado)

	if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode acessar o evento com um personagem.")
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

    accessedIPs[playerIP] = player:getGuid()

    if storage ~= 1 then
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao ha eventos ocorrendo no momento.")
        return true
    else
        if day == "Wednesday" then
            if player:getLevel() < 100 then
                player:teleportTo(fromPosition)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de nivel 100 ou superior para participar desse evento.")
                return true 
            else
                player:teleportTo(Position(4458, 6088, 7))
            end 
        elseif day == "Saturday" then
            if player:getLevel() < 200 then
                player:teleportTo(fromPosition)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de nivel 200 ou superior para participar desse evento.")
                return true 
            else
                player:teleportTo(Position(4313, 6093, 7))
            end 
        elseif day == "Sunday" then
            if player:getLevel() < 300 then
                player:teleportTo(fromPosition)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de nivel 300 ou superior para participar desse evento.")
                return true 
            else
                player:teleportTo(Position(4329, 6122, 7))
            end 
        end

        local summons = player:getSummons()
		if summons then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Summons e Familiares nao sao permitidos nesse evento.")
			for _, summon in ipairs(summons) do
				summon:remove()
			end
		end

    end



end

teleportEventos:aid(13227)
teleportEventos:register()