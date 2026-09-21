local sodomaCults = TalkAction("sodoma")

function sodomaCults.onSay(player, words, param)

	if isPlayerInArea(Position(4985, 5222, 13), Position(4989, 5229, 13)) then
		local tpPos = Position(4987, 5223, 13)
		local tp = Tile(tpPos):getItemById(34111)
		if tp then
			return false
		else
			local newTp = Game.createItem(34111, 1, tpPos)
			if newTp then
				newTp:setDestination(Position(4969, 5209, 14))
			end
			addEvent(function()
				Tile(tpPos):getPosition():sendMagicEffect(CONST_ME_POFF)
				newTp:remove()
			end, 5000)
			return false
		end
	end
	
	return false
end

sodomaCults:groupType("normal")
sodomaCults:register()