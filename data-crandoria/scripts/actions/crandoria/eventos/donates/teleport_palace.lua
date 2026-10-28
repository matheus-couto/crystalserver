local teleportDonates = MoveEvent()

function teleportDonates.onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()

	if item:getPosition() == Position(4548, 5414, 3) then -- VIRIDIA
		if player:getName():lower() == "god" then
			player:teleportTo(Position(4487, 5531, 7))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso Negado.")
			return true
		end
	elseif item:getPosition() == Position(4899, 5059, 7) then -- CRANDORIA
		if player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioAccesso) > os.time() then
			player:teleportTo(Position(4785, 4874, 7))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Acesso Negado.")
			return true
		end
	end
end

teleportDonates:aid(13050)
teleportDonates:register()