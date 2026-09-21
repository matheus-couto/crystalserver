local poisonDagger = Action()

function poisonDagger.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.itemid == 6031 then
		if player:getStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso) == 7 then
			target:transform(4215)
			player:setStorageValue(Storage.Quest.Crandoria.Viridia.WarmasterOutfits.Progresso, 8)
			player:addItem(36707, 1)
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Voce obteve o que parece ser um artefato de dentro do corpo.")
			return true
		else
			return true
		end
	end
end

poisonDagger:id(3299)
poisonDagger:register()

	