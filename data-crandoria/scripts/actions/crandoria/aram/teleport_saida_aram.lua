local teleportAram = MoveEvent()


function teleportAram.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
    if not player then
        return true
    end
	
    if item:getPosition() == Position(4369, 4427, 7) then
        if player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) <= os.time() then
            if player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux) == 1 then
                player:teleportTo(Position(4311, 4401, 6))
                return true
            elseif player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos) == 1 then
                player:teleportTo(Position(4401, 4401, 6))
                return true
            else
                player:teleportTo(fromPosition)
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce nao esta participando de nenhuma partida no momento.")
                return true
            end
        else
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce nao esta participando de nenhuma partida no momento.")
            return true
        end
    elseif item:getPosition() == Position(4306, 4396, 6) or item:getPosition() == Position(4406, 4396, 6) or item:getPosition() == Position(4408, 4401, 7) or item:getPosition() == Position(4304, 4401, 7) then
        player:teleportTo(Position(5000, 5000, 6))
        player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux, 0)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeChaos, 0)
        player:setStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral, 0)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce abandonou a partida.")
        player:setFaction(FACTION_PLAYER)
        return true
    elseif item:getPosition() == Position(4405, 4401, 6) or item:getPosition() == Position(4307, 4401, 6) then
        if player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerMorte) > os.time() then
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce deve aguardar 15 segundos apos morrer para retornar a batalha.")
            return true
        else
            if player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimeAnvillux) == 1 then
                player:teleportTo(Position(4307, 4401, 7))
                return true
            else
                player:teleportTo(Position(4405, 4401, 7))
                return true
            end
        end
    end


end

teleportAram:aid(13124)
teleportAram:register()