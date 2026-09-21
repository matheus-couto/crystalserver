local mikarahDeath = CreatureEvent("mikarahDeath")

function mikarahDeath.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	if targetMonster:getName() ~= "Mikarah" then
		return true
	else
		
	end

	for pid, _ in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(pid)
		if attackerPlayer then
			if attackerPlayer:getStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah) < 1 then
				attackerPlayer:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Mikarah, 1)
			end
		end
	end
end

mikarahDeath:register()
