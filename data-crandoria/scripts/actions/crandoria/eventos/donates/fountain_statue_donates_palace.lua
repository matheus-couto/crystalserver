local palaceNoble = Action()


function palaceNoble.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local timeLeftMin1 = math.floor((player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioFountain) - os.time()) / 60)
	local timeLeftMin2 = math.floor((player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioStatue) - os.time()) / 60)

	local currentExpBoostTime = player:getExpBoostStamina()

	if item.itemid == 25411 then
		if player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioFountain) < os.time() then
			if player:getStamina() > 2400 then
				player:setStamina(2520)
				player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioFountain, os.time() + 2 * 24 * 60 * 60)
				player:say('Sua stamina foi completamente renovada!', TALKTYPE_MONSTER_SAY)
				return true
			else
				player:setStamina(player:getStamina() + 120)
				player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioFountain, os.time() + 2 * 24 * 60 * 60)
				player:say('Voce recebeu 2 horas de stamina!', TALKTYPE_MONSTER_SAY)
				return true
			end
		else
			player:say("Voce so pode usar a fonte novamente em " ..timeLeftMin1.. " minutos.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif item.itemid == 746 then
		if player:getStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioStatue) < os.time() then
			if player:getExpBoostStamina() < 3 * 60 * 60 then
				player:setStoreXpBoost(50)
				player:setExpBoostStamina(currentExpBoostTime + 60 * 60)
				player:say('Voce recebeu mais uma hora de Xp Boost.', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioStatue, os.time() + 24 * 60 * 60)
				return true
			else
				player:say('Voce ja possui mais de tres horas de Xp Boost acumuladas.', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.DonateRewards.PalacioStatue, os.time() + 24 * 60 * 60)
				return true
			end
		else
			player:say("Voce so pode usar a estatua novamente em " ..timeLeftMin2.. " minutos.", TALKTYPE_MONSTER_SAY)
			return true
		end
	end
end

palaceNoble:aid(13049)
palaceNoble:register()