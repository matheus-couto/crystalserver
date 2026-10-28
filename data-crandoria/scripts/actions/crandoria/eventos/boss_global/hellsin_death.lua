local config = {
	centerPosition = Position(4313, 6082, 7),
	rangeX = 14,
	rangeY = 14,
}

local hellsinDeath = CreatureEvent("hellsinDeath")

function hellsinDeath.onDeath(creature)
	if creature:getName() == "Hellsin" then
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, specCreature in pairs(spectators) do
			if specCreature:isPlayer() then
				specCreature:setStorageValue(Storage.Quest.Crandoria.EventoProgramado.BossGlobal, 2)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Hellsin. Nao esqueca de obter suas recompensas no Bau de Eventos no Templo de Crandoria.")
			end
		end
		Game.broadcastMessage("Hellsin foi derrotado pelos Defensores de Crandoria!", MESSAGE_EVENT_ADVANCE)
	end
	return true
end

hellsinDeath:register()