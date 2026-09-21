-- local config = {
-- 	centerPosition = Position(5459, 4297, 12),
-- 	rangeX = 10,
-- 	rangeY = 10,
-- }

-- local event = CreatureEvent("themonsterDeath")

-- function event.onPrepareDeath(creature)
-- 	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
-- 	for _, specCreature in pairs(spectators) do
-- 		if specCreature:isPlayer() then
-- 			if specCreature:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled) < 1 then
-- 				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You slayed The Monster.")
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled, 1)
-- 			end
-- 			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 154 then
-- 				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 155)
-- 				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Doctor Marrow. Reporte sua missao para o Comandante Crassus.")
-- 			end
-- 		end
-- 	end

-- 	return true
-- end

-- event:register()


local config = {
	centerPosition = Position(5459, 4297, 12),
	rangeX = 10,
	rangeY = 10,
}

local event = CreatureEvent("themonsterDeath")

function event.onKill(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled) < 1 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You slayed The Monster.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterKilled, 1)
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 154 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 155)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Doctor Marrow. Reporte sua missao para o Comandante Crassus.")
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 28 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
				specCreature:setStorageValue(Storage.Quest.Crandoria.BossTasks.Count, 1)
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o boss para Thorwulf.")
			end
		end
	end

	return true
end

event:register()