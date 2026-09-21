local config = {
	centerPosition = Position(5313, 5413, 13),
	rangeX = 30,
	rangeY = 30,
}

local oblivionDeath = CreatureEvent("oblivionDeath")

function oblivionDeath.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 178 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou The Scourge Oblivion para Kalahar. Retorne ate ela e reporte sua missao.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 179)
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

oblivionDeath:register()