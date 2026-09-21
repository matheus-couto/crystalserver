local vialMinotaur = Action()

function vialMinotaur.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso) == 3 then
		if target.itemid == 25846 or target.itemid == 25845 then
			item:transform(18992)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encheu o frasco com o sangue do Minotaur Idol")
			player:setStorageValue(Storage.Quest.Crandoria.TheFalseGod.Progresso, 4)
			return true
		end
	end

end

vialMinotaur:id(18991)
vialMinotaur:register()