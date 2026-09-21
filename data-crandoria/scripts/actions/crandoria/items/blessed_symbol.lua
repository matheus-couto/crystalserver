local blessedSymbol = Action()

function blessedSymbol.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local storage = player:getStorageValue(Storage.Quest.Crandoria.ItensCrandoria.BlessedSymbol)

	if storage < os.time() then
		player:setStorageValue(Storage.Quest.Crandoria.ItensCrandoria.BlessedSymbol, os.time() + 14 * 24 * 60 * 60)
		item:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ativou o Blessed Symbol e agora tera 75% de desconto em suas Bless por 2 semanas.")
		return true
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja possui um efeito ativado.")
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	return true
end

blessedSymbol:id(11468)
blessedSymbol:register()