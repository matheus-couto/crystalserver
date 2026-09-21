local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local teleportPosition = {x = 5235, y = 4932, z = 10}
	local stonePosition = {x = 5233, y = 4933, z = 10}

	if item.itemid == 2772 then
		local teleport = Game.createItem(1949, 1, teleportPosition)
		if teleport then
			teleport:setDestination({x = 5260, y = 4931, z = 10})
			Position(teleportPosition):sendMagicEffect(CONST_ME_TELEPORT)
		end

		Tile(stonePosition):getItemById(1842):remove()
		item:transform(2773)
	elseif item.itemid == 2773 then
		Position(stonePosition):hasCreature({x = 5234, y = 4933, z = 10})
		Tile(teleportPosition):getItemById(1949):remove()
		Position(teleportPosition):sendMagicEffect(CONST_ME_POFF)
		Game.createItem(1842, 1, stonePosition)
		item:transform(2772)
	end
	return true
end

lever:uid(30007)
lever:register()
