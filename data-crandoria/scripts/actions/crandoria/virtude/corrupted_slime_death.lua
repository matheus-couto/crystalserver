local corruptedDeath = CreatureEvent("corruptedDeath")

function corruptedDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local targetMonster = creature:getMonster()
	if not targetMonster then
		return true
	end

	local name = targetMonster:getName():lower()
	if name ~= "corrupted slime" then
		return true
	end

	local damageMap = creature:getMonster():getDamageMap()

	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player then
			local storage = player:getStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso)
			if storage == 6 then
				player:teleportTo(Position(5042, 4856, 7))
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Corrupted Slime!")
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 8)
			elseif storage == 7 then
				player:teleportTo(Position(5042, 4856, 7))
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Corrupted Slime!")
				player:setStorageValue(Storage.Quest.Crandoria.EstatuasDaVirtude.Progresso, 9)
			end
		end
	end

	return true
end

corruptedDeath:register()