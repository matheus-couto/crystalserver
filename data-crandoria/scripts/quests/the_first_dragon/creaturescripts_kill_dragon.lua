local killDragon = CreatureEvent("TheFirstDragonDragonTaskDeath")

function killDragon.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		local count = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter)
		local storage = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso)
		local storageDrystan = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.Progresso)
		local countDrystan = player:getStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount)


		if storage == 1 then
			if count < 499 then
				local current = count + 1
				player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, current)
				player:sendTextMessage(
				MESSAGE_STATUS_SMALL,
				string.format("[Dragons de Dracantus] %d/500", current)
				)
				return true
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Dragons de Dracantus] Finalizada")
			player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, 500)
			return true
		end

		if storageDrystan == 5 then
			if count < 999 then
				local current = countDrystan + 1
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, current)
				player:sendTextMessage(
				MESSAGE_STATUS_SMALL,
				string.format("[Dragons para Drystan] %d/1000", current)
				)
				return true
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Dragons para Drystan] Finalizada")
				player:setStorageValue(Storage.Quest.Crandoria.DrystanQuest.KillCount, 200)
				return true
			end
		end
	end)
	return true
end

killDragon:register()
