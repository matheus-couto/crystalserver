local asuraFlower = Action()

function asuraFlower.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == 9815 then
		if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) == 3 then
			player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress, 4)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			item:transform(9816)
			addEvent(function()
				item:transform(9815)
			end, 15 * 1000)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce regou a planta e ela rapidamente produziu flores! Voce coletou uma das flores.")
			return true
		elseif player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) > 4 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja recolheu uma flor.")
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao faz ideia do que esta fazendo.")
			return true
		end
    elseif item:getId() == 9816 then
		if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.QuestProgress) > 4 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja recolheu uma flor.")
			item:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		else
			item:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
    end
end


asuraFlower:aid(12360)
asuraFlower:register()