local candleQueen = Action()

function candleQueen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.Crandoria.DefensoresDeCrandoria.Progresso) == 146 then
		player:teleportTo(Position(5099, 4386, 10))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		return true
	end
	return true
end

candleQueen:aid(13031)
candleQueen:register()


local candleQueenStep = MoveEvent()

function candleQueenStep.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	player:teleportTo(Position(5101, 4405, 7))
	return true
end

candleQueenStep:aid(13031)
candleQueenStep:register()