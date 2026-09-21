local config = {
	[62221] = Position(5905, 4894, 7),
	[62222] = Position(5906, 4894, 7),
	[62223] = Position(4854, 4255, 7),
	[62224] = Position(4855, 4255, 7),
}

local candiaTeleport = MoveEvent()

function candiaTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local actionId = item:getActionId()

	local targetPosition = config[actionId]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)
	return true
end

candiaTeleport:type("stepin")

for actionId, targetPos in pairs(config) do
	candiaTeleport:aid(actionId)
end

candiaTeleport:register()
