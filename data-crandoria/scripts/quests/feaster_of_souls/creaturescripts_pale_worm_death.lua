--  CRANDORIA EDIT --

local config = {
	centerPosition = Position(33805, 31504, 14),
	rangeX = 11,
	rangeY = 11,
}

local event = CreatureEvent("paleWormDeath")

function event.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.U12_30.PoltergeistOutfits.Received) ~= 1 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens. Voce recebeu o Poltergeist Outfit.")
				specCreature:addOutfit(1271, 0)
				specCreature:addOutfit(1270, 0)
				specCreature:setStorageValue(Storage.Quest.U12_30.PoltergeistOutfits.Received, 1)
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 151 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 152)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou a Pale Worm. Retorne ao Comandante Crassus e reporte sua missao.")
			end
			specCreature:addAchievement("Beyonder")
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 21 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
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


-- local config = {
-- 	centerPosition = Position(33805, 31504, 14),
-- 	rangeX = 11,
-- 	rangeY = 11,
-- }

-- local event = CreatureEvent("paleWormDeath")

-- function event.onPrepareDeath(creature)
-- 	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
-- 	for _, specCreature in pairs(spectators) do
-- 		if specCreature:isPlayer() then
-- 			if specCreature:getStorageValue(Storage.Quest.U12_30.PoltergeistOutfits.Received) == -1 then
-- 				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Poltergeist Outfit.")
-- 				specCreature:addOutfit(1271, 0)
-- 				specCreature:addOutfit(1270, 0)
-- 				specCreature:setStorageValue(Storage.Quest.U12_30.PoltergeistOutfits.Received, 1)
-- 			end
-- 			specCreature:addAchievement("Beyonder")
-- 		end
-- 	end

-- 	return true
-- end

-- event:register()
