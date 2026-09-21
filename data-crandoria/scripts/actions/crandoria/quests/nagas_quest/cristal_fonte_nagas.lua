local cristalNagas = Action()

function cristalNagas.onUse(player, item, fromPosition, target, toPosition)

	if target.itemid == 25661 and target:getPosition() == Position(5802, 4347, 6) then
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 4 then
			item:remove(1)
			target:transform(25660)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou o poder da fonte.")
			player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 5)
			addEvent(function()
				target:transform(25661)
			end, 180000)
			return true
		else
			return true
		end
	end
		return true
end


cristalNagas:id(8829)
cristalNagas:register()