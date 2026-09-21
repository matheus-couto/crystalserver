local config = {
	[12266] = { flamePosition = Position(6108, 4618, 7), toPosition = Position(6105, 4617, 7) },
}

local tombCoalBasin = MoveEvent()

function tombCoalBasin.onAddItem(moveitem, tileitem, position)
	local targetCoalBasin = config[tileitem.uid]
	if not targetCoalBasin then
		return true
	end

	if moveitem.itemid ~= 9606 then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	moveitem:remove()
	position:sendMagicEffect(CONST_ME_HITBYFIRE)

	Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
	targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tombCoalBasin:type("additem")
tombCoalBasin:id(3514)
tombCoalBasin:register()