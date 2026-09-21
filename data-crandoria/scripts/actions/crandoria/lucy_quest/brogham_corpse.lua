local corpseBorghan = Action()

function corpseBorghan.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

	-- if item:getPosition() == Position(5271, 5201, 8) then
		if player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso) == 1 then
			player:setStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso, 2)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o corpo de Borghan, pai de Lucy.")
			return true
		elseif player:getStorageValue(Storage.Quest.Crandoria.LucyQuest.Progresso) < 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parece que alguem foi morto por uma Giant Spider, mas voce nao sabe quem pode ser.")
			return true
		end

	-- end

end

corpseBorghan:aid(13167)
corpseBorghan:register()