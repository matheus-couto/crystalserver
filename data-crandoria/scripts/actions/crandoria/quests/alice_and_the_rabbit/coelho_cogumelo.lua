local coelhoCogumelo = Action()
function coelhoCogumelo.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() == 3915 then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 7 then
			if player:getLevel() >= 800 then
				local newPosition = player:getPosition()
				newPosition.x = newPosition.x - 168
				newPosition.y = newPosition.y + 9
				newPosition.z = newPosition.z + 0
				player:teleportTo(newPosition)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce comeu o cogumelo e comecou a enxergar tudo com outros olhos! Agora abrir aquela porta parece facil...")
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress, 8)
				if player:getItemCount(43733) > 0 then -- ALICE
					local rabbitcount = player:getItemCount(43733)
					player:removeItem(43733, rabbitcount)
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui nivel suficiente para isso. Volte apos o nivel 800.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) == 8 then
			local newPosition = player:getPosition()
			newPosition.x = newPosition.x - 168
			newPosition.y = newPosition.y + 9
			newPosition.z = newPosition.z + 0
			player:teleportTo(newPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce comeu o cogumelo e comecou a enxergar tudo com outros olhos! Agora abrir aquela porta parece facil...")
			if player:getItemCount(43733) > 0 then -- ALICE
				local rabbitcount = player:getItemCount(43733)
				player:removeItem(43733, rabbitcount)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao deveria estar aqui.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	elseif item:getId() == 32198 and item.uid == 12318 then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 7 then
			local newPosition = player:getPosition()
			newPosition.x = newPosition.x + 168
			newPosition.y = newPosition.y - 9
			newPosition.z = newPosition.z + 0
			player:teleportTo(newPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce bebeu um pouco do leite e esta se sentindo melhor.")
			if player:getItemCount(43733) > 0 then -- ALICE
				local rabbitcount = player:getItemCount(43733)
				player:removeItem(43733, rabbitcount)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao deveria estar aqui.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	elseif item:getId() == 25750 then
		if item:getPosition() == Position(4573, 4699, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 2)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4589, 4728, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 2 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 3)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 2 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4622, 4704, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 3 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 4)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 3 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4642, 4722, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 4 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 5)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 4 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4629, 4750, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 5 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 6)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 5 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4622, 4762, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 6 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 7)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 6 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4579, 4763, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 7 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 8)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 7 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4626, 4805, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 8 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 9)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 8 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4681, 4737, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 9 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 10)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 9 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		elseif item:getPosition() == Position(4707, 4776, 15) then
			if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) == 10 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ajudou uma das fadas e recebeu parte de seus poderes.")
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
				player:setStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor, 11)
			elseif player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Flor) > 10 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja ajudou essa fada.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ha outras fadas que precisam da bencao antes dessa.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				return true
			end
		end
	end
	return true
end

coelhoCogumelo:aid(12374)
coelhoCogumelo:register()