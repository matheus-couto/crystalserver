local teleportEventoArtefato = MoveEvent()

function teleportEventoArtefato.onStepIn(player, item, position, fromPosition)

	if not player then 
		return true
	end

	local storageReward = player:getStorageValue(Storage.Quest.Crandoria.EventoProgramado.RewardArtefato)
	local storageGlobal = Game.getStorageValue(GlobalStorage.Crandoria.Eventos.EventoProgramado)

	if storageGlobal < 1 then
		if storageReward <= 1 then
			player:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.RewardArtefato, 1)
			player:teleportTo(Position(5000, 5000, 6))
			player:sendTextMessage("Obtenha sua recompensa por participar do evento no Bau embaixo do Templo de Crandoria.")
			return true
		else
			player:teleportTo(Position(5000, 5000, 6))
			player:sendTextMessage("Obtenha sua recompensa por vencer o evento no Bau embaixo do Templo de Crandoria.")
			return true
		end
	else
		player:teleportTo(Position(5000, 5000, 6))
		player:sendTextMessage("Voce abandonou o evento.")
		return true
	end

end

teleportEventoArtefato:aid(13229)
teleportEventoArtefato:register()