local config = {
	centerPosition = Position(33710, 31634, 14),
	rangeX = 11,
	rangeY = 11,
}

local event = CreatureEvent("megalomaniaDeath")

function event.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit) < 1 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens, voce recebeu o Revenant Outfit.")
				specCreature:addOutfit(1322, 0)
				specCreature:addOutfit(1323, 0)
				specCreature:setStorageValue(Storage.Quest.Crandoria.SoulWar.Outfit, 1)
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 157 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 158)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Goshnar's Megalomania. Reporte sua missao para o Comandante Crassus.")
			end
			if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.Outfit) == 5 then
				if player:getStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania) < 1 then
					player:setStorageValue(Storage.Quest.Crandoria.TheRedPath.KillMegalomania, 1)
				end
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

event:register()