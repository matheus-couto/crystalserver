local trayKey = Action()
function trayKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Reward) < 1 then
		if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Tray) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.OldKame.Tray, 1)
			player:say("Voce encontrou uma das chaves reservas de Kame.", TALKTYPE_MONSTER_SAY)
			if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) < 1 then
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Keys, 1)
				player:say("Voce encontrou uma das chaves reservas e a dentadura do velho Kame.", TALKTYPE_MONSTER_SAY)
			elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 1 then
				player:say("Voce encontrou mais uma das chaves reservas de Kame.", TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Keys, 2)
			elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 2 then
				player:say("Voce encontrou mais uma das chaves reservas do velho Kame!", TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Keys, 3)
			end
		else
			player:say("Voce ja pegou a chave que estava aqui.", TALKTYPE_MONSTER_SAY)
		end

	else
		player:say("Kame nao precisa mais de ajuda com isso.", TALKTYPE_MONSTER_SAY)
	end
	return true
end

trayKey:uid(12345)
trayKey:register()