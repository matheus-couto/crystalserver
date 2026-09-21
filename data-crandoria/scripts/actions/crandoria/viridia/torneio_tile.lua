local torneioTile = MoveEvent()

-- Tabela para armazenar IPs de jogadores que acessaram o teleporte
local accessedIPs = {}

function torneioTile.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
    if not player then
        return true
    end

	local playerIP = player:getIp()

	local primeiro = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Primeiro)
	local segundo = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Segundo)
	local terceiro = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Terceiro)

	local name = player:getName()

	if item:getPosition() == Position(4541, 5430, 2) then

		if player:getLevel() < 400 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce ainda nao atingiu o nivel 400.")
			player:teleportTo(Position(4541, 5432, 2))
			return true
		end

		if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode vencer o torneio com um personagem.")
			player:teleportTo(Position(4541, 5432, 2))
			return true
		end

		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.TimerTile) < 1737074400 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Seu personagem foi criado ha muito tempo, voce nao pode vencer o Torneio.")
			player:teleportTo(fromPosition) 
			return true
		end

		if primeiro > 0 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce ja registrou sua conquista. Informe a um membro da Staff.")
			player:teleportTo(Position(4541, 5432, 2))
			return true
		else
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Primeiro, os.time())
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Parabens! Voce atingiu o nivel 400 em Viridia! Comunique a Staff sobre sua conquista imediatamente.")
			addEvent(Game.broadcastMessage, 5 * 1000, "O jogador " ..name.. " atingiu o nivel 400 em Viridia!", MESSAGE_EVENT_ADVANCE)
		end
	end
end

torneioTile:aid(13087)
torneioTile:register()



-- local torneioTile = MoveEvent()

-- -- Tabela para armazenar IPs de jogadores que acessaram o teleporte
-- local accessedIPs = {}

-- function torneioTile.onStepIn(creature, item, position, fromPosition)

-- 	local player = creature:getPlayer()
--     if not player then
--         return true
--     end

-- 	local playerIP = player:getIp()

-- 	local primeiro = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Primeiro)
-- 	local segundo = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Segundo)
-- 	local terceiro = player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Terceiro)

-- 	local name = player:getName()

-- 	if item:getPosition() == Position(4541, 5430, 2) then

-- 		if player:getLevel() < 400 then
-- 			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce ainda nao atingiu o nivel 400.")
-- 			player:teleportTo(Position(4541, 5432, 2))
-- 			return true
-- 		end

-- 		if accessedIPs[playerIP] and accessedIPs[playerIP] ~= player:getGuid() then
-- 			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce so pode vencer o torneio com um personagem.")
-- 			player:teleportTo(Position(4541, 5432, 2))
-- 			return true
-- 		end

-- 		if primeiro > 0 or segundo > 0 or terceiro > 0 then
-- 			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce ja registrou sua conquista. Informe a um membro da Staff.")
-- 			player:teleportTo(Position(4541, 5432, 2))
-- 			return true
-- 		else
-- 			if Game.getStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Primeiro) < os.time() then
-- 				player:setStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Primeiro, 1)
-- 				Game.setStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Primeiro, os.time() + 30 * 24 * 60 * 60)
-- 				player:teleportTo(Position(4541, 5432, 2))
-- 				accessedIPs[playerIP] = player:getGuid()
-- 				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Parabens! Voce foi o primeiro a atingir o nivel 400 em Viridia! Comunique a um membro da Staff.")
-- 				addEvent(Game.broadcastMessage, 5 * 1000, "O jogador " ..name.. " foi o primeiro a atingir o nivel 400 em Viridia!", MESSAGE_EVENT_ADVANCE)
-- 			else
-- 				if Game.getStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Segundo) < 1 then
-- 					player:setStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Segundo, 1)
-- 					Game.setStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Segundo, 1)
-- 					player:teleportTo(Position(4541, 5432, 2))
-- 					accessedIPs[playerIP] = player:getGuid()
-- 					player:sendTextMessage(MESSAGE_STATUS_SMALL, "Parabens! Voce foi o segundo a atingir o nivel 400 em Viridia! Comunique a um membro da Staff.")
-- 					addEvent(Game.broadcastMessage, 5 * 1000, "O jogador " ..name.. " foi o segundo a atingir o nivel 400 em Viridia!", MESSAGE_EVENT_ADVANCE)
-- 				else
-- 					if Game.getStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Terceiro) < 1 then
-- 						player:setStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Terceiro, 1)
-- 						Game.setStorageValue(GlobalStorage.Crandoria.TorneioIronMan.Terceiro, 1)
-- 						player:teleportTo(Position(4541, 5432, 2))
-- 						accessedIPs[playerIP] = player:getGuid()
-- 						player:sendTextMessage(MESSAGE_STATUS_SMALL, "Parabens! Voce foi o terceiro a atingir o nivel 400 em Viridia! Comunique a um membro da Staff.")
-- 						addEvent(Game.broadcastMessage, 5 * 1000, "O jogador " ..name.. " foi o terceiro a atingir o nivel 400 em Viridia!", MESSAGE_EVENT_ADVANCE)
-- 					else
-- 						player:sendTextMessage(MESSAGE_STATUS_SMALL, "Os tres campeoes ja foram selecionados!")
-- 						player:teleportTo(fromPosition)
-- 						return true
-- 					end
-- 				end
-- 			end
-- 		end
-- 	elseif item:getPosition() == Position(4500, 5522, 6) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Primeiro) < 1 then
-- 			player:teleportTo(Position(4500, 5519, 6))
-- 			return true
-- 		else
-- 			return true
-- 		end
-- 	elseif item:getPosition() == Position(4502, 5522, 6) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Segundo) < 1 then
-- 			player:teleportTo(Position(4502, 5519, 6))
-- 			return true
-- 		else
-- 			return true
-- 		end
-- 	elseif item:getPosition() == Position(4504, 5522, 6) then
-- 		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Torneio.Terceiro) < 1 then
-- 			player:teleportTo(Position(4504, 5519, 6))
-- 			return true
-- 		else
-- 			return true
-- 		end
-- 	end
-- end

-- torneioTile:aid(13087)
-- torneioTile:register()