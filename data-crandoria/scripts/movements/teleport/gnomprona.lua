local teleports = {
	{position = Position(5785, 4867, 15), destination = Position(5796, 4879, 15)},
	{position = Position(5692, 4703, 15), destination = Position(5683, 4700, 14)},
	{position = Position(5784, 4845, 14), destination = Position(5796, 4879, 15)},
	{position = Position(5842, 4745, 14), destination = Position(5684, 4698, 14), access = Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleKilled},
	{position = Position(5684, 4697, 14), destination = Position(5842, 4746, 14)},
	{position = Position(5798, 4881, 15), destination = Position(5787, 4844, 14)},
}

local gnomprona = MoveEvent()

function gnomprona.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	for c = 1, #teleports do
		if teleports[c].position then
			if player:getPosition() == Position(teleports[c].position) then
				if teleports[c].access then
					if player:getStorageValue(teleports[c].access) > 0 then
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						player:teleportTo(teleports[c].destination)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					else
						player:teleportTo(fromPosition)
					end
				else
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:teleportTo(teleports[c].destination)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		elseif teleports[c].positions then
			for d = 1, #teleports[c].positions do
				if player:getPosition() == Position(teleports[c].positions[d]) then
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:teleportTo(teleports[c].destination)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		end
	end
end

for a = 1, #teleports do
	if teleports[a].position then
		gnomprona:position(teleports[a].position)
	elseif teleports[a].positions then
		for b = 1, #teleports[a].positions do
			gnomprona:position(teleports[a].positions[b])
		end
	end
end
gnomprona:register()
