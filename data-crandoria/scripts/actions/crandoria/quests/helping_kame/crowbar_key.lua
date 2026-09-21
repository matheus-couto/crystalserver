local crowbarKey = Action()
function crowbarKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Reward) < 1 then
		if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Crowbar) < 1 then
			player:setStorageValue(Storage.Quest.Crandoria.OldKame.Crowbar, 1)
			player:addItem(3304, 1, true)
			if player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) < 1 then
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Keys, 1)
				player:say("Voce encontrou uma das chaves reservas, a dentadura do Velho Kame e um Crowbar.", TALKTYPE_MONSTER_SAY)
			elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 1 then
				player:say("Voce encontrou mais uma das chaves reservas de Kame e um Crowbar.", TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.OldKame.Keys, 2)
			elseif player:getStorageValue(Storage.Quest.Crandoria.OldKame.Keys) == 2 then
				player:say("Voce encontrou a ultima das chaves reservas de Kame e um Crowbar.", TALKTYPE_MONSTER_SAY)
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

crowbarKey:uid(12332)
crowbarKey:register()