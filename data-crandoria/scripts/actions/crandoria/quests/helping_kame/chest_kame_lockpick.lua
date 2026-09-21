local chestKame = Action()

function chestKame.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9168 then
		if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Progresso) < 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O bau esta trancado. Sera necessaria alguma ferramenta para abri-lo.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja abriu este bau.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	elseif item.itemid == 11540 then
		if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Esta caixa parece estar selada. Talvez com um lock pick voce consiga abri-la...")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) > 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja abriu a caixa.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		else
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	end
end


chestKame:aid(12395)
chestKame:register()