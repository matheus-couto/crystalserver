local passeTeleports = Action()

function passeTeleports.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.TeleportRoom.Passe) < os.time() then
		player:setStorageValue(Storage.Quest.Crandoria.TeleportRoom.Passe, os.time() + 7 * 24 * 60 * 60)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce recebeu acesso ilimitado aos teleports de Hunts da Teleport Room por 1 semana.")
		item:remove(1)
		return true
	else
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Voce ja possui um passe ativo.")
		return true
	end
end

passeTeleports:id(8151)
passeTeleports:register()