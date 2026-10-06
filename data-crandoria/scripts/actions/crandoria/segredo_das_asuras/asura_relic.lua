local asuraRelic = Action()

function asuraRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 7 then
		player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 8)
		player:addItem(3022, 1)
		player:addItem(3220, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou uma Ancient Tiara e uma carta enderecada a Kamila.")
		return true
    elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 8 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja pegou o item.")
		return true
    else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe como desvendar o segredo do sarcofago.")
		return true
    end
end


asuraRelic:aid(12366)
asuraRelic:register()