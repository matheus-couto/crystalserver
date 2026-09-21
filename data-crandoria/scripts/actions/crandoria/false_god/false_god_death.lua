local config = {
	centerPosition = Position(5220, 4388, 15),
	rangeX = 8,
	rangeY = 8,
}

local event = CreatureEvent("falseGodDeath")

function event.onDeath(creature)
	if creature:getName() == "The False God" then
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, specCreature in pairs(spectators) do
			if specCreature:isPlayer() then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou The False God. Reporte a Vekandor sobre sua conquista.")
				if specCreature:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 9 then
					specCreature:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 10)
				end
				if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 10 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
					specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
				end
				local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
				specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			end
		end
	end
	return true
end

event:register()