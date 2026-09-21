local argentusCorpse = Action()

function argentusCorpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso) == 21 then
		player:setStorageValue(Storage.Quest.Crandoria.Viridia.Haldor.Progresso, 22)
		player:say("Voce encontrou o corpo de Argentus!", TALKTYPE_MONSTER_SAY)
		return false
	else
		return false
	end
end

argentusCorpse:aid(13074)
argentusCorpse:register()