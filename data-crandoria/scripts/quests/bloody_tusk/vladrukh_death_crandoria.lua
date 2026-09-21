local vladrukhDeath = CreatureEvent("vladrukhDeath")

function vladrukhDeath.onDeath(creature)
	local bossName = creature:getName():lower()
	if bossName ~= "vladrukh" then
		return false
	end

	local storage = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline)

	onDeathForDamagingPlayers(creature, function(creature, player)
		if storage == 5 then
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 6)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Vladrukh. Reporte a Anaztassja Moroia.")
			return true
		end
	end)

	return true
end

vladrukhDeath:register()
