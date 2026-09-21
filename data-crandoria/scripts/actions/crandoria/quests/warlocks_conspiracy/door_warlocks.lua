local doorWarlocks = Action()
function doorWarlocks.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) >= 6 then
		if player:getPosition() == Position(4699, 5084, 12) then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(4696, 5084, 12))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		elseif player:getPosition() == Position(4697, 5084, 12) then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(4700, 5084, 12))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa da permissao de Kozlon para acessar esta porta.")
	end
	return true
end

doorWarlocks:aid(13001)
doorWarlocks:register()

local doorWarlocks2 = Action()

function doorWarlocks2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getPosition() == Position(4545, 5098, 14) then
		if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Acesso) >= 1 then
			player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
			player:teleportTo(Position(4543, 5098, 14))
			player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
		else
			if player:getItemCount(8828) >= 1 and player:getItemCount(11549) >= 1 and player:getItemCount(21758) >= 1 and player:getItemCount(8150) >= 1 then
			-- if player:removeItem(8828, 1) and player:removeItem(11549, 1) and player:removeItem(21758, 1) and player:removeItem(8150, 1) then
				player:removeItem(8828, 1)
				player:removeItem(11549, 1)
				player:removeItem(21758, 1)
				player:removeItem(8150, 1)
				player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
				player:teleportTo(Position(4543, 5098, 14))
				player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce utilizou os Trinkets e conseguiu acessar os aposentos de Zarabastan.")
				player:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Acesso, 1)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui os itens necessarios para acessar os aposentos de Zarabastan.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end
	elseif item:getPosition() == Position(4793, 5226, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Reward) >= 1 then
			if player:getSkull() == SKULL_NONE then
				player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
				player:teleportTo(Position(4793, 5224, 6))
				player:getPosition():sendMagicEffect(CONST_ME_ORANGETELEPORT)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao pode entrar na casa de Kozlon com status de PvP ativados.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem permissao para acessar este local.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	return true
	end
end

doorWarlocks2:aid(13002)
doorWarlocks2:register()