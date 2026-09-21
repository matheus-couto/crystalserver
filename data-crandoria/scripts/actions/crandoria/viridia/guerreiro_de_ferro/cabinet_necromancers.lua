local cabinetNecros = Action()

function cabinetNecros.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 13 then
		player:addItem(4846, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou os registros dos necromancers.")
		player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 14)
		return false
	else
		return false
	end

end

cabinetNecros:aid(13052)
cabinetNecros:register()