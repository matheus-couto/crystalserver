local destination = {
	[12290] = Position(5233, 4680, 15), -- Asura Citadel
}

local teleport = MoveEvent()


function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local storage = player:getStorageValue(Storage.Quest.Crandoria.AsuraCitadel.Access)


	local teleport = destination[item.actionid]
		if teleport then 
			if storage == 1 then
				player:teleportTo(teleport)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				player:setStorageValue(Storage.Quest.Crandoria.AsuraCitadel.Access, 0)
				return true
			elseif storage == 2 then
				player:teleportTo(teleport)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			else
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to pay the price to Yasmine to access the Asura Citadel.")
				return true
			end
		end
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
