local config = {
	centerPosition = Position(5129, 5241, 15),
	rangeX = 12,
	rangeY = 12,
}

local KingzelosDeath = CreatureEvent("zelosDeath")

function KingzelosDeath.onPrepareDeath(creature)
	if creature:getName() == "King Zelos" then
		local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
		for _, specCreature in pairs(spectators) do
			if specCreature:isPlayer() then
				if specCreature:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.InquisitionOutfitReceived) ~= 1 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Hand of the Inquisition Outfit.")
					specCreature:addOutfit(1244, 0)
					specCreature:addOutfit(1243, 0)
					local storageRep = specCreature:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
					specCreature:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 1)
					specCreature:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
					specCreature:setStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.InquisitionOutfitReceived, 1)
					specCreature:addAchievement("Inquisition's Hand")
				end
				local storagePasse = specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso)
				if (storagePasse >= 16 and storagePasse < 21) and specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item) == 5 then
					if storagePasse == 16 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou King Zelos 1 vez para a missao do Passe de Batalha.")
					elseif storagePasse == 17 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou King Zelos 2 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 18 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou King Zelos 3 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 19 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou King Zelos 4 vezes para a missao do Passe de Batalha.")
					elseif storagePasse == 20 then
						specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce completou sua missao do Passe de Batalha.")
					end
					specCreature:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, storagePasse + 1)
				end
				if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 2 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
					specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
				end
			end
		end
	end

	return true
end

KingzelosDeath:register()
