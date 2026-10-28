local thePrimalMenaceDeath = CreatureEvent("ThePrimalMenaceDeath")

function thePrimalMenaceDeath.onDeath(creature)
	local damageMap = creature:getMonster():getDamageMap()
	local hazard = Hazard.getByName("hazard.gnomprona-gardens")
	if not hazard then
		return
	end
	local _, hazardPoints = hazard:getHazardPlayerAndPoints(damageMap)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled) < 1 then
			player:setStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled, 1)
		end

		local storageCrassus = player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso)
		if storageCrassus == 210 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 211)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda precisa derrotar The Primal Menace 2 vezes para Kalahar.")
		elseif storageCrassus == 211 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 212)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ainda precisa derrotar The Primal Menace 1 vez para Kalahar.")
		elseif storageCrassus == 212 then
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 213)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce finalizou a missao de Kalahar.")
		end

		if hazard:getPlayerMaxLevel(player) == hazardPoints then
			hazard:levelUp(player)
		end
	end)
end

thePrimalMenaceDeath:register()
