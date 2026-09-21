local fireAltar = Action()

function fireAltar.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getItemCount(9647) >= 1 then
		player:teleportTo(Position(4456, 5551, 11))
		player:removeItem(9647, 1)
		player:sendCancelMessage("Voce pagou o sacrificio e foi levado as profundezas.")
		return false
	else
		player:sendCancelMessage("Voce precisa pagar o sacrificio.")
		return false
	end
end

fireAltar:aid(13085)
fireAltar:register()