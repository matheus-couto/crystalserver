local deathFirstDragon = CreatureEvent("FirstDragonDeath")

function deathFirstDragon.onDeath(creature, corpse, lasthitkiller, mostdamagekiller, lasthitunjustified, mostdamageunjustified)
	local spectators = Game.getSpectators(Position(4541, 5031, 15), false, false, 14, 14, 14, 14)
	for i = 1, #spectators do
		local spec = spectators[i]
		if spec:isPlayer() then
			spec:getPosition():sendMagicEffect(CONST_ME_AVATAR_APPEAR)
			if spec:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Reward) < 1 then
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou The First Dragon.")
				spec:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.Reward, 1)
			end
			if spec:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) == 9 then
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou The First Dragon, colete seu espirito rapidamente com o frasco!")
			end
			if spec:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 11 and spec:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				spec:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
		end
	end
	return true
end

deathFirstDragon:register()
