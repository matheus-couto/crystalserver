local loginEvents = CreatureEvent("LoginEvents")
function loginEvents.onLogin(player)
	-- Os eventos de morte de boss (Ahau, Timira, Queen of Hearts, Viridia,
	-- Soul War, Inquisition, Apocalypse, The Monster) e o TaskCreature nao
	-- ficam mais aqui. Eram onKill registrados no jogador, que o servidor
	-- chama em TODA morte que o jogador causa - doze chamadas e doze avisos
	-- no log por rotworm. Viraram onDeath registrado no proprio monstro, cada
	-- um no seu arquivo.
	local events = {
		"RookgaardAdvance",
		--Quests
		--Cults Of Tibia Quest
		"HealthPillar",
		"YalahariHealth",
		"RottenBloodLogin",
		-- Crandoria
		"BossesRottenBloodKill",
		"AhauDeath",
		-- King Zelos
		"zelosDeath",
		-- Pale Worm
		"paleWormDeath",
		-- Antibot
		"AntiAfk",
		-- Asuras Secret
		"asuraFrostDeath",
		"asuraFireDeath",
		"asuraMidnightDeath",
		-- Zarabastan event
		"zarabastanDeath",
		-- Faceless Bane
		"facelessBaneDeath",
		-- Scarlett, Drume e Oberon
		"scarlettEtzelDeath",
		"drumeDeath",
		"grandMasterOberonDeath",
		-- -- Groguron
		-- "groguronDeath",
		-- -- percht queen
		-- "perchtQueenDeath",
		-- -- aram
		-- "massiveAnviTowerDeath",
		-- "massiveChaosTowerDeath",
		-- "anvilluxTotemDeath",
		-- "chaosTotemDeath",
		-- scourge of oblivion
		"oblivionDeath",
		-- -- aramPvP
		-- "PlayerEventDeath",
		-- clash
		"crandoriaTotemDeath",
		"umbraTotemDeath",
	}

	for i = 1, #events do
		player:registerEvent(events[i])
	end
	return true
end

loginEvents:register()
