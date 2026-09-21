local vampCastleSecrets = Action()
function vampCastleSecrets.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(Position(4401, 5447, 7))

	if item:getPosition() == Position(4410, 5436, 5) then
		local itemOnTile = tile:getItemById(162)
		if itemOnTile then
			itemOnTile:transform(167)
			addEvent(function()
				itemOnTile:transform(162)
			end, 60 * 1000)
		end
		player:say('CLICK!', TALKTYPE_MONSTER_SAY)
		return true
	elseif item:getPosition() == Position(4365, 5452, 8) then
		player:teleportTo(Position(4365, 5450, 9))
		return false
	end
	return false
end


vampCastleSecrets:aid(13062)
vampCastleSecrets:register()