local lordRetroDeath = CreatureEvent("LordRetroMonsterDeath")

function lordRetroDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		if not player then
			return true
		end

		local storage = player:getStorageValue(Storage.Quest.Crandoria.BossRoom.Outfit)
		local chance = math.random(1, 7)

		if storage > 0 then
			return true
		else
			if chance == 1 then
				player:addOutfit(963)
				player:addOutfit(962)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Warrior Outfit")
				return true
			elseif chance == 2 then
				player:addOutfit(965)
				player:addOutfit(964)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Summoner Outfit")
			elseif chance == 3 then
				player:addOutfit(967)
				player:addOutfit(966)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Nobleman/Noblewoman Outfit")
				return true
			elseif chance == 4 then
				player:addOutfit(969)
				player:addOutfit(968)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Mage Outfit")
				return true
			elseif chance == 5 then
				player:addOutfit(971)
				player:addOutfit(970)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Knight Outfit")
				return true
			elseif chance == 6 then
				player:addOutfit(973)
				player:addOutfit(972)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Hunter Outfit")
				return true
			elseif chance == 7 then
				player:addOutfit(975)
				player:addOutfit(974)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce derrotou o Lord Retro e recebeu como recompensa especial o Retro Citizen Outfit")
				return true
			end
		end
		return true

		-- local hasOutfit = player:hasOutfit(1460) and player:hasOutfit(1461)


		-- if not hasOutfit then
		-- 	player:addOutfit(1460)
		-- 	player:addOutfit(1461)
		-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Formal Dress outfit.")
		-- end
	end)
	return true
end

lordRetroDeath:register()
