local config = {
	centerPosition = Position(4557, 5101, 14),
	rangeX = 9,
	rangeY = 7,
}

local eventWarlocks = CreatureEvent("zarabastanDeath")

function eventWarlocks.onDeath(creature)
	if creature:getName() == "Zarabastan" then
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, specCreature in pairs(spectators) do
			if specCreature:isPlayer() then
				if specCreature:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Outfit) < 1 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Dream Warden Outfit.")
					specCreature:addOutfit(578, 0)
					specCreature:addOutfit(577, 0)
					specCreature:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Outfit, 1)
					specCreature:setStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso, 7)
				end
				local storagePasse = specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso)
				if (storagePasse >= 16 and storagePasse < 21) and specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item) == 1 then
					if storagePasse == 16 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Grand Master Oberon 1 vez para a missao do Passe de Batalha.")
					elseif storagePasse == 17 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Grand Master Oberon 2 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 18 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Grand Master Oberon 3 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 19 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Grand Master Oberon 4 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 20 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce completou sua missao do Passe de Batalha.")
					end
					specCreature:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, storagePasse + 1)
				end
				if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 28 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
					specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
				end
				local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
				specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 2)
				specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			end
		end
	end

	return true
end

eventWarlocks:register()