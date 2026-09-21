local chestNagasCarregamento = Action()

function chestNagasCarregamento.onUse(player, item, fromPosition, target, toPosition)

	if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso) == 8 then
		player:setStorageValue(Storage.Quest.Crandoria.NagasQuest.Progresso, 9)
		if player:getStorageValue(Storage.Quest.Crandoria.NagasQuest.Timer) > os.time() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce pegou o carregmento.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce pegou o carregamento, mas ele parece ter estragado. Retorne a Comandante Sivyna.")
			return true
		end
	end
end		
			

chestNagasCarregamento:uid(12406)
chestNagasCarregamento:register()