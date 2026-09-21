local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local teleportPosition = {x = 4571, y = 5188, z = 4}

	print("ItemID:", item.itemid) -- Adicione esta linha para depuração

	if item.itemid == 2940 and item:getPosition() == Position(4570, 5187, 4) then
			item:transform(2941)
		local teleport = Game.createItem(22761, 1, teleportPosition)
		if teleport then
			teleport:setDestination({x = 4571, y = 5087, z = 11})
			teleport:sendMagicEffect(CONST_ME_TELEPORT)
		end


	elseif item.itemid == 2941 and item:getPosition() == Position(4570, 5187, 4) then
			item:transform(2940)
		local teleport = Tile(teleportPosition):getItemById(22761)
		if teleport then
			teleport:remove()
	    		teleportPosition:sendMagicEffect(CONST_ME_POFF)
		end
	end
	return true
end

lever:uid(12259)
lever:register()
