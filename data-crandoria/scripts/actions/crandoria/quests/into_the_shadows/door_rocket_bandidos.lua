local doorRocket = Action()

function doorRocket.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local position = player:getPosition()


	if item:getPosition() == Position(6061, 5321, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) > 12 and player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) < 16 then
			if item.actionid == 13028 then
				if item.itemid == 1644 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 1645 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 1645 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A porta foi trancada por Rocket Tank antes de sua captura.")
		end
	elseif item:getPosition() == Position(4941, 4970, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) > 16 then
			if item.actionid == 13028 then
				if item.itemid == 6258 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 6259 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 6259 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem permissao para acessar a area restrita da prisao.")
		end
	elseif item:getPosition() == Position(4864, 4468, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 8 and player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) < 16 then
			if item.actionid == 13028 then
				if item.itemid == 5287 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 5288 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 5288 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) < 9 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem permissao para acessar este local.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O local foi interditado apos a prisao de Sr Pig.")
			return true
		end
	elseif item:getPosition() == Position(4941, 4970, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) >= 18 then
			if item.actionid == 13028 then
				if item.itemid == 6258 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 6259 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 6259 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem permissao para acessar esta area da prisao.")
		end
	end
	return true
end

doorRocket:aid(13028)
doorRocket:register()