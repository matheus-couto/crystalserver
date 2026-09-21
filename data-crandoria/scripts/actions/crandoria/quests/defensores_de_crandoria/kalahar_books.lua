local booksKalahar = Action()
function booksKalahar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 176 then
		if item:getPosition() == Position(5332, 5288, 13) then
			player:say('VOCE ENCONTROU OS DOCUMENTOS!', TALKTYPE_MONSTER_SAY)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou os documentos. Retorne a Kalahar.")
			player:setStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso, 177)
			return false
		else
			player:say('Nenhum documento importante aqui.', TALKTYPE_MONSTER_SAY)
			return false
		end
	end
end

booksKalahar:aid(13061)
booksKalahar:register()