local arbazilothOnDeath = CreatureEvent("azzilonCastleArbazilothOnDeath")

function arbazilothOnDeath.onDeath(creature)
	local bossName = creature:getName():lower()
	if bossName ~= "arbaziloth" and bossName ~= "weakened arbaziloth" then
		return false
	end
	Game.setStorageValue("globalArbazilothHeal", 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline) >= 1 then
			return false
		end
		if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Queslog) == 8 then
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.Queslog, 9)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Arbaziloth. Reporte a Lai.")
		end
		if bossName == "arbaziloth" then
			local currentStorage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline)
			if currentStorage < 1 then
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, 1)
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline, 1)
				-- if not player:hasOutfit(1809) or not player:hasOutfit(1808) then
					-- player:addOutfit(1809)
					-- player:addOutfit(1808)
				-- end
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Arbaziloth pela primeira vez. Reporte a Lai para receber uma recompensa.")
			elseif currentStorage >= 2 and currentStorage < 9 then
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, currentStorage + 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou Arbaziloth " .. (currentStorage + 1) .. " vezes.")
			elseif currentStorage == 9 then
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, 10)
				player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline, 2)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens! Voce derrotou Arbaziloth 10 vezes. Busque por uma (chave) com The Forgemaster.")
				local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
                player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep + 30)
                player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
			end
			local rep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, rep + 3)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		end
	end)

	return true
end

arbazilothOnDeath:register()
