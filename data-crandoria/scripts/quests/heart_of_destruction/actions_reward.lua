local heartDestructionReward = Action()
function heartDestructionReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.uid == 1038 then
		if player:getStorageValue(45357) < 1 then
			local container = player:addItem(23525)
			container:addItem(23512, 1)
			container:addItem(23538, 1)
			container:addItem(23536, 1)
			container:addItem(23509, 1)
			container:addItem(3043, 20)
			container:addItem(22721, 5)
			player:setStorageValue(45357, 1)
			player:addAchievement("Ender of the End")
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found an energetic backpack.")
			local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
			player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 15)
			player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
		end
	end

	return true
end

heartDestructionReward:uid(1038)
heartDestructionReward:register()