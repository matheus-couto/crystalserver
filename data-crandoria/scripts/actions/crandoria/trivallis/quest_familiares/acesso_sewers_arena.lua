local accessSewers = Action()
function accessSewers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if not player then
		return true
	end

	if toPosition == Position(5798, 5569, 7) then
		player:teleportTo(Position(5798, 5569, 10))
		return true
	elseif toPosition == Position(5798, 5569, 10) then
		player:teleportTo(Position(5798, 5570, 7))
		return true
	elseif toPosition == Position(5754, 5578, 7) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:teleportTo(Position(5754, 5580, 7))
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return true
	elseif toPosition == Position(5753, 5580, 7) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:teleportTo(Position(5753, 5578, 7))
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return true
	elseif toPosition == Position(5873, 5519, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso) == 3 then
			player:addItem(13429, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce pegou os pertences de Kromrek.")
			player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 4)
			return true
		end
	elseif toPosition == Position(5917, 5582, 7) then
		player:teleportTo(Position(5943, 5612, 8))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	elseif toPosition == Position(5873, 5521, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso) >= 3 then
			if item.itemid == 5289 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 5290 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 5290 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso negado.")
		end
		return true
	end
	return true
end

accessSewers:aid(13183)
accessSewers:register()