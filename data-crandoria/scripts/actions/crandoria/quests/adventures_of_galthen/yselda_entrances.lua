local config = {
	{position = {x = 5242, y = 4463, z = 10}, destination = {x = 5223, y = 4460, z = 10}},
	{position = {x = 5223, y = 4461, z = 10}, destination = {x = 5242, y = 4461, z = 10}}
}	
	
local forestOfLife = MoveEvent()
function forestOfLife.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return false
	end
	for value in pairs(config) do
		if Position(config[value].position) == player:getPosition() then
			player:teleportTo(Position(config[value].destination))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
end

forestOfLife:type("stepin")
for value in pairs(config) do
	forestOfLife:position(config[value].position)
end
forestOfLife:register()