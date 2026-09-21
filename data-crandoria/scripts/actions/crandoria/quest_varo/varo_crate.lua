local crateVaro = Action()

function crateVaro.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

	if item:getPosition() == Position(6153, 5282, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 1 then
			if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 200 then
				local container = player:addItem(2853, 1)
				if container then
					container:addItem(3375, 1)
					container:addItem(3557, 1)
					container:addItem(3556, 1)
					player:setStorage(Storage.Quest.Crandoria.VaroQuest.Progresso, 2)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o carregamento de Varo.")
					return true
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o carregamento, mas precisa de 200 de Cap e 2 espaços vagos no inventario.")
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conseguiu abrir a caixa.")
			return true
		end
	elseif item:getPosition() == Position(5913, 4257, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 4 then
			if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 150 then
				local container = player:addItem(2853, 1)
				if container then
					container:addItem(3360, 1)
					container:addItem(3382, 1)
					player:setStorage(Storage.Quest.Crandoria.VaroQuest.Progresso, 5)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o carregamento de Varo.")
					return true
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o carregamento, mas precisa de 150 de Cap e 2 espaços vagos no inventario.")
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conseguiu abrir a caixa. Ha um bilhete escrito 'Propriedade de Varo'.")
			return true
		end
	elseif item:getPosition() == Position(5979, 4725, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 7 then
			if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 200 then
				local container = player:addItem(2853, 1)
				if container then
					container:addItem(3366, 1)
					container:addItem(3364, 1)
					container:addItem(4061, 1)
					player:setStorage(Storage.Quest.Crandoria.VaroQuest.Progresso, 8)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o carregamento de Varo.")
					return true
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o carregamento, mas precisa de 200 de Cap e 2 espaços vagos no inventario.")
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conseguiu abrir a caixa. Ha um bilhete escrito 'Propriedade de Varo'.")
			return true
		end
	elseif item:getPosition() == Position(5544, 4889, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 12 then
			player:teleportTo(Position(5544, 4889, 8))
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
			return true
		end
	elseif item:getPosition() == Position(5101, 5611, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.VaroQuest.Progresso) == 10 then
			if player:getFreeBackpackSlots() >= 2 and player:getFreeCapacity() >= 250 then
				local container = player:addItem(2853, 1)
				if container then
					container:addItem(8053, 1)
					container:addItem(7417, 1)
					container:addItem(3342, 1)
					player:setStorage(Storage.Quest.Crandoria.VaroQuest.Progresso, 11)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o carregamento de Varo.")
					return true
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o carregamento, mas precisa de 250 de Cap e 2 espaços vagos no inventario.")
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conseguiu abrir a caixa. Ha um bilhete escrito 'Propriedade de Varo'.")
			return true
		end
	end

end

crateVaro:aid(13166)
crateVaro:register()