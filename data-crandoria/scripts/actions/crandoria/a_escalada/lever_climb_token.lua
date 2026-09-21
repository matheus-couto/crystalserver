local candleQueen = Action()

function candleQueen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getPosition() == Position(4183, 5153, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.TheClimb.AncientTimer) < os.time() and player:getStorageValue(Storage.Quest.Crandoria.TheClimb.MainTimer) < os.time() then
			if player:getLevel() < 150 then
				if player:removeItem(22721, 1) then
					player:teleportTo(Position(4167, 5158, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				else
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa de 2 gold tokens para acessar A Escalada no seu nivel atual.")
					return true
				end 
			elseif player:getLevel() >= 150 and player:getLevel() < 250 then
				if player:removeItem(22721, 2) then
					player:teleportTo(Position(4167, 5158, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				else
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa de 3 gold tokens para acessar A Escalada no seu nivel atual.")
					return true
				end 
			elseif player:getLevel() >= 250 and player:getLevel() < 500 then
				if player:removeItem(22721, 3) then
					player:teleportTo(Position(4167, 5158, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				else
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa de 4 gold tokens para acessar A Escalada no seu nivel atual.")
					return true
				end 
			elseif player:getLevel() >= 500 and player:getLevel() < 700 then
				if player:removeItem(22721, 4) then
					player:teleportTo(Position(4167, 5158, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				else
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa de 5 gold tokens para acessar A Escalada no seu nivel atual.")
					return true
				end 
			else
				if player:removeItem(22721, 5) then
					player:teleportTo(Position(4167, 5158, 7))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(Storage.Quest.Crandoria.TheClimb.Start, 0)
				else
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa de 6 gold tokens para acessar A Escalada no seu nivel atual.")
					return true
				end 
			end
		else
			player:sendTextMessage(MESSAGE_GAME_HIGHLIGHT, "Voce precisa aguardar para acessar esse desafio novamente.")
			return true
		end
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	return true
end

candleQueen:aid(13034)
candleQueen:register()