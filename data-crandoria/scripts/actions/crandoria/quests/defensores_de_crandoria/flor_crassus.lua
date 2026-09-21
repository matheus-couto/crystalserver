local florCrassus = Action()

function florCrassus.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 9 then
		player:setStorageValue(Storage.Quest.Crandoria.BossRoom.MiniBossRoomTimer, os.time() + 10 * 60)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce coletou o extrato da flor.")
		return true
	end
end


florCrassus:aid(13149)
florCrassus:register()