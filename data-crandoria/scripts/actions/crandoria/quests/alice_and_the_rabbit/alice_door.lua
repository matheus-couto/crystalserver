local aliceRoom = Action()
function aliceRoom.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getPosition() == Position(5097, 4872, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.MedicineTimer) < os.time() or player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) > 5 then
			if item.actionid == 12371 then
				if item.itemid == 1642 then
					player:teleportTo(toPosition, true)
					item:transform(item.itemid + 1)
				elseif item.itemid == 1643 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 1643 then
						item:transform(item.itemid - 1)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Alice ainda esta descansando. Volte mais tarde.")
		end
	elseif item:getPosition() == Position(4502, 4708, 14) then
		if player:getStorageValue(Storage.Quest.Crandoria.AliceMcronald.Progress) >= 8 then
			if item.actionid == 12371 then
				if item.itemid == 39352 then
					player:teleportTo(toPosition, true)
					-- item:transform(item.itemid + 3)
					item:transform(39354)
				elseif item.itemid == 39354 then
					if Creature.checkCreatureInsideDoor(player, toPosition) then
						return true
					end
					if item.itemid == 39354 then
						-- item:transform(item.itemid - 3)
						item:transform(39352)
						return true
					end
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao tem permissao de acessar Thaumasia.")
		end
	end
	return true
end

aliceRoom:aid(12371)
aliceRoom:register()
