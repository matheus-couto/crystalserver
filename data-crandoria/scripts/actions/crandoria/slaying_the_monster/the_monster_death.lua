local config = {
	centerPosition = Position(5459, 4297, 12),
	rangeX = 10,
	rangeY = 10,
}

-- onDeath, registrado pelo `monster.events` de monster/bosses/the_monster.lua.
--
-- Era onKill, e estava registrado em dois lugares: no login de todo jogador
-- e no proprio monstro. Como nao conferia quem tinha morrido, completava a
-- quest para todos na arena sempre que qualquer jogador matasse qualquer
-- coisa ali - e, pelo registro no monstro, tambem quando The Monster matava
-- um jogador. Morrer para o boss dava a vitoria para o resto do grupo.
local event = CreatureEvent("themonsterDeath")

function event.onDeath(creature, corpse, killer, mostDamageKiller)
	if not getDeathCreditPlayer(mostDamageKiller) then
		return true
	end

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
