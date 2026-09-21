local rebelNagaKill = CreatureEvent("rebelNagaKill")

function rebelNagaKill.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return
	end
	local damageMap = creature:getMonster():getDamageMap()


	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			local nagaCount = player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) + 1
			if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 1 then
				if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) < 99 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Voce derrotou %d/100 Rebel Nagas", nagaCount))
					player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) + 1)
				elseif player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount) >= 99 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce finalizou a missao. Fale com Visanis.")
					player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.KillCount, 100)
				end
			end
			if creature:getName() == "Sihrazz" then
				if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 25 then
					player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 26)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a Sombra de Sihrazz. Retorne a Rainha Naga.")
				end
			end
		end
	end

	return true
end

rebelNagaKill:register()