local keysMitmah = Action()

function keysMitmah.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not player then
		return true
	end

	local storage1 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key1)
	local storage2 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key2)
	local storage3 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key3)
	local storage3 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key4)

	if item:getPosition() == Position(5616, 5519, 14) then
		if storage1 < 1 then
			player:addItem(44674, 1)
			player:setStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key1, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma chave.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
			return true
		end
	elseif item:getPosition() == Position(5644, 5588, 14) then
		if storage2 < 1 then
			player:addItem(44675, 1)
			player:setStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key2, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma chave.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
			return true
		end
	elseif item:getPosition() == Position(5732, 5599, 14) then
		if storage3 < 1 then
			player:addItem(44673, 1)
			player:setStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key3, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma chave.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
			return true
		end
	elseif item:getPosition() == Position(5629, 5448, 15) then
		if storage4 < 1 then
			player:addItem(44672, 1)
			player:setStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key4, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma chave.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta vazio.")
			return true
		end
	end
end


keysMitmah:aid(13208)
keysMitmah:register()




local gateEntranceMitmah = Action()

function gateEntranceMitmah.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not player then
		return true
	end

	local storage1 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key1)
	local storage2 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key2)
	local storage3 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key3)
	local storage3 = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.Key4)
	local storageAccess = player:getStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.AccessDoor)

	if storage1 >= 1 and storage2 >= 1 and storage3 >= 1 and storage4 >= 1 then
		if storageAccess < 1 then
			if player:getItemCount(44672) >= 1 and player:getItemCount(44673) >= 1 and player:getItemCount(44674) >= 1 and player:getItemCount(44675) >= 1 then
				player:removeItem(44672, 1)
				player:removeItem(44673, 1)
				player:removeItem(44674, 1)
				player:removeItem(44675, 1)
				player:teleportTo(Position(5708, 5411, 15))
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu acesso aos dominios de Mitmah Vanguard.")
				player:setStoargeValue(Storage.Quest.U12_70.AdventuresOfGalthen.AccessDoor, 1)
				return true
			end
		else
			player:teleportTo(Position(5708, 5411, 15))
			return true
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa coletar todas as chaves dos baus para acessar este local.")
		return true
	end
	return true
end


gateEntranceMitmah:aid(13209)
gateEntranceMitmah:register()