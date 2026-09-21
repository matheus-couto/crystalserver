local destination = {
	[12325] = Position(5035, 5335, 7), -- EK

}

local teleport = MoveEvent()



function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]
		if teleport and player:getVocation():getBaseId() == VOCATION.BASE_ID.KNIGHT or player:getVocation():getBaseId() == VOCATION.BASE_ID.CELESTIAL_GUARDIAN then
			player:teleportTo(Position(5035, 5335, 7))
        		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	else
	player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This teleport can only be used by Knights.")
		return true
	end
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
