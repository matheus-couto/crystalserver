-- local teleportEvent = MoveEvent()

-- -- Tabela para armazenar IPs de jogadores que acessaram o teleporte
-- local accessedIPs = {}
-- local accessedIPsViridia = {}

-- function teleportEvent.onStepIn(creature, item, position, fromPosition)

-- 	local player = creature:getPlayer()
--     if not player then
--         return true
--     end

-- 	local playerIP = player:getIp()

-- 	if item:getPosition() == Position(4912, 5078, 7) then

--         if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
--             player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode acessar o evento com um personagem.")
--             player:teleportTo(fromPosition)
--             return true
--         else
-- 			if player:getLevel() >= 100 then
-- 				player:teleportTo(Position(4902, 5171, 7))
-- 				accessedIPs[playerIP] = player:getGuid()
-- 				return true
-- 			else
-- 				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Apenas personagens de nível 100 ou maior podem acessar o evento.")
-- 				player:teleportTo(fromPosition)
-- 				return true
-- 			end
-- 		end
-- 	elseif item:getPosition() == Position(4538, 5434, 3) then
-- 		if accessedIPsViridia[playerIP] and accessedIPsViridia[playerIP] ~= player:getGuid() then
--             player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode acessar o evento com um personagem.")
--             player:teleportTo(fromPosition)
--             return true
--         else
-- 			if player:getStorageValue(Storage.Quest.Crandoria.EventoNatal.Count) >= 5 then
-- 				player:teleportTo(Position(4589, 5571, 7))
-- 				accessedIPsViridia[playerIP] = player:getGuid()
-- 				return true
-- 			else
-- 				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Apenas personagens de nível 8 ou maior podem acessar o evento.")
-- 				player:teleportTo(fromPosition)
-- 				return true
-- 			end
-- 		end
-- 	end
-- end

-- teleportEvent:aid(13082)
-- teleportEvent:register()




-- 			-- if player:getStorageValue(Storage.Quest.Crandoria.Eventos.FestivalDePrimavera.Teleport) > os.time() then
-- 			-- 	if player:getLevel() >= 250 then
-- 			-- 		player:teleportTo(Position(4359, 5678, 7))
-- 			-- 		accessedIPs[playerIP] = player:getGuid()
-- 			-- 		return true
-- 			-- 	else
-- 			-- 		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Apenas personagens de nível 250 ou maior podem acessar o evento.")
-- 			-- 		player:teleportTo(fromPosition)
-- 			-- 		return true
-- 			-- 	end
-- 			-- else
-- 			-- 	if player:getLevel() >= 250 then
-- 			-- 		player:teleportTo(Position(4359, 5709, 7))
-- 			-- 		accessedIPs[playerIP] = player:getGuid()
-- 			-- 		return true
-- 			-- 	else
-- 			-- 		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Apenas personagens de nível 250 ou maior podem acessar o evento.")
-- 			-- 		player:teleportTo(fromPosition)
-- 			-- 		return true
-- 			-- 	end
-- 			-- end