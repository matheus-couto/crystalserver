local tinderBox = Action()
function tinderBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storageTinder = player:getStorageValue(Storage.Quest.Crandoria.MontariaUrsagrodon.TinderBox)
	if player:getStorageValue(Storage.Quest.Crandoria.MontariaUrsagrodon.TinderBoxTimer) < os.time() then
		if player:getStorageValue(Storage.Quest.Crandoria.MontariaUrsagrodon.TinderBox) < 2 then
			player:addItem(20357, 1, true)
			player:setStorageValue(Storage.Quest.Crandoria.MontariaUrsagrodon.TinderBoxTimer, os.time() + 20 * 60 * 60)
			player:setStorageValue(Storage.Quest.Crandoria.MontariaUrsagrodon.TinderBox, storageTinder + 1)
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja pegou todas as Tinder Box que podia.")
			return true
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode pegar 1 Tinder Box a cada 20 horas.")
		return true
	end
end

tinderBox:uid(12342)
tinderBox:register()