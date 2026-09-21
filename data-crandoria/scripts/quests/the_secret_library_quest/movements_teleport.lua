local destination = {
	[64007] = Position(4811, 4508, 7), --Falcon
	[64008] = Position(4840, 4471, 7), --Falcon
	[64009] = Position(4848, 4454, 7), --Falcon
	[64010] = Position(4987, 4460, 7), --Falcon
	[64011] = Position(4811, 4462, 7), --Falcon
	[64012] = Position(33327, 31351, 7), --Falcon
	[64013] = Position(5144, 4660, 8), --Deep desert
	[64014] = Position(5144, 4660, 7), --Deep desert
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
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		teleport:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
