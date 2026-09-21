local tileTower = MoveEvent()


function tileTower.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) < 10 then
		player:teleportTo(Position(5093, 4486, 7))
		player:say('Voce nao tem assuntos para tratar aqui.', TALKTYPE_MONSTER_SAY)
		return true
	elseif player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso) == 10 then
		if player:getOutfit().lookType == 139 or player:getOutfit().lookType == 131 then
			if player:getOutfit().lookBody == 98 and player:getOutfit().lookLegs == 95 and player:getOutfit().lookFeet == 57 then
				player:say('Voce conseguiu se passar por guarda.', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Progresso, 11)
				return true
			else
				player:teleportTo(Position(5093, 4497, 7))
				player:say('Voce foi preso sob suspeita de tentar se passar por guarda. Da proxima vez, utilize as cores certas.', TALKTYPE_MONSTER_SAY)
				addEvent(function()
					player:teleportTo(Position(5093, 4486, 7))
					player:say("Voce foi solto por falta de evidencias.", TALKTYPE_MONSTER_SAY, false, nil, player:getPosition())
				end, 15 * 1000)
			end
			return true
		else
			player:teleportTo(Position(5093, 4486, 7))
			player:say('Voce deve usar os mesmos outfits dos guardas, ou eles podem suspeitar.', TALKTYPE_MONSTER_SAY)
		end
	else
		return true
	end
end

tileTower:aid(13027)
tileTower:register()