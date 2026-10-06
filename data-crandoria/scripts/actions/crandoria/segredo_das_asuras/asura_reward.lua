local asuraReward = Action()

function asuraReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward) < 1 then
    	if player:getItemCount(3022) < 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Use uma Ancient Tiara para abrir o bau e obter a Reliquia das Asuras.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
        else
			player:addItem(30061, 3)
			player:addItem(28476, 1)
			player:removeItem(3022, 1)
			player:teleportTo(Position(5126, 4778, 15))
			player:setStorageValue(Storage.Quest.Crandoria.AsurasSecret.Reward, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce usou a Tiara para abrir o bau e obteve a recompensa, mas a Tiara se quebrou.")
			return true
		end
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja obteve a Reliquia.")
		return true
    end
end


asuraReward:uid(12317)
asuraReward:register()