local chestIceholdTower = Action()

function chestIceholdTower.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item:getPosition() == Position(5032, 5329, 5) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1, 1)
			player:addItem(7406, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5032, 5327, 5) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1, 1)
			player:addItem(7380, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5032, 5325, 5) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward1, 1)
			player:addItem(7392, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5031, 5325, 2) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2, 1)
			player:addItem(7384, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5033, 5325, 2) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2, 1)
			player:addItem(7389, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5035, 5325, 2) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward2, 1)
			player:addItem(7415, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5021, 5326, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3, 1)
			player:addItem(7390, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5023, 5326, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3, 1)
			player:addItem(7434, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	elseif item:getPosition() == Position(5025, 5326, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.IceholdTower.Reward3, 1)
			player:addItem(7429, 1)
			return true
		else
			player:sendCancelMessage("Voce ja pegou sua recompensa.")
			return true
		end
	end
end

chestIceholdTower:aid(13137)
chestIceholdTower:register()