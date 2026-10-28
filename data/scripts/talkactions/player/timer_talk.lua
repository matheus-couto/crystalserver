local specialTimer = TalkAction("!timer")

-------------------------------------------------
-- JANELA PRINCIPAL
-------------------------------------------------
local function sendMainWindow(player)
    local window = ModalWindow{
        title = "Special Timer",
        message = "Escolha o tipo de cooldown que deseja visualizar:"
    }

    window:addButton("Timers", function()
        sendTimerWindow(player)
    end)

    window:addButton("Bosses", function()
        sendBossWindow(player)
    end)

    window:addButton("Cancelar")
    window:setDefaultEscapeButton("Cancelar")
    window:sendToPlayer(player)
end

-------------------------------------------------
-- JANELA: TIMERS (SCRIPT ORIGINAL)
-------------------------------------------------
function sendTimerWindow(player)
    local window = ModalWindow{
        title = "Timers",
        message = "Cheque seus Cooldowns"
    }

    -- window:addChoice("-----------------------")
    -- window:addChoice("-- Coleta --")

    -- if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.TimerMain) > os.time() then
    --     window:addChoice("Cultivo - Farming [" ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.TimerMain)) .. "]")
    -- else
    --     window:addChoice("Cultivo - Farming [ON]")
    -- end

    -- if player:getStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow) > os.time() then
    --     window:addChoice("Ordenha [" ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.FarmSystem.Cow)) .. "]")
    -- else
    --     window:addChoice("Ordenha [ON]")
    -- end

	-- if player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PigFeed) > os.time() then
    --     window:addChoice("Porcos [" ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.PigFeed)) .. "]")
    -- else
    --     window:addChoice("Porcos [ON]")
    -- end

	-- if player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.TimerMain) > os.time() then
    --     window:addChoice("Lago de Crandoria [ON] Fim: " ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.NovasColetas.TimerMain)) .. "")
    -- else
    --     window:addChoice("Lago de Crandoria [OFF]")
    -- end

    -- if player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.DefaultTimer) > os.time() then
    --     window:addChoice("Lumberjack [" ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.Lumberjack.DefaultTimer)) .. "]")
    -- else
    --     window:addChoice("Lumberjack [ON]")
    -- end

	-- if player:getVipDays() > 0 then
	-- 	window:addChoice("Minas [ON] - Vip")
	-- else
	-- 	if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) > os.time() or player:getVipDays() > 0 then
    --     	window:addChoice("Minas [ON] Fim: " ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining)) .. "]")
	-- 	else
	-- 		window:addChoice("Minas [OFF]")
	-- 	end
	-- end

    window:addChoice("-----------------------")
    window:addChoice("-- Quests e Desafios --")

	if player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown1) > os.time() then
        window:addChoice("Bomberman 2 Players [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown1)) .. "]")
    else
        window:addChoice("Bomberman 2 Players [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown2) > os.time() then
        window:addChoice("Bomberman 3 Players [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown2)) .. "]")
    else
        window:addChoice("Bomberman 3 Players [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown3) > os.time() then
        window:addChoice("Bomberman 4 Players [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.Bomberman.Cooldown3)) .. "]")
    else
        window:addChoice("Bomberman 4 Players [ON]")
    end

    if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer) > os.time() then
        window:addChoice("Crassus - Geral [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Timer)) .. "]")
    else
        window:addChoice("Crassus - Geral [ON]")
    end

    if player:getStorageValue(Storage.Quest.Crandoria.TheClimb.AncientTimer) > os.time() then
        window:addChoice("Escalada [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.TheClimb.AncientTimer)) .. "]")
    else
        window:addChoice("Escalada [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer) > os.time() then
        window:addChoice("Quest Dave Johnes [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.MissaoPesca.Timer)) .. "]")
    else
        window:addChoice("Quest Dave Johnes [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral) > os.time() then
        window:addChoice("Tibia Aram [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.TibiaAram.TimerGeral)) .. "]")
    else
        window:addChoice("Tibia Aram [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerGeral) > os.time() then
        window:addChoice("Tibia Clash [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.TibiaClash.TimerGeral)) .. "]")
    else
        window:addChoice("Tibia Clash [ON]")
    end

	-- if player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraDiaria) > os.time() then
	-- 	window:addChoice("Wilfred Storm [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraDiaria)) .."]")
	-- else
	-- 	window:addChoice("Wilfred Storm [ON]")
	-- end

    window:addChoice("-----------------------")
    window:addChoice("---- Itens | Outros ---")

    if player:getStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown) > os.time() then
        window:addChoice("Chaotic Jar [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.ArenaEspecial.Cooldown)) .. "]")
    else
        window:addChoice("Chaotic Jar [ON]")
    end

	if player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Progresso) >= 2 then
		if player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer) > os.time() then
			window:addChoice("Escambo [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.BugozdQuest.Timer)) .."]")
		else
			window:addChoice("Escambo [ON]")
		end	
	end

    if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick) > os.time() then
        window:addChoice("Lockpick [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.LockPick)) .. "]")
    else
        window:addChoice("Lockpick [ON]")
    end

	-- if player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk) > os.time() then
    --     window:addChoice("Passe Afk [ON] Fim: " ..
    --         os.date('%d/%m/%Y - %H:%M:%S',
    --         player:getStorageValue(Storage.Quest.Crandoria.PasseAntiafk)) .. "]")
    -- else
    --     window:addChoice("Passe Afk [OFF]")
    -- end

	if player:getStorageValue(Storage.Quest.Crandoria.PvpStatus.PvPHuntTimer) > os.time() then
		window:addChoice("Recompensa [ON] Fim: " .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Estacoes.QuestPrimaveraDiaria)) .."]")
	else
		window:addChoice("Recompensa [OFF]")
	end

    if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Stealing) > os.time() then
        window:addChoice("Tesoura do Ladrao [" ..
            os.date('%d/%m/%Y - %H:%M:%S',
            player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Stealing)) .. "]")
    else
        window:addChoice("Tesoura do Ladrao [ON]")
    end

    window:addButton("Voltar", function()
        sendMainWindow(player)
    end)

    window:addButton("Fechar")
    window:sendToPlayer(player)
end

-------------------------------------------------
-- JANELA: BOSSES
-------------------------------------------------
function sendBossWindow(player)
    local window = ModalWindow{
        title = "Boss Cooldowns",
        message = "Bosses disponiveis:"
    }

	window:addChoice("-----------------------")
	window:addChoice("-- Castelo de Azzilon --")

	local arbaziloth = player:getBossCooldown("arbaziloth")
	if arbaziloth > os.time() then
		window:addChoice("Arbaziloth [" .. os.date('%d/%m/%Y - %H:%M:%S', arbaziloth) .. "]")
	else
		window:addChoice("Arbaziloth [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("---- Cobra Bastion ----")
	
	if player:getStorageValue(Storage.GraveDanger.CobraBastion.ScarlettTimer) > os.time() then
		window:addChoice("Scarlett Etzel [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.GraveDanger.CobraBastion.ScarlettTimer)) .."]")
	else
		window:addChoice("Scarlett Etzel [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("------ Dracantus ------")

	if player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.BoneOverlordTimer) > os.time() then
		window:addChoice("Bone Overlord [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.RoostOfTheGraveborn.BoneOverlordTimer)) .."]")
	else
		window:addChoice("Bone Overlord [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.Crandoria.TwentyYearsCook.BossCooldown) > os.time() then
		window:addChoice("Dragon Pack [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.TwentyYearsCook.BossCooldown)) .."]")
	else
		window:addChoice("Dragon Pack [ON]")
	end

	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.FirstDragonTimer) > os.time() then
		window:addChoice("The First Dragon [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.FirstDragonTimer)) .."]")
	else
		window:addChoice("The First Dragon [ON]")
	end
	
	window:addChoice("-----------------------")
	window:addChoice("---- Dream Courts ----")

	if player:getStorageValue(Storage.Quest.U12_00.TheDreamCourts.FacelessBaneTime) > os.time() then
		window:addChoice("Faceless Bane [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_00.TheDreamCourts.FacelessBaneTime)) .."]")
	else
		window:addChoice("Faceless Bane [ON]")
	end

	if player:getStorageValue(Storage.Quest.U7_9.DreamersChallenge.TimerLever) > os.time() then
		window:addChoice("Arena Lever [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.DreamersChallenge.TimerLever)) .."]")
	else
		window:addChoice("Arena Lever [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("--- Falcons Bastion ---")	
	
	if player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.ChestsTimer.OberonCrandoriaTimer) > os.time() then
		window:addChoice("Oberon [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_80.TheSecretLibrary.FalconBastion.ChestsTimer.OberonCrandoriaTimer)) .."]")
	else
		window:addChoice("Oberon [ON]")
	end
	
	window:addChoice("-----------------------")
	window:addChoice("-- Feaster of Souls --")
	
	if player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.BrainHeadTimer) > os.time() then
		window:addChoice("Brain Head [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.BrainHeadTimer)) .."]")
	else
		window:addChoice("Brain Head [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.FearFeasterTimer) > os.time() then
		window:addChoice("The Fear Feaster [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.FearFeasterTimer)) .."]")
	else
		window:addChoice("The Fear Feaster [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.DreadMaidenTimer) > os.time() then
		window:addChoice("The Dread Maiden [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.DreadMaidenTimer)) .."]")
	else
		window:addChoice("The Dread Maiden [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.UnwelcomeTimer) > os.time() then
		window:addChoice("The Unwelcome [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.UnwelcomeTimer)) .."]")
	else
		window:addChoice("The Unwelcome [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.PaleWormTimer) > os.time() then
		window:addChoice("The Pale Worm [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_30.FeasterOfSouls.PaleWormTimer)) .."]")
	else
		window:addChoice("The Pale Worm [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Forgotten Knowledge --")
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisTimer) > os.time() then
		window:addChoice("Lady Tenebris [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisTimer)) .."]")
	else
		window:addChoice("Lady Tenebris [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydTimer) > os.time() then
		window:addChoice("Lloyd [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydTimer)) .."]")
	else
		window:addChoice("Lloyd [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightTimer) > os.time() then
		window:addChoice("Mounted Thorn Knight [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightTimer)) .."]")
	else
		window:addChoice("Mounted Thorn Knight [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingTimer) > os.time() then
		window:addChoice("Dragonking Zyrtarch [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingTimer)) .."]")
	else
		window:addChoice("Dragonking Zyrtarch [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.HorrorTimer) > os.time() then
		window:addChoice("Melting Frozen Horror [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.HorrorTimer)) .."]")
	else
		window:addChoice("Melting Frozen Horror [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianTimer) > os.time() then
		window:addChoice("The Time Guardian [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianTimer)) .."]")
	else
		window:addChoice("The Time Guardian [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreTimer) > os.time() then
		window:addChoice("The Last Lore Keeper [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreTimer)) .."]")
	else
		window:addChoice("The Last Lore Keeper [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Gnomprona --")
	
	if player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleTimer) > os.time() then
		window:addChoice("Magma Bubble [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleTimer)) .."]")
	else
		window:addChoice("Magma Bubble [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceTimer) > os.time() then
		window:addChoice("The Primal Menace [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceTimer)) .."]")
	else
		window:addChoice("The Primal Menace [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Grave Danger --")
	
	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaramTimer) > os.time() then
		window:addChoice("Lord Azaram [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaramTimer)) .."]")
	else
		window:addChoice("Lord Azaram [ON]")
	end


	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsamTimer) > os.time() then
		window:addChoice("Earl Osam [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsamTimer)) .."]")
	else
		window:addChoice("Earl Osam [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.DukeKruleTimer) > os.time() then
		window:addChoice("Duke Krule [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.DukeKruleTimer)) .."]")
	else
		window:addChoice("Duke Krule [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorthTimer) > os.time() then
		window:addChoice("Count Vlarkorth [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorthTimer)) .."]")
	else
		window:addChoice("Count Vlarkorth [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.BaelocNictrosTimer) > os.time() then
		window:addChoice("Sir Baeloc e Nitros [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.BaelocNictrosTimer)) .."]")
	else
		window:addChoice("Sir Baeloc e Nitros [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.KingZelosTimer) > os.time() then
		window:addChoice("King Zelos [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Bosses.KingZelosTimer)) .."]")
	else
		window:addChoice("King Zelos [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Heart of Destruction --")

	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.AnomalyTimer) > os.time() then
		window:addChoice("Anomaly [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.AnomalyTimer)) .."]")
	else
		window:addChoice("Anomaly [ON]")
	end

	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.RealityquakeTimer) > os.time() then
		window:addChoice("Realityquake [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.RealityquakeTimer)) .."]")
	else
		window:addChoice("Realityquake [ON]")
	end

	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.EradicatorTimer) > os.time() then
		window:addChoice("Eradicator [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.EradicatorTimer)) .."]")
	else
		window:addChoice("Eradicator [ON]")
	end

	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.OutburstTimer) > os.time() then
		window:addChoice("Outburst [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.OutburstTimer)) .."]")
	else
		window:addChoice("Outburst [ON]")
	end

	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.RuptureTimer) > os.time() then
		window:addChoice("Rupture [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.RuptureTimer)) .."]")
	else
		window:addChoice("Rupture [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer) > os.time() then
		window:addChoice("World Devourer [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U10_94.HeartOfDestruction.WorldDevourerTimer)) .."]")
	else
		window:addChoice("World Devourer [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Iks --")

	if player:getStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.AhauTimer) > os.time() then
		window:addChoice("Ahau [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.AdventuresOfGalthen.AhauTimer)) .."]")
	else
		window:addChoice("Ahau [ON]")
	end

	if player:getBossCooldown("Mitmah Vanguard") > os.time() then
		window:addChoice("Mitmah Vanguard [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Mitmah Vanguard")) .."]")
	else
		window:addChoice("Mitmah Vanguard [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Kilmaresh --")
	
	if player:getStorageValue(Storage.Kilmaresh.UrmahlulluTimer) > os.time() then
		window:addChoice("Urmahlullu [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Kilmaresh.UrmahlulluTimer)) .."]")
	else
		window:addChoice("Urmahlullu [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Lions Bastion --")
	
	if player:getStorageValue(Storage.TheOrderOfTheLion.Drume.Timer) > os.time() then
		window:addChoice("Drume [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.TheOrderOfTheLion.Drume.Timer)) .."]")
	else
		window:addChoice("Drume [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Lordes dos Mares --")
	
	if player:getStorageValue(Storage.Quest.Crandoria.Deeplings.TanjisTimer) > os.time() then
		window:addChoice("Tanjis [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Deeplings.TanjisTimer)) .."]")
	else
		window:addChoice("Tanjis [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.Deeplings.ObujosTimer) > os.time() then
		window:addChoice("Obujos [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Deeplings.ObujosTimer)) .."]")
	else
		window:addChoice("Obujos [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.Deeplings.JaulTimer) > os.time() then
		window:addChoice("Jaul [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Deeplings.JaulTimer)) .."]")
	else
		window:addChoice("Jaul [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.Deeplings.BrokulTimer) > os.time() then
		window:addChoice("Brokul [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.Deeplings.BrokulTimer)) .."]")
	else
		window:addChoice("Brokul [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("------- Marapur -------")

	if player:getStorageValue(Storage.Quest.U12_90.WithinTheTides.TimiraTimer) > os.time() then
		window:addChoice("Timira the Many-headed [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_90.WithinTheTides.TimiraTimer)) .."]")
	else
		window:addChoice("Timira the Many-headed [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Miniboss Grimvale --")

	if player:getBossCooldown("Black Vixen") > os.time() then
		window:addChoice("Black Vixen [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Black Vixen")) .."]")
	else
		window:addChoice("Black Vixen [ON]")
	end

	if player:getBossCooldown("Bloodback") > os.time() then
		window:addChoice("Bloodback [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Bloodback")) .."]")
	else
		window:addChoice("Bloodback [ON]")
	end

	if player:getBossCooldown("Darkfang") > os.time() then
		window:addChoice("Darkfang [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Dark Fang")) .."]")
	else
		window:addChoice("Dark Fang [ON]")
	end

	if player:getBossCooldown("Shadowpelt") > os.time() then
		window:addChoice("Shadowpelt [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Shadowpelt")) .."]")
	else
		window:addChoice("Shadowpelt [ON]")
	end

	if player:getBossCooldown("Sharpclaw") > os.time() then
		window:addChoice("Sharpclaw [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Sharpclaw")) .."]")
	else
		window:addChoice("Sharpclaw [ON]")
	end

	window:addChoice("------------------------")
	window:addChoice("-- Miniboss Werelions --")

	if player:getBossCooldown("Katex Blood Tongue") > os.time() then
		window:addChoice("Katex Blood Tongue [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Katex Blood Tongue")) .."]")
	else
		window:addChoice("Katex Blood Tongue [ON]")
	end

	if player:getBossCooldown("Srezz Yellow Eyes") > os.time() then
		window:addChoice("Srezz Yellow Eyes [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Srezz Yellow Eyes")) .."]")
	else
		window:addChoice("Srezz Yellow Eyes [ON]")
	end

	if player:getBossCooldown("Utua Stone Sting") > os.time() then
		window:addChoice("Utua Stone Sting [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Utua Stone Sting")) .."]")
	else
		window:addChoice("Utua Stone Sting [ON]")
	end

	if player:getBossCooldown("Yirkas Blue Scales") > os.time() then
		window:addChoice("Yirkas Blue Scales [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getBossCooldown("Yirkas Blue Scales")) .."]")
	else
		window:addChoice("Yirkas Blue Scales [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("-- Novo Continente --")

	if player:getStorageValue(Storage.Quest.Crandoria.PathToApocalypse.ApocalypseTimer) > os.time() then
		window:addChoice("Apocalypse [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.PathToApocalypse.ApocalypseTimer)) .."]")
	else
		window:addChoice("Apocalypse [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.NaturalTroubles.GaiaTimer) > os.time() then
		window:addChoice("Gaia [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.NaturalTroubles.GaiaTimer)) .."]")
	else
		window:addChoice("Gaia [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.TheCanyonChallenge.GoriathTimer) > os.time() then
		window:addChoice("Goriath [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.TheCanyonChallenge.GoriathTimer)) .."]")
	else
		window:addChoice("Goriath [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.OrobuusTimer) > os.time() then
		window:addChoice("Orobuus [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.DemonSlayer.OrobuusTimer)) .."]")
	else
		window:addChoice("Orobuus [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.SihrazzTimer) > os.time() then
		window:addChoice("Sihrazz [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.SihrazzTimer)) .."]")
	else
		window:addChoice("Sihrazz [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.HoradronTimer) > os.time() then
		window:addChoice("Son of Horadron [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.HoradronTimer)) .."]")
	else
		window:addChoice("Son of Horadron [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.TimerBoss) > os.time() then
		window:addChoice("The False God [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.TimerBoss)) .."]")
	else
		window:addChoice("The False God [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.TheHolyFlame.TheFlameGuardianTimer) > os.time() then
		window:addChoice("The Flame Guardian [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.TheHolyFlame.TheFlameGuardianTimer)) .."]")
	else
		window:addChoice("The Flame Guardian [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.BreakingTheIce.ReiGeladoTimer) > os.time() then
		window:addChoice("The Frozen King [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.BreakingTheIce.ReiGeladoTimer)) .."]")
	else
		window:addChoice("The Frozen King [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.TheGodfather.GodfatherTimer) > os.time() then
		window:addChoice("The Godfather [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.TheGodfather.GodfatherTimer)) .."]")
	else
		window:addChoice("The Godfather [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.AbominationTimer) > os.time() then
		window:addChoice("The Island Abomination [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.AstralisTales.AbominationTimer)) .."]")
	else
		window:addChoice("The Island Abomination [ON]")
	end

	if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.ZarabastanTimer) > os.time() then
		window:addChoice("Zarabastan [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.ZarabastanTimer)) .."]")
	else
		window:addChoice("Zarabastan [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("------ Oskayaat -------")

	if player:getStorageValue(Storage.Grimvale.AyanaTimer) > os.time() then
		window:addChoice("Ayana the Crimson Curse [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Grimvale.AyanaTimer)) .."]")
	else
		window:addChoice("Ayana the Crimson Curse [ON]")
	end

	if player:getStorageValue(Storage.Grimvale.TamruTimer) > os.time() then
		window:addChoice("Tamru the Black [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Grimvale.TamruTimer)) .."]")
	else
		window:addChoice("Tamru the Black [ON]")
	end
		
	window:addChoice("-- Soul War Bosses --")

	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarHatredTimer) > os.time() then
		window:addChoice("Goshnars Hatred [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarHatredTimer)) .."]")
	else
		window:addChoice("Goshnars Hatred [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMaliceTimer) > os.time() then
		window:addChoice("Goshnars Malice [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMaliceTimer)) .."]")
	else
		window:addChoice("Goshnars Malice [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarSpiteTimer) > os.time() then
		window:addChoice("Goshnars Spite [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarSpiteTimer)) .."]")
	else
		window:addChoice("Goshnars Spite [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarCrueltyTimer) > os.time() then
		window:addChoice("Goshnars Cruelty [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarCrueltyTimer)) .."]")
	else
		window:addChoice("Goshnars Cruelty [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarGreedTimer) > os.time() then
		window:addChoice("Goshnars Greed [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarGreedTimer)) .."]")
	else
		window:addChoice("Goshnars Greed [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaTimer) > os.time() then
		window:addChoice("Goshnars Megalomania [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaTimer)) .."]")
	else
		window:addChoice("Goshnars Megalomania [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("------ Squidspot ------")

	if player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterTimer) > os.time() then
		window:addChoice("The Monster [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.SlayingTheMonster.TheMonsterTimer)) .."]")
	else
		window:addChoice("The Monster [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("---- Stag Bastion ----")
	
	if player:getStorageValue(Storage.Quest.Crandoria.StagBastion.CourtWarlockTimer) > os.time() then
		window:addChoice("Court Warlock [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.Crandoria.StagBastion.CourtWarlockTimer)) .."]")
	else
		window:addChoice("Court Warlock [ON]")
	end

	window:addChoice("-----------------------")
	window:addChoice("------ Vampiros ------")

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ArtheiTimer) > os.time() then
		window:addChoice("Arthei [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ArtheiTimer)) .."]")
	else
		window:addChoice("Arthei [ON]")
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer) > os.time() then
		window:addChoice("Boreth [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.BorethTimer)) .."]")
	else
		window:addChoice("Boreth [ON]")
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.LersatioTimer) > os.time() then
		window:addChoice("Lersatio [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.LersatioTimer)) .."]")
	else
		window:addChoice("Lersatio [ON]")
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.MarzielTimer) > os.time() then
		window:addChoice("Marziel [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.MarzielTimer)) .."]")
	else
		window:addChoice("Marziel [ON]")
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ZevelonTimer) > os.time() then
		window:addChoice("Zevelon [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.ZevelonTimer)) .."]")
	else
		window:addChoice("Zevelon [ON]")
	end

	if player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.VladrukhTimer) > os.time() then
		window:addChoice("Vladrukh [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U15_10.BloodyTusks.VladrukhTimer)) .."]")
	else
		window:addChoice("Vladrukh [ON]")
	end


	window:addChoice("-----------------------")
	window:addChoice("-- Warzones --")

	if player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone1) > os.time() then
		window:addChoice("Deathstrike [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone1)) .."]")
	else
		window:addChoice("Deathstrike [ON]")
	end

	if player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone2) > os.time() then
		window:addChoice("Gnomevil [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone2)) .."]")
	else
		window:addChoice("Gnomevil [ON]")
	end

	if player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone3) > os.time() then
		window:addChoice("Abyssador [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U9_60.BigfootsBurden.BossWarzone3)) .."]")
	else
		window:addChoice("Abyssador [ON]")
	end

	if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheBaronFromBelow) > os.time() then
		window:addChoice("The Baron From Below [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheBaronFromBelow)) .."]")
	else
		window:addChoice("The Baron From Below [ON]")
	end
	
	if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheCountOfTheCore) > os.time() then
		window:addChoice("The Count of the Core [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheCountOfTheCore)) .."]")
	else
		window:addChoice("The Count of the Core [ON]")
	end

	if player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheDukeOfTheDepths) > os.time() then
		window:addChoice("The Duke Of The Depths [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U11_50.DangerousDepths.Bosses.TheDukeOfTheDepths)) .."]")
	else
		window:addChoice("The Duke Of The Depths [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_70.TooHotToHandle.MegaMagmaoidTimer) > os.time() then
		window:addChoice("The Mega Magmaoid [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_70.TooHotToHandle.MegaMagmaoidTimer)) .."]")
	else
		window:addChoice("The Mega Magmaoid [ON]")
	end

	if player:getStorageValue(Storage.Quest.U12_70.TooHotToHandle.BrainstealerTimer) > os.time() then
		window:addChoice("The Brainstealer [" .. os.date('%d/%m/%Y - %H:%M:%S', player:getStorageValue(Storage.Quest.U12_70.TooHotToHandle.BrainstealerTimer)) .."]")
	else
		window:addChoice("The Brainstealer [ON]")
	end

    window:addButton("Voltar", function()
        sendMainWindow(player)
    end)

    window:addButton("Fechar")
    window:sendToPlayer(player)
end

-------------------------------------------------
-- COMANDO
-------------------------------------------------
function specialTimer.onSay(player, words, param)
    sendMainWindow(player)
    return true
end

specialTimer:groupType("normal")
specialTimer:register()