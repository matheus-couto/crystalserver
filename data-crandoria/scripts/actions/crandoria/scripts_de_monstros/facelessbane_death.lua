local config = {
	centerPosition = Position(4817, 5322, 13),
	rangeX = 12,
	rangeY = 12,
}

local event = CreatureEvent("facelessBaneDeath")

function event.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 80 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Faceless Bane. Retorne a Hugo e reporte sua missao.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 81)
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 4 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

event:register()