local destination = {
	[12259] = Position(5086, 4378, 7), -- Canion para Island
	[12260] = Position(5895, 4720, 7), -- Island para Canion
}

local teleport = MoveEvent()



function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]
		if teleport then
			player:teleportTo(teleport)
        		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
