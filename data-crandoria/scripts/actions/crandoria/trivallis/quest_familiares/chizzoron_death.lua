local chizzoronDeath = CreatureEvent("chizzoronDeath")

function chizzoronDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return
	end
	local damageMap = creature:getMonster():getDamageMap()


	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			local storage = player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso)
			if storage == 4 then
				player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 5)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Chizzoron the Distorter. Reporte a Percybald.")
				return true
			end
		end
	end
	return true
end

chizzoronDeath:register()