local asuraTomb = Action()

function asuraTomb.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 6 then
		player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 7)
		player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.AccessDoor, 2)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou um pergaminho com informacoes de como abrir as portas do santuario ao sul.")
		return true
    elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 7 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja descobriu o segredo escondido aqui.")
		return true
    else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao faz ideia do que esta fazendo")
		return true
    end
end


asuraTomb:aid(12364)
asuraTomb:register()