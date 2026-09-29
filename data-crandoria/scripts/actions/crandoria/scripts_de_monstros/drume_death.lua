local config = {
	centerPosition = Position(5255, 4485, 7),
	rangeX = 19,
	rangeY = 19,
}

local event = CreatureEvent("drumeDeath")

function event.onDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, specCreature in pairs(spectators) do
		if specCreature:isPlayer() then
			if specCreature:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 94 then
				specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Drume a pedido de Romella. Seu proximo alvo sera Grand Master Oberon.")
				specCreature:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 95)
			end
			local storagePasse = specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso)
			if (storagePasse >= 16 and storagePasse < 21) and specCreature:getStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Item) == 2 then
				if storagePasse == 16 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Drume 1 vez para a missao do Passe de Batalha.")
				elseif storagePasse == 17 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Drume 2 vezes para a missao do Passe de Batalha.")
				elseif storagePasse == 18 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Drume 3 vezes para a missao do Passe de Batalha.")
				elseif storagePasse == 19 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Drume 4 vezes para a missao do Passe de Batalha.")
				elseif storagePasse == 20 then
					specCreature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce completou sua missao do Passe de Batalha.")
				end
				specCreature:setStorageValue(Storage.Quest.Crandoria.PasseDeBatalha.Progresso, storagePasse + 1)
			end
			if specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Boss) == 9 and specCreature:getStorageValue(Storage.Quest.Crandoria.BossTasks.Count) < 1 then
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

-- O drumeDeath nao estava em monster.events do Drume, so no login de todo
-- jogador. Registrado no jogador, o onDeath dispara quando O JOGADOR morre:
-- a etapa 94 -> 95 dos Defensores de Crandoria e a contagem do Passe de
-- Batalha so andavam quando alguem morria com outro jogador parado na arena,
-- e nunca ao matar o Drume. Agora e registrado no boss.
local startup = GlobalEvent("drumeDeathStartup")
function startup.onStartup()
	registerDeathEvent("drumeDeath", { "Drume" })
	return true
end
startup:register()
