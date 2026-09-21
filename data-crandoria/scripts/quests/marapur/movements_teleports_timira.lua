local positions = {
	{ tptimiraPos = { x = 5640, y = 4255, z = 7 }, tpPos = { x = 5641, y = 4255, z = 8 } },

	{ tptimiraPos = { x = 5639, y = 4255, z = 8 }, tpPos = { x = 5639, y = 4256, z = 7 } },

	{ tptimiraPos = { x = 5653, y = 4265, z = 9 }, tpPos = { x = 5628, y = 4260, z = 9 } },
}

local TpTimira = MoveEvent()

function TpTimira.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	local newPos
	for _, info in pairs(positions) do
		if Position(info.tptimiraPos) == position then
			newPos = Position(info.tpPos)
			break
		end
	end
	if newPos then
		player:teleportTo(newPos)
		position:sendMagicEffect(CONST_ME_TELEPORT)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

TpTimira:type("stepin")

TpTimira:id(35500)

TpTimira:register()
