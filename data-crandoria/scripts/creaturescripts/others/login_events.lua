local loginEvents = CreatureEvent("LoginEvents")
function loginEvents.onLogin(player)
	-- Os eventos de morte de boss (Ahau, Timira, Queen of Hearts, Viridia,
	-- Soul War, Inquisition, Apocalypse, The Monster) e o TaskCreature nao
	-- ficam mais aqui. Eram onKill registrados no jogador, que o servidor
	-- chama em TODA morte que o jogador causa - doze chamadas e doze avisos
	-- no log por rotworm. Viraram onDeath registrado no proprio monstro, cada
	-- um no seu arquivo.
	-- Eventos de MORTE DE BOSS nao entram aqui. Registrado no jogador, um
	-- onDeath dispara quando o proprio jogador morre - em qualquer lugar.
	-- Os scripts desses bosses varrem uma arena fixa e dao progresso e
	-- reputacao a quem esta la, entao cada morte no servidor pagava quem
	-- estivesse parado nas arenas. Eles ficam registrados so no boss, via
	-- monster.events ou onStartup.
	local events = {
		"RookgaardAdvance",
		--Quests
		--Cults Of Tibia Quest
		"HealthPillar",
		"YalahariHealth",
		"RottenBloodLogin",
		-- Crandoria
		-- Morte do proprio jogador: conta para o teste PvP do Crassus.
		"CrassusPvpDeath",
		-- Antibot
		"AntiAfk",
		-- -- Groguron
		-- "groguronDeath",
		-- -- percht queen
		-- "perchtQueenDeath",
		-- -- aram
		-- "massiveAnviTowerDeath",
		-- "massiveChaosTowerDeath",
		-- "anvilluxTotemDeath",
		-- "chaosTotemDeath",
		-- -- aramPvP
		-- "PlayerEventDeath",
	}

	for i = 1, #events do
		player:registerEvent(events[i])
	end
	return true
end

loginEvents:register()
