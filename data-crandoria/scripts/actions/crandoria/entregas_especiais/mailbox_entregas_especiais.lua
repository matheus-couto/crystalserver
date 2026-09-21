local mailboxEntregas = Action()

function mailboxEntregas.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getPosition() == Position(5085, 4471, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso) == 4 then
			if player:getFreeCapacity() > 60 then
				player:addItem(145, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o primeiro pacote para Karl.")
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 5)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de pelo menos 60 oz de capacidade livre para pegar o item.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end
	elseif item:getPosition() == Position(5380, 4689, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso) == 5 then
			if player:getFreeCapacity() > 60 then
				player:addItem(145, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o segundo pacote para Karl.")
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 6)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de pelo menos 60 oz de capacidade livre para pegar o item.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end
	elseif item:getPosition() == Position(5532, 5144, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso) == 6 then
			if player:getFreeCapacity() > 60 then
				player:addItem(145, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce obteve o terceiro pacote para Karl.")
				player:setStorageValue(Storage.Quest.Crandoria.EntregasEspeciais.Progresso, 7)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa de pelo menos 60 oz de capacidade livre para pegar o item.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end
	end
end

mailboxEntregas:aid(13180)
mailboxEntregas:register()