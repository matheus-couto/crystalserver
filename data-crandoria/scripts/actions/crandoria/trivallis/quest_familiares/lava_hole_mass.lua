local lavaHole = Action()

function lavaHole.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not player then
		return true
	end

	if player:getStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso) == 8 then
		player:addItem(9147, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você coletou um pouco de massa vulcanica.")
		player:setStorageValue(Storage.Quest.Crandoria.QuestFamiliares.Progresso, 9)
		return true
	end
end

lavaHole:aid(13181)
lavaHole:register()