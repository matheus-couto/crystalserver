local destination = {
	[12291] = Position(5867, 4800, 7), -- Feyrist para ilhota
	[12292] = Position(5867, 4821, 7), -- Ilhota para Feyrist 
}

local teleport = MoveEvent()



function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- local teleport = destination[item.actionid]
	-- 	if teleport then
	-- 		player:teleportTo(teleport)
    --     		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	-- 	return true
	-- end

	if item:getPosition() == Position(5867, 4819, 7) then
		local chance = math.random(1, 100)
		if chance > 5 then
			player:teleportTo(Position(5867, 4800, 7))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(Position(5253, 4523, 7))
			player:say('A tartaruga se perdeu no caminho!', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	else 
		player:teleportTo(Position(5867, 4821, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end


	
end

-- teleport:type("stepin")

-- for index, value in pairs(destination) do
-- 	teleport:aid(index)
-- end

teleport:aid(12292)
teleport:register()
