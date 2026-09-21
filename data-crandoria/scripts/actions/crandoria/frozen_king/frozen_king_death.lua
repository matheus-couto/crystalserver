local config = {
	centerPosition = Position(5004, 5527, 12),
	rangeX = 10,
	rangeY = 10,
}

local event = CreatureEvent("frozenKingDeath")

function event.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestType) == 12 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount, specCreature:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraCount) + 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Frozen King para a missao de Wilfred Storm.")
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso) == 2 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.Progresso, 3)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Frozen King em nome da Sociedade de Astralis.")
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 12 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
			local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 3)
			specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end

	return true
end

event:register()