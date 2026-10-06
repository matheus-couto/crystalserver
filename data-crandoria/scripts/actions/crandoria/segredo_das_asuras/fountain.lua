local asuraFountain = Action()

function asuraFountain.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 2 then
		player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 3)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce coletou um pouco da Agua Sagrada das Asuras.")
		return true
    else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao faz ideia do que esta fazendo.")
		return true
    end
end


asuraFountain:aid(12359)
asuraFountain:register()