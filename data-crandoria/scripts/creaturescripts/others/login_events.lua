local loginEvents = CreatureEvent("LoginEvents")
function loginEvents.onLogin(player)
	local events = {
		"RookgaardAdvance",
		--Quests
		--Cults Of Tibia Quest
		"HealthPillar",
		"YalahariHealth",
		"RottenBloodLogin",
		-- Crandoria
		"BossesRottenBloodKill",
		"CrandoriaApocalypseKill",
		"Ahau",
		"AhauDeath",
		-- Custom Events
		"TaskCreature",
		-- Timira Reward
		"Timira",
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
		-- Queen of Hearts Events
		"QueenofHearts",
		-- Zarabastan event
		"zarabastanDeath",
		-- Faceless Bane
		"facelessBaneDeath",
		-- Scarlett, Drume e Oberon
		"scarlettEtzelDeath",
		"drumeDeath",
		"grandMasterOberonDeath",
		"InquisitionBossKill",
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
		"themonsterDeath",
		"SoulWarKill",
		-- -- aramPvP
		-- "PlayerEventDeath",
		-- Viridia
		"mikarahDeath",
		"PythiusDeath",
		"SuonDeath",
		"SonofHoradronDeath",
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
