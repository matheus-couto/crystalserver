local vladrukhDeath = CreatureEvent("vladrukhDeath")

function vladrukhDeath.onDeath(creature)
	local bossName = creature:getName():lower()
	if bossName ~= "vladrukh" then
		return false
	end

	local storage = player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline)
	local crassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)

	onDeathForDamagingPlayers(creature, function(creature, player)
		if storage == 5 then
			player:setStorageValue(Storage.Quest.U15_10.BloodyTusks.Questline, 6)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Vladrukh. Reporte a Anaztassja Moroia.")
		end
		if crassus == 189 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 190)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Vladrukh 1 vez a pedido de Kalahar.")
		elseif crassus == 190 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 191)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Vladrukh 2 vezes a pedido de Kalahar.")
		elseif crassus == 191 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 192)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Vladrukh 3 vezes a pedido de Kalahar. Reporte sua missao.")
		end
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
		player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
	end)

	return true
end

vladrukhDeath:register()
