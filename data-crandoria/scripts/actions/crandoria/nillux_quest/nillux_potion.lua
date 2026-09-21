local nilluxPotion = Action()

function nilluxPotion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

	player:setStorageValue(Storage.Quest.Crandoria.NilluxQuest.TimerEffect, os.time() + 15 * 24 * 60 * 60)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce consumiu uma pocao Nillux e recebeu acesso a todos os teleports da TP room e aos World Teleports livremente por 15 dias.")
	item:remove()
	return true

end

nilluxPotion:id(28495)
nilluxPotion:register()