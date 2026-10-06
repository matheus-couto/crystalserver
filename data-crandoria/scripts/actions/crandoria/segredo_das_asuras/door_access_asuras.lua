local asuraCitadelDoor1 = Action()
function asuraCitadelDoor1.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor) >= 1 then
		if item.actionid == 12361 then
			if item.itemid == 17576 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 17577 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 17577 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu espirito nao carrega os tracos das Asuras. Voce nao tem permissao para acessar as profundezas da Citadela.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

asuraCitadelDoor1:aid(12361)
asuraCitadelDoor1:register()

local asuraCitadelDoor2 = Action()
function asuraCitadelDoor2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor) > 1 then
		if item.actionid == 12362 then
			if item.itemid == 17567 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 17568 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 17568 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conhece a forma correta de usar essa macaneta.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

asuraCitadelDoor2:aid(12362)
asuraCitadelDoor2:register()

local asuraCitadelDoor3 = Action()
function asuraCitadelDoor3.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor) > 1 then
		if item.actionid == 12363 then
			if item.itemid == 17567 then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			elseif item.itemid == 17568 then
				if Creature.checkCreatureInsideDoor(player, toPosition) then
					return true
				end
				if item.itemid == 17568 then
					item:transform(item.itemid - 1)
					return true
				end
			end
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao conhece a forma correta de usar essa macaneta.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

asuraCitadelDoor3:aid(12363)
asuraCitadelDoor3:register()