local skeletonNagas = Action()

function skeletonNagas.onUse(player, item, fromPosition, target, toPosition)

	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 3 then
		player:addItem(8829, 1)
		player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 4)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou o Cristal da Luz e o corpo de Ghuror.")
		return true
	else
		return true
	end
end


skeletonNagas:aid(13127)
skeletonNagas:register()